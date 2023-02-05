import Foundation
import SwiftUI

extension DashboardView.DashboardViewModel {
    private func setGasPmCardColor(value: Double, level: PmGasLevels, color: inout Color) {
        
        switch value {
        case level.good:
            color = .green
        case level.fair:
            color = .yellow
        case level.moderate:
            color = .orange
        case level.poor:
            color = .red
        case level.unhealthy:
            color = .purple
        default:
            color = .white
        }
    }
    
    public func updateCo2CardColor(value: Double) {
        setGasPmCardColor(value: value, level: Co2Level(), color: &co2Color)
    }
    
    public func updateVocCardColor(value: Double) {
        setGasPmCardColor(value: value, level: VocLevel(), color: &vocColor)
    }
    
    public func updatePmCardColor(value: Double) {
        setGasPmCardColor(value: value, level: PmLevel(), color: &pmColor)
    }
}
