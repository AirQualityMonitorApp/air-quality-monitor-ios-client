import SwiftUI

struct GasPmValuesView: View {
    
    var flexibleLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var valueViewHeight: CGFloat
    var width: CGFloat
    @ObservedObject var viewModel: DashboardViewModel
    
    @State private var showPopover = false
    
    var body: some View {
        
        LazyVGrid(columns: flexibleLayout, spacing: 5) {
            ForEach(viewModel.dataItems, id: \.id) { card in
                if card.isSelected {
                    CircularCardView(displayedData: card.value, parentViewHeight: valueViewHeight, width: width * 0.3, color: card.color, valueInformation: card.info)
                }
                
            }
        }
        .padding(EdgeInsets(top: 10, leading: 6, bottom: 0, trailing: 6))
        Spacer()
        Divider()
    }
    
}

