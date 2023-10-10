import SwiftUI

import Charts
import PlaygroundSupport


struct Ratio {
    var date: String
    var googleVisitors: Int
    var totalVisitors: Int
    var ratio: Double

    var parsedDate: Date? { DateFormatter.ymd.date(from: date) }
}


func fetchData() async -> [Ratio] {
    let start = DateFormatter.ymd.date(from: "2021-02-01")!
    var data = [Ratio]()
    do {
        for param in Calendar.current.plausibleParameters(from: start) {
            let google = try await Plausible.fetch(parameters: param, source: "Google")
            let total = try await Plausible.fetch(parameters: param)
            assert(google.results.count == total.results.count)
            for (g, t) in zip(google.results, total.results) {
                assert(g.date == t.date)
                guard t.visitors > 0 else { continue }
                let ratio = Ratio(date: g.date, googleVisitors: g.visitors, totalVisitors: t.visitors, ratio: Double(g.visitors)/Double(t.visitors))
                print(ratio.date, ratio.ratio)
                data.append(ratio)
            }
        }
    } catch {
        print("Error in task: \(error.localizedDescription)")
    }
    return data
}


let data = runBlocking { await fetchData() }
print("data: \(data.count)")


struct GoogleVisitorRatioChart: View {
    let data: [Ratio]

    var body: some View {
        Chart(data, id: \.date) {
            if let date = $0.parsedDate {
                LineMark(
                    x: .value("Date", date),
                    y: .value("Ratio", $0.ratio * 100)
                )
            }
        }
        .chartXAxis {
            AxisMarks(
                format: .verbatim("\(month: .abbreviated) \(year: .defaultDigits)",
                                  locale: .init(identifier: "en"),
                                  timeZone: .gmt,
                                  calendar: .current)
            )
        }
        .chartYAxisLabel("Vistor ratio", position: .trailing, alignment: .center)
        .chartYScale(domain: [0, 100])
        .chartYAxis {
            AxisMarks(
                format: Decimal.FormatStyle.Percent.percent.scale(1)
            )
        }
    }
}


struct Page: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Swift Package Index")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("Google visitor ratio over time")
                .font(.title.bold())

            GoogleVisitorRatioChart(data: data)
        }
    }
}


PlaygroundPage.current.setLiveView(
    Canvas(page: Page(), filename: "google-visitor-ratio", width: 600, height: 400)
)


