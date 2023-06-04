import SwiftUI
import UIComponents

public struct AQIView: View {
    
    let aqiData: AQIValuesModel?
    var aqiViewHeight: CGFloat
    
    public var body: some View {
        HStack{
            ZStack(alignment: .center) {
                Circle()
                    .stroke(aqiData?.color ?? .white, lineWidth: 20)
                    .opacity(0.5)
                    .animation(.easeInOut(duration: 1))
                Circle()
                    .trim(from: 0, to: (Double(aqiData?.value ?? 0)/100.0))
                    .stroke(aqiData?.color ?? .white, lineWidth: 20)
                    .rotationEffect(.degrees(-90))
                    .opacity(1)
                    .animation(.easeInOut(duration: 1))
            }
            .overlay(
                Text(String(aqiData?.value ?? 0)))
            .foregroundColor(aqiData?.color)
            .font(.largeTitleH1)
            .animation(.easeInOut(duration: 1))
        }
        .isHidden(!(aqiData?.isSelected ?? false))
        .padding(EdgeInsets(top: 12, leading: 0, bottom: 16, trailing: 0))
        .frame(height: aqiViewHeight, alignment: .top)
    }
}
