import SwiftUI
import UIComponents

public struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsView.SettingsViewModel
    @ObservedObject var sessionManager: SessionManager
    let size: CGSize
    
    public var body: some View {
        NavigationView {
            VStack{
                List {
                    DashboardSettingsView(viewModel: viewModel)
                    UserSettingsView(sessionManager: sessionManager, viewModel: viewModel, size: size)
                    AppInfoView()
                }
                .background(Color.green.ignoresSafeArea())
                .font(.bodyH4)
                .listStyle(GroupedListStyle())
            }
        }
    }
}




