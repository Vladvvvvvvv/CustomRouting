

import Foundation

public enum SegueOption {
    case sheet
    case push
    case fullScreenCover
    
    var addNavStack: Bool {
        switch self {
        case .push:
            return false
        case .fullScreenCover, .sheet:
            return true
        }
    }
}
