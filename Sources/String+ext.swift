import Foundation


extension String {
    public var urlEncoded: String? {
        addingPercentEncoding(withAllowedCharacters: .urlAllowed)
    }
}
