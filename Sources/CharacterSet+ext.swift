import Foundation


extension CharacterSet {
    public func removing(_ character: Unicode.Scalar) -> Self {
        var cs = self
        cs.remove(character)
        return cs
    }

    public static let urlAllowed: CharacterSet = .alphanumerics.union(.init(charactersIn: "-._~")) // as per RFC 3986
}
