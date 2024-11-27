
//{
//    "version_id": "0002b963-a0e8-4c3d-acae-e8c905e7e604",
//    "status": "ok",
//    "swift_version": {
//        "major": 6,
//        "minor": 0,
//        "patch": 0
//    },
//    "platform": "ios",
//    "job_url": "https://gitlab.com/finestructure/swiftpackageindex-builder/-/jobs/8261394107",
//    "runner_id": "orka-vm-vkwvc",
//    "builder_version": "4.56.0",
//    "build_duration": 27.90518999099731,
//    "build_date": "2024-11-04 13:11:43.110416+00"
//},

import Foundation


public enum BuildInfo {
    public struct Record: Codable {
        public var versionId: UUID
        public var status: Status
        public var swiftVersion: SwiftVersion
        public var platform: Platform
        public var buildDuration: TimeInterval?
    }

    public enum Status: String, Codable, Equatable {
        case ok
    }
    public struct SwiftVersion: Codable, Equatable, Hashable, CustomStringConvertible {
        public var major: Int
        public var minor: Int

        public static let v6_0 = Self.init(major: 6, minor: 0)
        public static let v5_10 = Self.init(major: 5, minor: 10)
        public static let v5_9 = Self.init(major: 5, minor: 9)

        public var description: String { "\(major).\(minor)" }
    }
    public enum Platform: String, Codable, Equatable, Hashable {
        case macOS = "macos-spm"
        case iOS = "ios"
        case linux = "linux"
    }

    public static func loadData() throws -> [Record] {
        // Run query in Postico and export as JSON:
        //        select version_id, status, swift_version, platform, job_url, runner_id,
        //           builder_version, build_duration, build_date
        //        from builds
        //        where status = 'ok'
        //        and platform in ('macos-spm', 'ios', 'linux')
        //        and (
        //          swift_version->>'major' = '6'
        //          or (swift_version->>'major' = '5' and swift_version->>'minor' = '10')
        //          or (swift_version->>'major' = '5' and swift_version->>'minor' = '9')
        //        )
        //        and build_duration is not null

        let jsonURL = Bundle.main.url(forResource: "build-info", withExtension: "json")!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Record].self, from: Data(contentsOf: jsonURL))
    }
}
