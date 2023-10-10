import Foundation


extension DateFormatter {
    public static let ymd = {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        return fmt
    }()
}

