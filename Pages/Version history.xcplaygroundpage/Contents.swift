import Foundation


let rawData = try VersionHistory.loadData()

let byPackageId = Dictionary(grouping: rawData, by: \.packageId)

let releaseCountByPackageId = byPackageId
    .mapValues(VersionHistory.releaseCount)
    .values
print(releaseCountByPackageId.filter({ $0 == 0 }).count)


//print(VersionHistory.mtbr(byPackageId["9081940d-0baa-4fc9-b96a-64159978ccd7"]!)!.inDays)
let records = byPackageId["00ebea1d-adcd-4f24-bc33-eac23131aa09"]!
for r in records { print(r) }
print()
print(VersionHistory.mtbr(records))
//print(!.inDays)


//let mtbr = Dictionary(grouping: rawData, by: \.packageId)
//        .mapValues(VersionHistory.mtbr)
//        .compactMapValues(\.?.inDays)

//print(mtbr)
