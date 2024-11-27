// This page show build deltas between builds of the _same_ package on the same platform between two different Swift versions.
// The purpose is to see if there is a build duration trend between Swift versions and if so, how large it is.

import SwiftUI

import Charts
import PlaygroundSupport


extension BuildInfo.Record {
    func isBuild(_ platform: BuildInfo.Platform, _ swiftVersion: BuildInfo.SwiftVersion) -> Bool {
        self.platform == platform && self.swiftVersion == swiftVersion
    }
}

enum DeltaScale {
    case absolute
    case percent
}

extension [BuildInfo.Record] {
    func findBuilds(_ platform: BuildInfo.Platform,
                    _ swiftVersion1: BuildInfo.SwiftVersion,
                    _ swiftVersion2: BuildInfo.SwiftVersion) -> (Element, Element)? {
        let f1 = filter { $0.isBuild(platform, swiftVersion1) }
        assert(f1.count <= 1)
        let f2 = filter { $0.isBuild(platform, swiftVersion2) }
        assert(f2.count <= 1)
        guard let r1 = f1.first, let r2 = f2.first else { return nil }
        return (r1, r2)
    }

    func buildDurationDelta(_ platform: BuildInfo.Platform,
                            _ swiftVersion1: BuildInfo.SwiftVersion,
                            _ swiftVersion2: BuildInfo.SwiftVersion,
                            scale: DeltaScale = .absolute) -> TimeInterval? {
        let builds = findBuilds(platform, swiftVersion1, swiftVersion2)
        guard let t1 = builds?.0.buildDuration, let t2 = builds?.1.buildDuration else { return nil }
        switch scale {
            case .absolute:
                return t1 - t2
            case .percent:
                guard t1 != .zero else { return nil }
                return (t1 - t2)/t2*100
        }
    }
}


func binnedData(data: [TimeInterval], max: TimeInterval, count: Int) -> [(index: Int, range: ChartBinRange<TimeInterval>, frequency: Int)] {
    let bins = NumberBins(range: (-max)...max, count: count)
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


func buildDurationDeltas(_ platform: BuildInfo.Platform,
                         _ swiftVersion1: BuildInfo.SwiftVersion,
                         _ swiftVersion2: BuildInfo.SwiftVersion,
                         scale: DeltaScale = .absolute) -> [TimeInterval] {
    let grouped = Dictionary(grouping: records, by: \.versionId)
        .compactMapValues {
            $0.buildDurationDelta(platform,
                                  swiftVersion1,
                                  swiftVersion2,
                                  scale: scale)
        }
    return Array(grouped.values)
}


struct BuildDurationDeltaChart: View {
    var platform: BuildInfo.Platform

    var body: some View {
        Chart(binnedData(data: buildDurationDeltas(platform,
                                                   .v6_0,
                                                   .v5_10,
                                                   scale: .percent),
                         max: 200,
                         count: 60),
              id: \.index) { element in
            BarMark(
                x: .value("", element.range),
                y: .value("", element.frequency)
            )
        }
        .chartXAxisLabel("Build duration delta / %", position: .bottom, alignment: .center)
        .chartYAxisLabel("Build count", position: .trailing, alignment: .center)
    }
}


struct Page: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Swift Package Index")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("Build duration delta")
                .font(.title.bold())

            Text("macOS, Swift 6.0 - 5.10")
                .font(.title2)
                .padding(.top)
            BuildDurationDeltaChart(platform: .macOS)
                    .chartXScale(domain: [-200, 200])
        }
    }
}


PlaygroundPage.current.setLiveView(
    Canvas(page: Page(), filename: "build-duration-delta-distribution", width: 600, height: 600)
)
