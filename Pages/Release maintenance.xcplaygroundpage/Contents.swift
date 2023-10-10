import SwiftUI

import Charts
import PlaygroundSupport



func binnedData(data: [Double], desiredCount: Int) -> [(index: Int, range: ChartBinRange<Double>, frequency: Int)] {
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
let maintenance = Array(
    Dictionary(grouping: rawData, by: \.packageId)
        .mapValues(VersionHistory.maintenance)
        .compactMapValues(\.?.inDays)
        .values
)

struct MaintenanceChart: View {
    var body: some View {
        Chart(binnedData(data: maintenance, desiredCount: 100), id: \.index) { element in
            BarMark(
                x: .value("", element.range),
                y: .value("", element.frequency)
            )
        }
        .chartXAxisLabel("Time between first and last release / days", position: .bottom, alignment: .center)
        .chartYAxisLabel("Package count", position: .trailing, alignment: .center)
    }
}


struct Page: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Swift Package Index")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("Time between first and last release")
                .font(.title.bold())

            MaintenanceChart()
        }
    }
}


PlaygroundPage.current.setLiveView(
    Canvas(page: Page(), filename: "maintenance", width: 600, height: 600)
)
