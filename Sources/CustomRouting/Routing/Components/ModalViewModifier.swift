

import SwiftUI

struct ModalSupportView<Content: View>: View {
    
    @Binding var showModal: Bool
    let transition: AnyTransition
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            if showModal {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(AnyTransition.opacity.animation(.smooth))
                    .onTapGesture {
                        showModal = false
                    }
                    .zIndex(1)


                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .transition(transition)
                    .zIndex(2)
            }
        }
        .animation(.bouncy, value: showModal)
    }
}

extension View {
    
    func modalViewModifier(screen: Binding<AnyDestination?>, transition: AnyTransition) -> some View {
        self
            .overlay {
                ModalSupportView(showModal: Binding(ifNotNil: screen),transition: transition) {
                    ZStack {
                        if let screen = screen.wrappedValue {
                            screen.destination
                        }
                    }
                }
            }
    }
}

