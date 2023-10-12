import Foundation


let records = try VersionHistory.loadData()

let byPackageId = Dictionary(grouping: records, by: \.packageId)

//let releaseCountByPackageId = byPackageId
//    .mapValues(VersionHistory.releaseCount)
//    .values
//print(releaseCountByPackageId.filter({ $0 == 0 }).count)


//let records = byPackageId["9081940d-0baa-4fc9-b96a-64159978ccd7"]!
//let records = byPackageId["38d534bf-4be1-498e-b973-e7e885fc3a4e"]!
//for r in records { print(r) }
//print()
//print(records.first!.packageName)
//print(records.first!.packageCreatedAt)
//print(VersionHistory.releaseCountAfterAdding(records))

if false {
    let indexingDates = records.indexingDates()
    let recordsAfterIndexing = records.filter { record in
        record.releaseDate >= indexingDates[record.packageId]!
    }
    let afterIndexingByPackageId = Dictionary(grouping: recordsAfterIndexing, by: \.packageId)

    indexingDates["38d534bf-4be1-498e-b973-e7e885fc3a4e"] // SemanticVersion
    indexingDates["7073c1c5-924c-443d-bb9e-f4ebcefca8ed"] // SPI-Server

    let releaseDatesAfterIndexing = records.filter { record in
        record.release != nil && (record.releaseDate >= indexingDates[record.packageId]!)
    }
        .map(\.releaseDate)
        .sorted()
    let start = releaseDatesAfterIndexing.first!
    let end = releaseDatesAfterIndexing.last!

    func differenceInDays(start: Date, end:Date) -> Int? {
        Calendar.current.dateComponents([.day], from: start, to: end).day
    }

    differenceInDays(start: start, end: end)
    byPackageId["7073c1c5-924c-443d-bb9e-f4ebcefca8ed"]?.count
}

let bins = VersionHistory.bin(data: records.map(\.releaseDate), days: 1227, binSize: 7)
    .sorted(by: { $0.frequency < $1.frequency })
let lastBin = bins.last!
print(lastBin)

let recordsInLastBin = records
    .filter({
        lastBin.range.contains($0.releaseDate)
    })
for r in recordsInLastBin.sorted(by: {
    if $0.packageId != $1.packageId { return $0.packageId < $1.packageId }
    return $0.releaseDate < $1.releaseDate
}) {
    print(r)
}
