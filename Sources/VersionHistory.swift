import Foundation

import Charts


public enum VersionHistory {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss+00"
        formatter.locale = .init(identifier: "en_GB")
        formatter.timeZone = .gmt
        return formatter
    }()

    public struct Record: Codable {
        public var packageId: String
        public var packageName: String
        public var release: String
        public var releaseDate: Date
    }

    public static func loadData() throws -> [Record] {
        // Run query in Postico and export as JSON:
        //    select
        //      p.id "package_id",
        //      p.created_at "package_created_at",
        //      package_name,
        //      commit_date "release_date",
        //      reference->'tag'->>'tagName' as "release"
        //    from versions v
        //    join packages p on v.package_id = p.id
        //    order by package_name, commit_date desc

        struct RawRecord: Codable {
            var packageId: String
            var packageName: String?
            var release: String
            var releaseDate: String

            var record: Record? {
                guard let releaseDate = VersionHistory.dateFormatter.date(from: releaseDate) else { return nil }
                return .init(packageId: packageId,
                             packageName: packageName ?? "nil",
                             release: release,
                             releaseDate: releaseDate)
            }
        }

        let jsonURL = Bundle.main.url(forResource: "version-history", withExtension: "json")!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let data = try decoder.decode([RawRecord].self, from: Data(contentsOf: jsonURL))
        return data.compactMap(\.record)
    }

    public static func bin(data: [Date], days: Int, binSize: Int) -> [(index: Int, range: ChartBinRange<Date>, frequency: Int)] {
        let remainder = days % binSize
        let nBins = (days - remainder) / binSize
        let days = nBins * binSize
        if remainder != 0 {
            print("adjusting days to multiple of binSize \(binSize): \(days)")
        }
        let cal = Calendar.autoupdatingCurrent
        let startDate = {
            let maxDate = data.max()!
            let d = cal.date(byAdding: .init(day: -(nBins*binSize)), to: maxDate)!
            return cal.startOfDay(for: d)
        }()
        let thresholds = stride(from: 0, through: days, by: binSize).map {
            cal.date(byAdding: .init(day: $0), to: startDate)!
        }

        let data = data.filter { startDate <= $0 && $0 < thresholds.last! }
        let bins = DateBins(thresholds: thresholds)

        let groups = Dictionary(
            grouping: data,
            by: bins.index(for:)
        )
        return groups.map { key, values in
            (
                index: key,
                range: bins[key],
                frequency: values.count
            )
        }
    }


}
