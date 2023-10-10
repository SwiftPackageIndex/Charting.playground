import Foundation


let rawData = try VersionHistory.loadData()

let byPackageId = Dictionary(grouping: rawData, by: \.packageId)

let releaseCountByPackageId = byPackageId.mapValues(\.count).values
print(releaseCountByPackageId.filter({ $0 == 1 }).count)
