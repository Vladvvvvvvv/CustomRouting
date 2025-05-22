

import SwiftUI

public struct RouterView<Content: View> : View, Router {
    
    @Environment(\.dismiss) var dismiss

    @State private var path: [AnyDestination] = []
    @State private var sheetScreen: AnyDestination? = nil
    @State private var fullScreenCoverScreen: AnyDestination? = nil
    @State private var alertScreen: AnyAppAlert? = nil
    @State private var alertOption: AlertType = .alert
    @State private var modalScreen: AnyDestination? = nil
    @State private var modaltransition: AnyTransition = .opacity

    @Binding var screenStack: [AnyDestination]
    var addNavigationStack: Bool
    @ViewBuilder var content: (Router) -> Content
        
    public init(screenStack: (Binding<[AnyDestination]>)? = nil,
         addNavigationStack: Bool = true,
         content: @escaping (Router) -> Content
    )
    {
        self._screenStack = screenStack ?? .constant([])
        self.addNavigationStack = addNavigationStack
        self.content = content
    }
    
    public var body: some View {
        NavStackIfNeeded(
            addNavigationStack: addNavigationStack,
            path: $path) {
                content(self)
                    .sheetViewModifier(screen: $sheetScreen)
                    .fullScreenCoverViewModifier(screen: $fullScreenCoverScreen)
                    .showAlert(type: alertOption, alert: $alertScreen)
                   
            }
            .modalViewModifier(screen: $modalScreen, transition: modaltransition)
            .environment(\.router, self)
    }
    
    public func showModal<T: View>(transition: AnyTransition = .opacity ,@ViewBuilder destination: @escaping () -> T) {
        modalScreen = AnyDestination(destination: destination())
        modaltransition = transition
    }
    
    public func dismissModal() {
        modalScreen = nil
    }
    
    public func showAlert(alertType: AlertType, title: String, subtitle: String? = nil, buttons: (@Sendable () -> AnyView)? = nil) {
        let alert = AnyAppAlert( title: title, subtitle: subtitle, buttons:  buttons)
        alertOption = alertType
        alertScreen = alert
    }
    
    public func dismissAlert() {
        alertScreen = nil
    }
    
    public func showScreen<T: View>(option: SegueOption, @ViewBuilder destination: @escaping (Router) -> T) {
                
        let screen = RouterView<T>(
            screenStack: option.addNavStack ? nil : (screenStack.isEmpty ? $path : $screenStack),
            addNavigationStack: option.addNavStack) { newRouter in
                destination(newRouter)
            }
        let destionation = AnyDestination(destination: screen)
        
        switch option {
        case .sheet:
            sheetScreen = destionation
        case .push:
            if screenStack.isEmpty {
                path.append(destionation)
            } else {
                screenStack.append(destionation)
            }
        case .fullScreenCover:
            fullScreenCoverScreen = destionation
        }
    }
    
    public func dismissScreen() {
        dismiss()
    }
}
