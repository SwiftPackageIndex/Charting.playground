import SwiftUI

import Charts
import PlaygroundSupport


let releaseData = try VersionHistory.loadData().map(\.releaseDate)


struct ReleaseFrequencyChart: View {
    var body: some View {
        Chart(VersionHistory.bin(data: releaseData, days: 1505, binSize: 1),
              id: \.index) { element in
            BarMark(
                x: .value("Date", element.range),
                y: .value("Count", element.frequency)
            )
        }
        .chartXAxisLabel("Date", position: .bottom, alignment: .center)
        .chartYAxisLabel("Count / day", position: .trailing, alignment: .center)

        Chart(VersionHistory.bin(data: releaseData, days: 1505, binSize: 7),
              id: \.index) { element in
            BarMark(
                x: .value("Date", element.range),
                y: .value("Count", element.frequency)
            )
        }
        .chartXAxisLabel("Date", position: .bottom, alignment: .center)
        .chartYAxisLabel("Count / week", position: .trailing, alignment: .center)
    }
}


struct Page: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Swift Package Index")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("Release frequency over time")
                .font(.title.bold())

            ReleaseFrequencyChart()
        }
    }
}


PlaygroundPage.current.setLiveView(
    Canvas(page: Page(), filename: "release-frequency", width: 600, height: 800)
)

