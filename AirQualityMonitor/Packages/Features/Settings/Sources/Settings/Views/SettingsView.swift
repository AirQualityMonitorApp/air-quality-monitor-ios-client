import Authentication
import SessionManager
import SwiftUI
import UIComponents

public struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsView.SettingsViewModel
    @ObservedObject var sessionManager: SessionManager
    let size: CGSize
    
    public init(viewModel: SettingsView.SettingsViewModel, sessionManager: SessionManager, size: CGSize) {
        self.viewModel = viewModel
        self.sessionManager = sessionManager
        self.size = size
    }
    
    public var body: some View {
        NavigationView {
            VStack{
                List {
                    DashboardSettingsView(viewModel: viewModel)
                    UserSettingsView(sessionManager: sessionManager, viewModel: viewModel, size: size)
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





