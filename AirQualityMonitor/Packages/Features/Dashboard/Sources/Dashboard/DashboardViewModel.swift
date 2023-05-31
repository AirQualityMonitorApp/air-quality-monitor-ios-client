import Foundation
import Networking
import SwiftUI
import Settings

public final class DashboardViewModel: ObservableObject {
    
    public init() {}
    
    @Published public var dataItems: [DataItem] = []
    @Published public var aqiScore: AirQualityScoreItem = AirQualityScoreItem(value: 0, color: .white, isSelected: true)
}

public struct DataItem: Equatable, Identifiable {
    public static func == (lhs: DataItem, rhs: DataItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    public let id = UUID()
    let value: Double
    let color: Color
    let info: ValueInformation
    var isSelected: Bool
}

public struct AirQualityScoreItem: Equatable, Identifiable {
    public let id = UUID()
    public let value: Int
    public let color: Color
    public var isSelected: Bool
}
