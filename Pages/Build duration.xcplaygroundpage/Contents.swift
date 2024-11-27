import SwiftUI

import Charts
import PlaygroundSupport


extension BuildInfo.Record {
    func isBuild(_ platform: BuildInfo.Platform, _ swiftVersion: BuildInfo.SwiftVersion) -> Bool {
        self.platform == platform && self.swiftVersion == swiftVersion
    }
}


func binnedData(data: [TimeInterval], max: TimeInterval, count: Int) -> [(index: Int, range: ChartBinRange<TimeInterval>, frequency: Int)] {
    let bins = NumberBins(range: 0...max, count: count)
    let groups = Dictionary(grouping: data.filter({ $0 <= max}), by: bins.index(for:))
    return groups.map { key, values in
        (
            index: key,
            range: bins[key],
            frequency: values.count
        )
    }
}


let records = try BuildInfo.loadData()


func buildDurations(_ platform: BuildInfo.Platform,
                    _ swiftVersion: BuildInfo.SwiftVersion) -> [TimeInterval] {
    let grouped = Dictionary(grouping: records, by: \.versionId)
        .compactMapValues { records in
            let filtered = records.filter { $0.isBuild(platform, swiftVersion) }
            assert(filtered.count <= 1)
            return filtered.first
        }

    return Array(grouped.mapValues(\.buildDuration).values).compactMap(\.self)
}


struct BuildDurationChart: View {
    var platform: BuildInfo.Platform
    var swiftVersion: BuildInfo.SwiftVersion

    var body: some View {
        Chart(binnedData(data: buildDurations(platform, swiftVersion),
                         max: 600,
                         count: 60),
              id: \.index) { element in
            BarMark(
                x: .value("", element.range),
                y: .value("", element.frequency)
            )
        }
        .chartXAxisLabel("Build duration / seconds", position: .bottom, alignment: .center)
        .chartYAxisLabel("Build count", position: .trailing, alignment: .center)
    }
}


struct Page: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Swift Package Index")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("Build duration distribution")
                .font(.title.bold())

            ForEach([BuildInfo.SwiftVersion.v6_0, .v5_10], id: \.self) { swiftVersion in
                Text("macOS, Swift \(swiftVersion)")
                    .font(.title2)
                    .padding(.top)
                BuildDurationChart(platform: .macOS, swiftVersion: swiftVersion)
                    .chartXScale(domain: [0, 200])
            }
        }
    }
}


PlaygroundPage.current.setLiveView(
    Canvas(page: Page(), filename: "build-duration-distribution", width: 600, height: 600)
)
