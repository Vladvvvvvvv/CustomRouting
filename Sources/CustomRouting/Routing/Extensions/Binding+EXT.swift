


import SwiftUI

extension Binding where Value == Bool {
    
    init<T: Sendable>(ifNotNil value: Binding<T?>) {
        self.init(get: {
            value.wrappedValue != nil
        }, set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        })
    }
}

extension Binding where Value == Bool {
    
    init<T: Sendable>(alert: Binding<T?>) {
        self.init {
            alert.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                alert.wrappedValue = nil
            }
        }
    }
}
