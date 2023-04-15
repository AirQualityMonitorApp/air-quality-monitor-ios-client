
import Foundation
import SwiftUI

public extension SettingsView {
    class SettingsViewModel: SettingsViewType, ObservableObject {
        public init() {}
        
        @AppStorage("isFahrenheit") public var isFahrenheit: Bool = false
        @AppStorage("weatherValuesAreHidden") public var weatherValuesAreHidden: Bool = false
        @AppStorage("gasPmValuesAreHidden") public var gasPmValuesAreHidden: Bool = false
    }
}


public protocol SettingsViewType{
    var isFahrenheit: Bool { get set }
    var weatherValuesAreHidden: Bool  { get set }
    var gasPmValuesAreHidden: Bool { get set }
}
