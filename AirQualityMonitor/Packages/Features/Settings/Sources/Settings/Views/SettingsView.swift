import SwiftUI
import UIComponents

public struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsView.SettingsViewModel
    let size: CGSize
    
    public init(viewModel: SettingsView.SettingsViewModel, size: CGSize) {
        self.viewModel = viewModel
        self.size = size
    }
    
    public var body: some View {
        NavigationView {
            VStack{
                List {
                    DashboardSettingsView(viewModel: viewModel)
                    AppInfoView()
                }
                .font(.bodyH4)
                .modifier(SettingsListStyle())
            }
        }
    }
}

private struct SettingsListStyle: ViewModifier {
    func body(content: Content) -> some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            content
                .listStyle(PlainListStyle())
        } else {
            content
            .listStyle(GroupedListStyle())
        }
  }
}





