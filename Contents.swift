import SwiftUI

import Charts
import PlaygroundSupport


let spiData: [(package: String, fileCount: Int, mbSize: Int)] = [
    (package: "swift-markdown-ui", fileCount: 3796, mbSize: 44),
    (package: "Microya", fileCount: 414, mbSize: 4),
    (package: "swift-url-routing", fileCount: 9430, mbSize: 101),
    (package: "StatKit", fileCount: 442, mbSize: 5),
    (package: "FluidMenuBarExtra", fileCount: 56, mbSize: 1),
    (package: "Currency", fileCount: 19396, mbSize: 162),
    (package: "JavaScriptKit", fileCount: 902, mbSize: 9),
    (package: "OSInfo", fileCount: 66, mbSize: 2),
    (package: "PlanetScale", fileCount: 198, mbSize: 3),
    (package: "Asynchrone", fileCount: 2636, mbSize: 29),
    (package: "swift-backtrace", fileCount: 56, mbSize: 1),
    (package: "mvt-tools", fileCount: 172, mbSize: 3),
    (package: "Neon", fileCount: 322, mbSize: 4),
    (package: "swiftui-cached-async-image", fileCount: 1004, mbSize: 11),
    (package: "RediStack", fileCount: 1626, mbSize: 35),
    (package: "SwiftLex", fileCount: 264, mbSize: 4),
    (package: "swift-confidential", fileCount: 140, mbSize: 2),
    (package: "AsyncObjects", fileCount: 478, mbSize: 6),
    (package: "ParseServerSwift", fileCount: 258, mbSize: 4),
    (package: "CrystalViewUtilities", fileCount: 5944, mbSize: 63),
    (package: "DoWhileDo", fileCount: 66, mbSize: 2),
    (package: "HTMLKit", fileCount: 26862, mbSize: 215),
    (package: "ParseSwift", fileCount: 4207, mbSize: 45),
    (package: "EmealKit", fileCount: 540, mbSize: 5),
    (package: "ValidatableKit", fileCount: 398, mbSize: 5),
    (package: "SwiftPlantUML", fileCount: 824, mbSize: 7),
    (package: "SmoothGradient", fileCount: 166, mbSize: 2),
    (package: "SyndiKit", fileCount: 892, mbSize: 8),
    (package: "swift-markdown-ui", fileCount: 3796, mbSize: 44),
    (package: "Prism", fileCount: 947, mbSize: 9),
    (package: "SwiftkubeClient", fileCount: 1050, mbSize: 11),
    (package: "swift-multipart-formdata", fileCount: 306, mbSize: 4),
    (package: "Tap", fileCount: 61, mbSize: 3),
    (package: "Extendable", fileCount: 2024, mbSize: 21),
    (package: "Northwind", fileCount: 3314, mbSize: 37),
    (package: "AppFoundation", fileCount: 168, mbSize: 2),
    (package: "Semaphore", fileCount: 58, mbSize: 2),
    (package: "swift-metrics", fileCount: 446, mbSize: 5),
    (package: "Papyrus", fileCount: 194, mbSize: 3),
    (package: "DelayedJob", fileCount: 86, mbSize: 2),
    (package: "Superhighway", fileCount: 132, mbSize: 2),
    (package: "PostgresConnectionPool", fileCount: 96, mbSize: 2),
    (package: "Tonic", fileCount: 1389, mbSize: 13),
    (package: "GoatHerb", fileCount: 668, mbSize: 6),
    (package: "CryptoSwift", fileCount: 2242, mbSize: 21),
    (package: "swift-http-structured-headers", fileCount: 710, mbSize: 8),
    (package: "Keyboard", fileCount: 1997, mbSize: 21),
    (package: "Rearrange", fileCount: 76, mbSize: 2),
    (package: "ScryfallKit", fileCount: 1500, mbSize: 13),
    (package: "AppStoreConnect", fileCount: 196, mbSize: 3),
    (package: "gis-tools", fileCount: 2588, mbSize: 25),
    (package: "apnswift", fileCount: 462, mbSize: 5),
    (package: "ParseCertificateAuthority", fileCount: 86, mbSize: 2),
    (package: "swift-nio-ssl", fileCount: 956, mbSize: 10),
    (package: "PianoRoll", fileCount: 1059, mbSize: 12),
    (package: "SwiftUICharts", fileCount: 3970, mbSize: 41),
    (package: "Buildkite", fileCount: 3202, mbSize: 30),
    (package: "KippleNetworking", fileCount: 768, mbSize: 7),
    (package: "BigDecimal", fileCount: 192, mbSize: 3),
    (package: "swift-argument-parser", fileCount: 533, mbSize: 7),
    (package: "swift-atomics", fileCount: 370, mbSize: 6),
    (package: "Structure", fileCount: 1736, mbSize: 15),
    (package: "JSONRPC", fileCount: 418, mbSize: 4),
    (package: "GRDB", fileCount: 9494, mbSize: 114),
    (package: "Defaults", fileCount: 1332, mbSize: 15),
    (package: "IOStreams", fileCount: 658, mbSize: 8),
    (package: "AudioKit", fileCount: 4273, mbSize: 37),
    (package: "URLCompatibilityKit", fileCount: 48, mbSize: 1),
    (package: "KippleTools", fileCount: 110, mbSize: 2),
    (package: "MarkCodable", fileCount: 94, mbSize: 2),
    (package: "Drops", fileCount: 48, mbSize: 1),
    (package: "swift-cassandra-client", fileCount: 736, mbSize: 8),
    (package: "swift-cutelog", fileCount: 72, mbSize: 2),
    (package: "SwiftSnmpKit", fileCount: 282, mbSize: 3),
    (package: "StreamChatVapor", fileCount: 62, mbSize: 2),
    (package: "SwiftCommand", fileCount: 678, mbSize: 8),
    (package: "StoreFlowable", fileCount: 478, mbSize: 6),
    (package: "SwiftObserver", fileCount: 464, mbSize: 5),
    (package: "AdvancedList", fileCount: 2042, mbSize: 22),
    (package: "OperationPlus", fileCount: 228, mbSize: 3),
    (package: "Script.swift", fileCount: 96, mbSize: 2),
    (package: "Waveform", fileCount: 1015, mbSize: 11),
    (package: "Controls", fileCount: 9591, mbSize: 97),
    (package: "AppStorage", fileCount: 76, mbSize: 2),
    (package: "ChimeKit", fileCount: 78, mbSize: 7),
    (package: "SHDateFormatter", fileCount: 104, mbSize: 2),
    (package: "ConcurrencyPlus", fileCount: 202, mbSize: 3),
    (package: "Pretty", fileCount: 154, mbSize: 2),
    (package: "XMLCoder", fileCount: 456, mbSize: 5),
    (package: "swift-aws-lambda-runtime", fileCount: 202, mbSize: 3),
    (package: "LocationFormatter", fileCount: 430, mbSize: 5),
    (package: "SwiftSyntax", fileCount: 76109, mbSize: 952),
    (package: "Media", fileCount: 1194, mbSize: 11),
    (package: "MeshGenerator", fileCount: 422, mbSize: 6),
    (package: "Squirrel3", fileCount: 74, mbSize: 2),
    (package: "StreamChat", fileCount: 13461, mbSize: 105),
    (package: "CrystalButtonKit", fileCount: 3052, mbSize: 32),
    (package: "SwiftInspector", fileCount: 852, mbSize: 8),
    (package: "ICMPPing", fileCount: 116, mbSize: 2),
    (package: "swift-service-discovery", fileCount: 354, mbSize: 5),
    (package: "LanguageClient", fileCount: 686, mbSize: 7),
    (package: "FileSystemEventPublisher", fileCount: 52, mbSize: 1),
    (package: "Engine", fileCount: 190, mbSize: 2),
    (package: "DynamicCodableKit", fileCount: 318, mbSize: 7),
    (package: "mqtt-nio", fileCount: 954, mbSize: 9),
    (package: "Inject", fileCount: 88, mbSize: 2),
    (package: "SemanticVersion", fileCount: 108, mbSize: 2),
    (package: "STKAudioKit", fileCount: 173, mbSize: 2),
    (package: "SwiftVizScale", fileCount: 755, mbSize: 10),
    (package: "PlotVapor", fileCount: 666, mbSize: 6),
    (package: "WeakReference", fileCount: 56, mbSize: 1),
    (package: "postmark-swift", fileCount: 284, mbSize: 3),
    (package: "ASCKit", fileCount: 806, mbSize: 7),
    (package: "CoreColor", fileCount: 539, mbSize: 6),
    (package: "NetworkReachability", fileCount: 751, mbSize: 32),
    (package: "SPIManifest", fileCount: 238, mbSize: 3),
    (package: "GRDBQuery", fileCount: 112, mbSize: 2),
    (package: "SwiftUnits", fileCount: 2612, mbSize: 23),
    (package: "swift-nio-transport-services", fileCount: 494, mbSize: 6),
    (package: "KippleCore", fileCount: 164, mbSize: 2),
    (package: "LSPService", fileCount: 76, mbSize: 2),
    (package: "SwiftLSP", fileCount: 612, mbSize: 6),
    (package: "Saga", fileCount: 246, mbSize: 3),
    (package: "With", fileCount: 52, mbSize: 1),
    (package: "Tribool", fileCount: 84, mbSize: 2),
    (package: "swift-nio-extras", fileCount: 1142, mbSize: 11),
    (package: "open-weather-kit", fileCount: 1160, mbSize: 11),
    (package: "CombineCoreBluetooth", fileCount: 432, mbSize: 5),
    (package: "Vuckt", fileCount: 2736, mbSize: 23),
    (package: "Lighter", fileCount: 1492, mbSize: 22),
    (package: "swift-dependencies-additions", fileCount: 48, mbSize: 1),
    (package: "RealHTTP", fileCount: 2154, mbSize: 20),
    (package: "SCNMathExtensions", fileCount: 54, mbSize: 1),
    (package: "CertificateSigningRequest", fileCount: 110, mbSize: 2),
    (package: "Updeto", fileCount: 74, mbSize: 2),
    (package: "ParseSwift", fileCount: 4125, mbSize: 45),
    (package: "swift-service-lifecycle", fileCount: 224, mbSize: 3),
    (package: "Stores", fileCount: 484, mbSize: 5),
    (package: "QuickLMDB", fileCount: 754, mbSize: 8),
    (package: "InstrumentKit", fileCount: 2330, mbSize: 20),
    (package: "CustomRepeatDate", fileCount: 192, mbSize: 3),
    (package: "Yams", fileCount: 1262, mbSize: 13),
    (package: "swift-distributed-tracing-baggage", fileCount: 98, mbSize: 2),
    (package: "Stytch", fileCount: 1052, mbSize: 11),
    (package: "Dflat", fileCount: 2122, mbSize: 22),
    (package: "Vexil", fileCount: 1530, mbSize: 16),
    (package: "Upstash", fileCount: 110, mbSize: 2),
    (package: "hcaptcha-swift", fileCount: 106, mbSize: 2),
    (package: "HandySwift", fileCount: 466, mbSize: 5),
    (package: "swift-distributed-tracing-baggage-core", fileCount: 98, mbSize: 2),
    (package: "swift-cluster-membership", fileCount: 580, mbSize: 7),
    (package: "VDTransition", fileCount: 313, mbSize: 5),
    (package: "SemanticVersioningKit", fileCount: 94, mbSize: 2),
    (package: "TOMLKit", fileCount: 1038, mbSize: 10),
    (package: "composable-effect-identifier", fileCount: 68, mbSize: 2),
    (package: "KeyboardShortcuts", fileCount: 1350, mbSize: 15),
    (package: "swift-log", fileCount: 332, mbSize: 4),
    (package: "TextFormation", fileCount: 390, mbSize: 4),
    (package: "Terminus", fileCount: 1399, mbSize: 14),
    (package: "SwiftAnalyticsKit", fileCount: 518, mbSize: 6),
    (package: "swift-metrics-extras", fileCount: 220, mbSize: 3),
    (package: "NilCoalescingAssignmentOperators", fileCount: 54, mbSize: 1),
    (package: "SpanGrid", fileCount: 1102, mbSize: 12),
    (package: "SwiftTreeSitter", fileCount: 694, mbSize: 7),
    (package: "OBSwiftSocket", fileCount: 5468, mbSize: 49),
    (package: "ProcessService", fileCount: 88, mbSize: 2),
    (package: "swift-statsd-client", fileCount: 82, mbSize: 2),
    (package: "Flow", fileCount: 1187, mbSize: 13),
    (package: "ColorWell", fileCount: 1071, mbSize: 13),
    (package: "CurrencyConverter", fileCount: 98, mbSize: 2),
    (package: "swift-bundler", fileCount: 60, mbSize: 2),
    (package: "Lindenmayer", fileCount: 14614, mbSize: 159),
    (package: "ThirtyTo", fileCount: 192, mbSize: 3),
    (package: "Bagbutik", fileCount: 368, mbSize: 4),
    (package: "SGPKit", fileCount: 94, mbSize: 2),
    (package: "CRDT", fileCount: 832, mbSize: 9),
    (package: "swift-distributed-tracing", fileCount: 398, mbSize: 5),
    (package: "CalendarDate", fileCount: 198, mbSize: 3),
    (package: "KippleDiagnostics", fileCount: 74, mbSize: 2),
    (package: "Querl", fileCount: 120, mbSize: 2),
    (package: "Pioneer", fileCount: 620, mbSize: 7),
    (package: "AnyMeasure", fileCount: 156, mbSize: 6),
    (package: "DocCMiddleware", fileCount: 80, mbSize: 2),
    (package: "Athena", fileCount: 554, mbSize: 7),
    (package: "Assist", fileCount: 2076, mbSize: 18),
    (package: "GeoJSONKit", fileCount: 298, mbSize: 4),
    (package: "KippleUI", fileCount: 13228, mbSize: 131),
    (package: "secp256k1", fileCount: 530, mbSize: 6),
    (package: "ProjectNavigator", fileCount: 5016, mbSize: 51),
    (package: "Relax", fileCount: 641, mbSize: 7),
    (package: "teco-core", fileCount: 708, mbSize: 7),
    (package: "XCSnippets", fileCount: 202, mbSize: 3),
    (package: "SimulatorServices", fileCount: 359, mbSize: 4),
    (package: "reactiveswift-composable-architecture", fileCount: 6748, mbSize: 79),
    (package: "SwiftyProvisioningProfile", fileCount: 190, mbSize: 3),
    (package: "AnyLint", fileCount: 188, mbSize: 3),
    (package: "AnyAsyncSequence", fileCount: 116, mbSize: 2),
    (package: "CameraControlARView", fileCount: 1072, mbSize: 12),
    (package: "SceneKitDebugTools", fileCount: 10475, mbSize: 110),
    (package: "XCTestExtensions", fileCount: 51, mbSize: 2),
    (package: "UITestingPlus", fileCount: 70, mbSize: 2),
    (package: "Runestone", fileCount: 934, mbSize: 33),
    (package: "YMatterType", fileCount: 1385, mbSize: 13),
    (package: "swift-nio-http2", fileCount: 2042, mbSize: 19),
    (package: "swift-nio-http2", fileCount: 2042, mbSize: 19),
    (package: "swift-nio-ssh", fileCount: 1110, mbSize: 11),
    (package: "swift-markdown", fileCount: 2786, mbSize: 27),
    (package: "swift-case-paths", fileCount: 124, mbSize: 2),
    (package: "vapor-routing", fileCount: 60, mbSize: 2),
    (package: "vapor-routing", fileCount: 60, mbSize: 2),
    (package: "TGCardViewController", fileCount: 569, mbSize: 5),
    (package: "Compute", fileCount: 1672, mbSize: 14),
    (package: "Compute", fileCount: 1672, mbSize: 14),
    (package: "SwiftSyntax", fileCount: 73765, mbSize: 927),
    (package: "StreamChatSwiftUI", fileCount: 85395, mbSize: 752),
    (package: "apnswift", fileCount: 462, mbSize: 5),
    (package: "YMatterType", fileCount: 1385, mbSize: 13),
    (package: "async-http-client", fileCount: 662, mbSize: 8),
    (package: "swift-nio", fileCount: 6534, mbSize: 61),
    (package: "Vercel", fileCount: 1064, mbSize: 9),
    (package: "Vercel", fileCount: 1064, mbSize: 9),
    (package: "CodeEditorView", fileCount: 1150, mbSize: 12),
    (package: "SwiftNodes", fileCount: 284, mbSize: 4),
    (package: "grpc-swift", fileCount: 2800, mbSize: 27),
    (package: "RevenueCat", fileCount: 1581, mbSize: 15),
    (package: "EditorConfig", fileCount: 218, mbSize: 3),
    (package: "swift-composable-architecture", fileCount: 7152, mbSize: 89),
    (package: "TGCardViewController", fileCount: 569, mbSize: 5),
    (package: "SwiftDocC", fileCount: 10282, mbSize: 94),
    (package: "SwiftNodes", fileCount: 284, mbSize: 4),
    (package: "SwiftKeys", fileCount: 1503, mbSize: 16)
]


