import SwiftUI


public struct Canvas<Page: View>: View {
    private let _page: Page
    private let filename: String
    private let width: Double
    private let height: Double

    public init(page: Page, filename: String, width: Double = 600, height: Double = 400) {
        self._page = page
        self.filename = filename
        self.width = width
        self.height = height
    }

    var page: some View {
        _page
            .frame(width: width, height: height)
            .padding()
    }

    public var body: some View {
        VStack {
            page
            Button("Save as PDF", action: { page.render(to: filename) })
        }
        .padding()
    }
}

