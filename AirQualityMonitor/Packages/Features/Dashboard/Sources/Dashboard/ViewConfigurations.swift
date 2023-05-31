import Foundation
import SwiftUI

public struct ValuesViewData {
    public let viewDataItems: [DataItem]
    public let width: CGFloat
    public var updateAirQualityData: () -> Void
    public let aqiValuesModel: AQIValuesModel?
    
    public let flexibleLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    public init(viewDataItems: [DataItem], width: CGFloat, updateAirQualityData: @escaping () -> Void, aqiValuesModel: AQIValuesModel? = nil) {
        self.viewDataItems = viewDataItems
        self.width = width
        self.updateAirQualityData = updateAirQualityData
        self.aqiValuesModel = aqiValuesModel
    }
}

public struct AQIValuesModel: Equatable {
     public static func == (lhs: AQIValuesModel, rhs: AQIValuesModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    public let id = UUID()
    public let value: Int
    public let color: Color
    public let isSelected: Bool
    public var updateAQIValueColor: (Int) -> Color
    
    public init(value: Int, color: Color, isSelected: Bool, updateAQIValueColor: @escaping (Int) -> Color) {
        self.value = value
        self.color = color
        self.isSelected = isSelected
        self.updateAQIValueColor = updateAQIValueColor
    }
}

public struct CardConfiguration {
    let displayedData: Double
    let height: CGFloat
    let width: CGFloat
    let color: Color
    let valueInformation: ValueInformation
}
