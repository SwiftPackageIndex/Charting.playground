import Foundation


let rawData = try VersionHistory.loadData()

let byPackageId = Dictionary(grouping: rawData, by: \.packageId)

let releaseCountByPackageId = byPackageId
    .mapValues(VersionHistory.releaseCount)
    .values
print(releaseCountByPackageId.filter({ $0 == 0 }).count)


let records = byPackageId["9081940d-0baa-4fc9-b96a-64159978ccd7"]!
for r in records { print(r) }
print()
print(VersionHistory.timeSinceLastRelease(records)!.inDays)
