


import SwiftUI

struct NavStackIfNeeded<Content: View>: View {
    var addNavigationStack: Bool
    @Binding var path: [AnyDestination]
    @ViewBuilder var content: Content

    var body: some View {
        if addNavigationStack {
            NavigationStack(path: $path) {
                content
                    .navigationDestination(for: AnyDestination.self) { value in
                        value.destination
                    }
            }
        } else {
            content
        }
    }
}
