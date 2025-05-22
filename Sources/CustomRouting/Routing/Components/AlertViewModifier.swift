


import SwiftUI

extension View {
    
    @ViewBuilder
    func showAlert(type: AlertType = .alert, alert: Binding<AnyAppAlert?>) -> some View {
        switch type {
        case .confirmatinDialog:
            self
                .confirmationDialog(alert.wrappedValue?.title ?? "", isPresented: Binding(alert: alert)) {
                    alert.wrappedValue?.buttons()
                } message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                }
        case .alert:
            self
                .alert(alert.wrappedValue?.title ?? "", isPresented: Binding(alert: alert)) {
                    alert.wrappedValue?.buttons()
                } message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                }
        }
    }
}
