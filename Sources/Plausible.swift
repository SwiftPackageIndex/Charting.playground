import Foundation


public enum Plausible {
    public struct Response: Codable {
        public var results: [Visitor]

        public struct Visitor: Codable {
            public var date: String
            public var visitors: Int
        }
    }

    public struct EventPageBreakdown: Codable {
        public var events: Int
        public var page: String
        public var visitors: Int
    }

    public struct Result<T: Codable>: Codable {
        public var results: [T]
    }

    struct Error: Swift.Error {
        var message: String
    }

    //    static let siteID = "swiftpackageindex.com"
    public static var siteID = "swiftpackageindex.com"
    static let keychainService = "Plausible Token"
    static let keychainAccount = "plausible"
    static let token = try! Keychain.readString(service: keychainService,
                                                account: keychainAccount)

    public struct Parameters: CustomStringConvertible {
        var period: Period
        var date: Date

        public init(period: Period, date: Date) {
            self.period = period
            self.date = date
        }

        public enum Period: String, CustomStringConvertible {
            case month = "month"
            case twelveMonths = "12mo"
            public var description: String { rawValue }
        }

        public var description: String {
            "period=\(period)&date=\(DateFormatter.ymd.string(from: date))"
        }
    }

    static func _fetch(url: String) async throws -> Response {
        let session = URLSession.shared
        let url = URL(string: url)!
        var req = URLRequest(url: url)
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let data = try await session.data(for: req).0
        return try JSONDecoder().decode(Response.self, from: data)
    }
    static func _fetchNew<T: Codable>(url: String) async throws -> Result<T> {
        let session = URLSession.shared
        let url = URL(string: url)!
        var req = URLRequest(url: url)
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let data = try await session.data(for: req).0
        // print(String(decoding: data, as: UTF8.self))
        return try JSONDecoder().decode(Result<T>.self, from: data)
    }

    // curl -s "https://plausible.io/api/v1/stats/timeseries?site_id=swiftpackageindex.com&period=6mo&filters=visit:source%3D%3DGoogle" -H "Authorization: Bearer $PLAUSIBLE_TOKEN"
    public static func fetch(parameters: Parameters, source: String? = nil) async throws -> Response {
        let filters = source.map { "filters=visit:source%3D%3D\($0)" } ?? ""
        let url = "https://plausible.io/api/v1/stats/timeseries?site_id=\(siteID)&\(parameters)&\(filters)"
        return try await _fetch(url: url)
    }

    // curl -s "https://plausible.io/api/v1/stats/timeseries?site_id=swiftpackageindex.com&period=12mo&filters=event:page%3D%3D%2F" -H "Authorization: Bearer $PLAUSIBLE_TOKEN"
    public static func fetch(parameters: Parameters, page: String) async throws -> Response {
        let filters = "filters=event:page%3D%3D\(page.urlEncoded!)"
        let url = "https://plausible.io/api/v1/stats/timeseries?site_id=\(siteID)&\(parameters)&\(filters)"
        return try await _fetch(url: url)
    }

    public enum Property: String {
        case eventPage = "event:page"

        var query: String { "property=\(self.rawValue)" }
    }

    // curl -s "https://plausible.io/api/v1/stats/breakdown?site_id=$SITE_ID&metrics=pageviews,visitors,events&period=month&property=event:page"
    public static func fetchBreakdown(parameters: Parameters, property: Property) async throws -> Result<EventPageBreakdown> {
        let metrics = "metrics=events,visitors"
        let url = "https://plausible.io/api/v1/stats/breakdown?site_id=\(siteID)&\(parameters)&\(metrics)&\(property.query)"
        return try await _fetchNew(url: url)
    }

    public struct Event: Codable {
        var name: Kind
        var url: String
        var domain: String
        var props: [String: String]

        public enum Kind: String, Codable {
            case api
            case pageview
        }
    }

    public static func postEvent(kind: Event.Kind, path: String, apiKey: String) async throws {
        let session = URLSession.shared
        let url = URL(string: "https://plausible.io/api/event")!
        let req = try {
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            let data = try JSONEncoder().encode(Event(name: kind,
                                                      url: "https://test.swiftpackageindex.com/\(path)",
                                                      domain: "test.swiftpackageindex.com",
                                                      props: .api(key: apiKey)))
            req.httpBody = data
            req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return req
        }()
        let (data, res) = try await session.data(for: req)
        print("response:", String(decoding: data, as: UTF8.self))
        guard let status = (res as? HTTPURLResponse)?.statusCode else {
            throw Error(message: "Failed to convert response to HTTPURLResponse")
        }
        guard status == 200 else {
            throw Error(message: "Request failed with status code: \(status)")
        }
    }
}


extension [String: String] {
    static func api(key: String) -> Self {
        ["apiID": key]
    }
}
