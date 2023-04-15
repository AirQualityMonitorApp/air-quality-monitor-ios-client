import SwiftUI

struct DashboardSettingsView: View {
    
    @ObservedObject var viewModel: SettingsView.SettingsViewModel
    var body: some View {
        Section(header: Text("Dashboard Settings")
            .foregroundColor(.fontPrimary)
            .font(.bodyH4)) {
            HStack {
                Toggle("Fahrenheit", isOn: $viewModel.isFahrenheit)
                    .font(.footnoteH6)
                    .foregroundColor(.fontPrimary)
            }
            HStack {
                Toggle("Hide weather values", isOn: $viewModel.weatherValuesAreHidden)
                    .font(.footnoteH6)
                    .foregroundColor(.fontPrimary)
            }
            HStack {
                Toggle("Hide VOC, CO² and PM2.5", isOn: $viewModel.gasPmValuesAreHidden)
                    .font(.footnoteH6)
                    .foregroundColor(.fontPrimary)
            }
        }
    }
}

#if DEBUG
struct DashboardSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardSettingsView(viewModel: SettingsView.SettingsViewModel())
    }
}
#endif
