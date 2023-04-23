import Foundation
import SwiftUI

public class SettingsViewModel: ObservableObject {
    
    public init() {}
    
    @AppStorage("baseUrl") public var baseUrl: String = "http://localhost:3000"
    @AppStorage("urlPath") public var urlPath: String = "/api"
    @AppStorage("headerField1") public var headerField1: String = "userId"
    @AppStorage("headerFieldValue1") public var headerFieldValue1: String = "Qz0mKhKiIPUHQr4KttUCnX0E4c12"
    @AppStorage("headerField2") public var headerField2: String = ""
    @AppStorage("headerFieldValue2") public var headerFieldValue2: String = ""
    
    @AppStorage("isFahrenheit") public var isFahrenheit: Bool = false
    @AppStorage("requestInterval") public var requestInterval: String = ""
    @AppStorage("co2IsSelected") public var co2IsSelected: Bool = false
    @AppStorage("vocIsSelected") public var vocIsSelected: Bool = false
    @AppStorage("pm25IsSelected") public var pm25IsSelected: Bool = false
    @AppStorage("humidityIsSelected") public var humidityIsSelected: Bool = false
    @AppStorage("temperatureIsSelected") public var temperatureIsSelected: Bool = false
    @AppStorage("aqiScoreIsSelected") public var aqiScoreIsSelected: Bool = false
}
