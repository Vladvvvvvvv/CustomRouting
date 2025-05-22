

import SwiftUI

struct MockRouter: Router {
    func showScreen<T>(option: SegueOption, @ViewBuilder destination: @escaping (any Router) -> T) where T : View {
        print("Mock router does not work")
    }
        
    func dismissScreen() {
        print("Mock router does not work")
    }
    
    func showAlert(alertType: AlertType, title: String, subtitle: String?, buttons: (@Sendable () -> AnyView)?) {
        print("Mock router does not work")
    }
    func dismissAlert() {
        
    }
    
    func showModal<T: View>(transition: AnyTransition ,@ViewBuilder destination: @escaping () -> T) {

    }
    
    func dismissModal() {

    }
}

public protocol Router {
    func showScreen<T: View>(option: SegueOption, @ViewBuilder destination: @escaping (Router) -> T)
    func dismissScreen()
    func showAlert(alertType: AlertType, title: String, subtitle: String?, buttons: (@Sendable () -> AnyView)?)
    func dismissAlert()
    func showModal<T: View>(transition: AnyTransition ,@ViewBuilder destination: @escaping () -> T)
    func dismissModal()
}
