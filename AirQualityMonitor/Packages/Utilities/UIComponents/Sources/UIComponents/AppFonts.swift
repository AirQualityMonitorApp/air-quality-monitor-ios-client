import Foundation
import SwiftUI

public enum AppFonts: String, CaseIterable {
    
    case light = "Montserrat-Light"
    case regular = "Montserrat-Regular"
    case medium = "Montserrat-Medium"
    case semiBold = "Montserrat-SemiBold"
    case bold = "Montserrat-Bold"
}

@available(iOS 15.0, OSX 10.15, watchOS 6.0, *)
public extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        case .largeTitle: return 48
        case .title: return 24
        case .headline: return 18
        case .body: return 16
        case .footnote: return 14
        default:
            return 8
        }
    }
}

@available(iOS 15.0, OSX 10.15, watchOS 6.0, *)
public extension Font {
    private static func custom(_ font: AppFonts, relativeTo style: Font.TextStyle) -> Font {
        custom(font.rawValue, size: style.size, relativeTo: style)
    }
    
    static let largeTitleH1 = custom(.bold, relativeTo: .largeTitle)
    static let titleH2 = custom(.semiBold, relativeTo: .title)
    static let headlineH3 = custom(.medium, relativeTo: .headline)
    static let bodyH4 = custom(.regular, relativeTo: .body)
    static let bodyMediumH5 = custom(.medium, relativeTo: .body)
    static let bodyLightH5 = custom(.light, relativeTo: .body)
    static let footnoteH6 = custom(.regular, relativeTo: .footnote)
    static let footnoteH7 = custom(.light, relativeTo: .footnote)
}
