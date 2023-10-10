import Foundation


let rawData = try VersionHistory.loadData()

let byPackageId = Dictionary(grouping: rawData, by: \.packageId)

let releaseCountByPackageId = byPackageId
    .mapValues { $0.filter({ $0.release != nil }).count }
    .values
print(releaseCountByPackageId.filter({ $0 == 0 }).count)
