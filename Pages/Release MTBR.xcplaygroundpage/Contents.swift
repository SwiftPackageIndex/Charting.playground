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
let mtbr = Array(
    Dictionary(grouping: rawData, by: \.packageId)
        .mapValues(VersionHistory.mtbr)
        .compactMapValues(\.?.inDays)
        .values
)

struct MTBRChart: View {
    var body: some View {
        Chart(binnedData(data: mtbr, desiredCount: 100), id: \.index) { element in
            BarMark(
                x: .value("", element.range),
                y: .value("", element.frequency)
            )
        }
        .chartXAxisLabel("Mean time between releases / days", position: .bottom, alignment: .center)
        .chartYAxisLabel("Package count", position: .trailing, alignment: .center)
    }
}


struct Page: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Swift Package Index")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("Mean time between releases")
                .font(.title.bold())

            MTBRChart()
        }
    }
}


PlaygroundPage.current.setLiveView(
    Canvas(page: Page(), filename: "mtbr", width: 600, height: 600)
)
