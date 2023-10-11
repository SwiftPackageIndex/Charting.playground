import SwiftUI

import Charts
import PlaygroundSupport



func binnedData(data: [Int], desiredCount: Int) -> [(index: Int, range: ChartBinRange<Int>, frequency: Int)] {
    let bins = NumberBins(data: data, desiredCount: desiredCount)
    let groups = Dictionary(grouping: data, by: bins.index(for:))
    return groups.map { key, values in
        (
            index: key,
            range: bins[key],
            frequency: values.count
        )
    }
}


let rawData = try VersionHistory.loadData()
let releaseCountAfterAddition = Array(
    Dictionary(grouping: rawData, by: \.packageId)
        .mapValues(VersionHistory.releaseCountAfterAdding)
        .values
)

struct MaintenanceChart: View {
    var body: some View {
        Chart(binnedData(data: releaseCountAfterAddition, desiredCount: 100), id: \.index) { element in
            BarMark(
                x: .value("", element.range),
                y: .value("", element.frequency)
            )
        }
        .chartXAxisLabel("Release count after addition", position: .bottom, alignment: .center)
        .chartYAxisLabel("Package count", position: .trailing, alignment: .center)
    }
}


struct Page: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Swift Package Index")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("Release count after addition to index")
                .font(.title.bold())

            MaintenanceChart()
        }
    }
}


PlaygroundPage.current.setLiveView(
    Canvas(page: Page(), filename: "release-count-after-addition", width: 600, height: 600)
)
