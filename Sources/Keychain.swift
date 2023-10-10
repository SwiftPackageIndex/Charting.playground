import Foundation

public enum Keychain {
    // via https://www.advancedswift.com/secure-private-data-keychain-swift/

    public enum Error: Swift.Error {
        case duplicateItem
        case itemNotFound
        case invalidItemFormat
        case unexpectedStatus(OSStatus)
    }

    public enum AttributeClass: RawRepresentable {
        case password

        public init?(rawValue: CFString) {
            switch rawValue {
                case kSecClassGenericPassword:
                    self = .password
                default:
                    return nil
            }
        }

        public var rawValue: CFString {
            switch self {
                case .password:
                    return kSecClassGenericPassword
            }
        }
    }

    static func query(service: String, account: String, attributeClass: AttributeClass = .password) -> [String: AnyObject] {
        [
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: attributeClass.rawValue,
        ]
    }

    static func attributes(data: Data) -> [String: AnyObject] {
        [kSecValueData as String: data as AnyObject]
    }

    public static func add(data: Data, service: String, account: String) throws {
        let query = query(service: service, account: account)
            .merging(
                [kSecValueData as String: data as AnyObject], uniquingKeysWith: { _, last in last}
            )

        let status = SecItemAdd(query as CFDictionary, nil)

        if status == errSecDuplicateItem {
            throw Error.duplicateItem
        }

        guard status == errSecSuccess else {
            throw Error.unexpectedStatus(status)
        }
    }

    public static func update(data: Data, service: String, account: String) throws {
        let status = SecItemUpdate(
            query(service: service, account: account) as CFDictionary,
            attributes(data:data) as CFDictionary
        )

        guard status != errSecItemNotFound else {
            throw Error.itemNotFound
        }

        guard status == errSecSuccess else {
            throw Error.unexpectedStatus(status)
        }
    }

    public static func readData(service: String, account: String) throws -> Data {
        let query = query(service: service, account: account)
            .merging(
                [
                    // kSecMatchLimitOne indicates keychain should read
                    // only the most recent item matching this query
                    kSecMatchLimit as String: kSecMatchLimitOne,
                    // kSecReturnData is set to kCFBooleanTrue in order
                    // to retrieve the data for the item
                    kSecReturnData as String: kCFBooleanTrue
                ], uniquingKeysWith: { _, last in last}
            )

        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &itemCopy)
        switch status {
            case errSecSuccess:
                break // ok
            case errSecItemNotFound:
                throw Error.itemNotFound
            default:
                throw Error.unexpectedStatus(status)
        }

        guard let password = itemCopy as? Data else {
            throw Error.invalidItemFormat
        }

        return password
    }

    public static func readString(service: String, account: String) throws -> String {
        try String(decoding: readData(service: service, account: account), as: UTF8.self)
    }

    public static func delete(service: String, account: String) throws {
        let status = SecItemDelete(query(service: service, account: account) as CFDictionary)

        guard status == errSecSuccess else {
            throw Error.unexpectedStatus(status)
        }
    }
}
