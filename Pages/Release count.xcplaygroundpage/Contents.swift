import SwiftUI

import Charts
import PlaygroundSupport



func binnedData(data: [Int], max: Int) -> [(index: Int, range: ChartBinRange<Int>, frequency: Int)] {
    let bins = NumberBins(range: 0...max, count: max)
    let groups = Dictionary(grouping: data.filter({ $0 <= max}), by: bins.index(for:))
    return groups.map { key, values in
        (
            index: key,
            range: bins[key],
            frequency: values.count
        )
    }
}


let rawData = try VersionHistory.loadData()
let versionCounts = Array(
    Dictionary(grouping: rawData, by: \.packageId)
        .mapValues { $0.filter({ $0.release != nil }).count }
        .values
)


struct ReleaseCountChart: View {
    var body: some View {
        Chart(binnedData(data: versionCounts, max: 99),
              id: \.index) { element in
            BarMark(
                x: .value("", element.range),
                y: .value("", element.frequency)
            )
        }
        .chartXAxisLabel("Release count", position: .bottom, alignment: .center)
        .chartYAxisLabel("Package count", position: .trailing, alignment: .center)
    }
}


struct Page: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Swift Package Index")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("Release count distribution")
                .font(.title.bold())

            ReleaseCountChart()
        }
    }
}


PlaygroundPage.current.setLiveView(
    Canvas(page: Page(), filename: "release-count-distribution", width: 600, height: 600)
)
