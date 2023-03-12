import Foundation
import SwiftUI
import UIComponents

struct CircularCardView: View {
    
    let displayedData: Double
    let parentViewHeight: CGFloat
    let width: CGFloat
    let color: Color
    
    var valueInformation: ValueInformation
    
    var body: some View {
        VStack(alignment: .center) {
            Button(action: { }) {
                Text(valueInformation.title)
                    .font(.bodyLightH5)
                    .foregroundColor(.fontPrimary)
                    .frame(width: width, height: parentViewHeight * 0.09)
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            }
            .buttonStyle(PlainButtonStyle())
            
            ZStack(alignment: .center) {
                Circle()
                    .stroke(color, lineWidth: 10)
                    .opacity(0.5)
                    .animation(.easeInOut(duration: 2))
                Circle()
                    .trim(from: 0, to: displayedData/valueInformation.limit)
                    .stroke(color, lineWidth: 10)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 2))
            }.overlay(
                VStack {
                    createStyledText(with: String(displayedData), .fontPrimary, .bodyLightH5)
                    createStyledText(with: valueInformation.unitMeasure, .fontPrimary, .bodyLightH5)
                }
            )
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 4, trailing: 6))
        }
        .frame(width: width, height: parentViewHeight)
    }
}

extension View {
    func createStyledText(with text: String, _ color: Color, _ font: Font) -> some View {
        return Text(String(text))
            .foregroundColor(color)
            .font(font)
    }
}
