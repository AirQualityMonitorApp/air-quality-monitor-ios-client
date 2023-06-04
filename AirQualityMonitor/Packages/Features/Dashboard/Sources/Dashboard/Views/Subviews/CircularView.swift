import Foundation
import SwiftUI
import UIComponents

struct CircularCardView: View {
    let configuration: CardConfiguration
    
    var body: some View {
        VStack {
            Text(configuration.valueInformation.title)
                    .font(.bodyLightH5)
                    .foregroundColor(.fontPrimary)
                    .frame(width: configuration.width, height: configuration.height * 0.09)
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            ZStack() {
                Circle()
                    .stroke(configuration.color, lineWidth: 10)
                    .opacity(0.5)
                    .animation(.easeInOut(duration: 2))
                Circle()
                    .trim(from: 0, to: configuration.displayedData/configuration.valueInformation.limit)
                    .stroke(configuration.color, lineWidth: 10)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 2))
                VStack {
                    createStyledText(with: String(configuration.displayedData), .fontPrimary, .bodyMediumH5)
                    createStyledText(with: configuration.valueInformation.unitMeasure, .fontPrimary, .bodyLightH5)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 4, trailing: 6))
        }
       .frame(width: configuration.width, height: configuration.height)
    }
}

extension View {
    func createStyledText(with text: String, _ color: Color, _ font: Font) -> some View {
        return Text(String(text))
            .foregroundColor(color)
            .font(font)
    }
}
