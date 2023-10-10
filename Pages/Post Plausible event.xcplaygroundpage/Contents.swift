import SwiftUI

import PlaygroundSupport

Plausible.siteID = "test.swiftpackageindex.com"

Task {
    try await Plausible.postEvent(kind: .api, path: "api/test", apiKey: "foo")
    print("done")
}

PlaygroundPage.current.needsIndefiniteExecution = true
