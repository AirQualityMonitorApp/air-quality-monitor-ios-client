import Foundation
import Networking
import SwiftUI
import Settings

public final class DashboardViewModel: ObservableObject {
    
    public init() {}
    
    @Published var dataItems: [DataItem] = []
    @Published var aqiScore: AirQualityScoreItem = AirQualityScoreItem(value: 0, color: .white, isSelected: true)
}

struct DataItem: Equatable, Identifiable {
    static func == (lhs: DataItem, rhs: DataItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    let value: Double
    let color: Color
    let info: ValueInformation
    var isSelected: Bool
}

struct AirQualityScoreItem: Equatable, Identifiable {
    let id = UUID()
    let value: Int
    let color: Color
    var isSelected: Bool
}
