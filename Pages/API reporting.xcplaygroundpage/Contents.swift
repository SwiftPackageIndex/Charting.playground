import SwiftUI

import Charts
import PlaygroundSupport


func fetchData() async throws -> [Plausible.EventPageBreakdown] {
    try await Plausible.fetchBreakdown(parameters: .init(period: .month, date: .now),
                                       property: .eventPage).results
}

Plausible.siteID = "test.swiftpackageindex.com"
let data = runBlocking { try! await fetchData() }
print("data: \(data.count)")


struct EventPageBreakdownChart: View {
    let data: [Plausible.EventPageBreakdown]

    var body: some View {
        Chart(data, id: \.page) {
            BarMark(
                x: .value("Events", $0.events),
                y: .value("Page", $0.page)
            )
        }
        .chartXAxisLabel("Events", alignment: .center)
        .chartYAxisLabel("Path", position: .leading, alignment: .center)
    }
}


struct Page: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Swift Package Index")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("Event page breakdown (current month)")
                .font(.title.bold())

            EventPageBreakdownChart(data: data)
        }
    }
}


PlaygroundPage.current.setLiveView(
    Canvas(page: Page(), filename: "event-page-breakdown-month", width: 600, height: 400)
)


