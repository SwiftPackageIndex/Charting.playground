import SwiftUI

import Charts
import PlaygroundSupport


let records = try VersionHistory.loadData()

let indexingDates = records.indexingDates()
let releaseDatesAfterIndexing = records.filter { record in
    record.release != nil && (record.releaseDate >= indexingDates[record.packageId]!)
}
    .map(\.releaseDate)
    .sorted()
let start = releaseDatesAfterIndexing.first!
let end = releaseDatesAfterIndexing.last!
let range = Calendar.current.dateComponents([.day], from: start, to: end).day!

let allReleaseDates = records.map(\.releaseDate)
    .filter {
        start <= $0 && $0 <= end
    }


//struct ReleaseFrequencyByDayChart: View {
//    var body: some View {
//        Chart(VersionHistory.bin(data: allReleaseDates, days: 1505, binSize: 1),
//              id: \.index) { element in
//            BarMark(
//                x: .value("Date", element.range),
//                y: .value("Count", element.frequency)
//            )
//        }
//        .chartXAxisLabel("Date", position: .bottom, alignment: .center)
//        .chartYAxisLabel("Count / day", position: .trailing, alignment: .center)
//    }
//}


struct ReleaseFrequencyByWeekChart: View {
    var body: some View {
        Chart(VersionHistory.bin(data: allReleaseDates, days: range, binSize: 7),
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


struct ReleaseFrequencyAfterIndexingChart: View {
    var body: some View {
        Chart(VersionHistory.bin(data: releaseDatesAfterIndexing, days: range, binSize: 7),
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

//            Text("Release frequency by day")
//                .font(.title2)
//                .padding(.top)
//            ReleaseFrequencyByDayChart()

            Text("Release frequency – all releases")
                .font(.title2)
                .padding(.top)
            ReleaseFrequencyByWeekChart()

            Text("Release frequency – after indexing")
                .font(.title2)
                .padding(.top)
            ReleaseFrequencyAfterIndexingChart()
        }
    }
}


PlaygroundPage.current.setLiveView(
    Canvas(page: Page(), filename: "release-frequency", width: 600, height: 800)
)

