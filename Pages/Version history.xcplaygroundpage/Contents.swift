import Foundation


let rawData = try VersionHistory.loadData()

let byPackageId = Dictionary(grouping: rawData, by: \.packageId)

let releaseCountByPackageId = byPackageId
    .mapValues(VersionHistory.releaseCount)
    .values
print(releaseCountByPackageId.filter({ $0 == 0 }).count)


//let records = byPackageId["9081940d-0baa-4fc9-b96a-64159978ccd7"]!
let records = byPackageId["38d534bf-4be1-498e-b973-e7e885fc3a4e"]!
for r in records { print(r) }
print()
print(records.first!.packageName)
print(records.first!.packageCreatedAt)
print(VersionHistory.releaseCountAfterAdding(records))
