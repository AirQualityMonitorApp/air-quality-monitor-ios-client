import SwiftUI

struct ServerConfiguration: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    
    let size: CGSize
    
    var body: some View {
        Section(header: Text("Customization")
            .font(.bodyH4)
            .foregroundColor(.fontPrimary)) {
                
                NavigationLink(destination: Customization(viewModel: viewModel)) {
                    Text("Server Configuration")
                        .font(.footnoteH6)
                        .foregroundColor(.fontPrimary)
                }
                
            }
    }
}
