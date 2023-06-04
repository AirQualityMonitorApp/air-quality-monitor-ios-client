import SwiftUI

struct ValuesView: View {
    let viewData: ValuesViewData
    var valueViewHeight: CGFloat
        
    var body: some View {
        LazyVGrid(columns: viewData.flexibleLayout, spacing: 5) {
                ForEach(viewData.viewDataItems, id: \.id) { card in
                    if card.isSelected {
                        CircularCardView(configuration: .init(displayedData: card.value, height: valueViewHeight, width: viewData.width * 0.3, color: card.color, valueInformation: card.info))
                    }
                }.padding(.bottom, 24)
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 0, trailing: 6))
            Spacer()
    }
}

