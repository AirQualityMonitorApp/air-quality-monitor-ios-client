import SwiftUI
import UIComponents

public struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    let size: CGSize
    var updateValues: () -> Void
    
    public init(viewModel: SettingsViewModel, size: CGSize, updateValues: @escaping () -> Void) {
        self.viewModel = viewModel
        self.size = size
        self.updateValues = updateValues
    }
    
    public var body: some View {
        NavigationView {
            VStack{
                List {
                    DashboardSettingsView(viewModel: viewModel, updateValues: self.updateValues)
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

public struct SettingsTogglesConfiguration {
    var updateValues: () -> Void
}





