import SwiftUI
import UIComponents

public struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    let size: CGSize
    
    public init(viewModel: SettingsViewModel, size: CGSize) {
        self.viewModel = viewModel
        self.size = size
    }
    
    public var body: some View {
        NavigationView {
            VStack{
                List {
                    DashboardSettingsView(viewModel: viewModel)
                    ServerConfiguration(viewModel: viewModel, size: size)
                    AppInfoView()
                }
                .font(.bodyH4)
                .modifier(SettingsListStyle())
            }
        }
    }
}

public struct SettingsListStyle: ViewModifier {
    public func body(content: Content) -> some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            content
                .listStyle(PlainListStyle())
        } else {
            content
            .listStyle(GroupedListStyle())
        }
  }
}





