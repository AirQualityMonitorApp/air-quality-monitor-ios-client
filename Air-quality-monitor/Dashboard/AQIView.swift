import SwiftUI
import UIComponents

struct AQIView: View {
    
    @ObservedObject var viewModel: DashboardView.DashboardViewModel
    var aqiViewHeight: CGFloat
    var width: CGFloat
    
    var body: some View {
        HStack{
            ZStack(alignment: .center) {
                Circle()
                    .stroke(viewModel.aqiValueColor, lineWidth: 20)
                    .opacity(0.5)
                    .animation(.easeInOut(duration: 1))
                Circle()
                    .trim(from: 0, to: (Double(viewModel.aqiScore)/100.0))
                    .stroke(viewModel.aqiValueColor, lineWidth: 20)
                    .rotationEffect(.degrees(-90))
                    .opacity(1)
                    .animation(.easeInOut(duration: 1))
            }.overlay(
                Text(String(viewModel.aqiScore)))
            .foregroundColor(viewModel.aqiValueColor)
                .font(.largeTitleH1)
                .animation(.easeInOut(duration: 1))
        }
        .padding(EdgeInsets(top: 12, leading: 0, bottom: 16, trailing: 0))
        .frame(height: aqiViewHeight, alignment: .top)
        .onChange(of: viewModel.aqiScore, perform: { _ in
            viewModel.updateAqiColor(value: viewModel.aqiScore)
        })
    }
}