func binnedData(data: [Int]) -> [(index: Int, range: ChartBinRange<Int>, frequency: Int)] {
    let bins = NumberBins(data: data, desiredCount: 100)
    let groups = Dictionary(
        grouping: data,
        by: bins.index(for:)
    )
    return groups.map { key, values in
        (
            index: key,
            range: bins[key],
            frequency: values.count
        )
    }
}


struct MBSizeChart: View {
    var body: some View {
        Chart(binnedData(data: spiData.map(\.mbSize)),
              id: \.index) { element in
            BarMark(
                x: .value("Size / MB", element.range),
                y: .value("Count", element.frequency)
            )
        }
        .chartXAxisLabel("Size / MB", position: .bottom, alignment: .center)
        .chartYAxisLabel("Count", position: .trailing, alignment: .center)
    }
}


struct FileCountChart: View {
    var body: some View {
        Chart(binnedData(data: spiData.map(\.fileCount)),
              id: \.index) { element in
            BarMark(
                x: .value("Count", element.range),
                y: .value("Count", element.frequency)
            )
        }
        .chartXAxisLabel("Count", position: .bottom, alignment: .center)
        .chartYAxisLabel("Count", position: .trailing, alignment: .center)
    }
}


struct Canvas: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Swift Package Index")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("DocC doc set size and file count distributions")
                .font(.title.bold())

            Text("Size")
                .font(.title2)
                .padding(.top)
            MBSizeChart()

            Text("File count")
                .font(.title2)
                .padding(.top)
            FileCountChart()
        }
    }
}


struct Page: View {
    var canvas: some View {
        Canvas()
            .frame(width: 600, height: 600)
            .padding()
    }

    var body: some View {
        VStack {
            canvas
            Button("Save as PDF", action: { canvas.render() })
        }
    }
}


PlaygroundPage.current.setLiveView(
    Page()
)


extension View {
    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-swiftui-view-to-a-pdf
    @discardableResult
    @MainActor
    func render() -> URL {
        let renderer = ImageRenderer(content: self)

        let url = URL.documentsDirectory.appending(path: "chart.pdf")

        renderer.render { size, context in
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)

            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                return
            }

            pdf.beginPDFPage(nil)
            context(pdf)
            pdf.endPDFPage()
            pdf.closePDF()
        }

        print("Saved to \(url.path())")
        return url
    }

}
