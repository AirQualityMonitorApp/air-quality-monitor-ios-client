import SwiftUI

struct DashboardSettingsView: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    var body: some View {
        Section(header: Text("Dashboard Settings")
            .foregroundColor(.fontPrimary)
            .font(.bodyH4)) {
                DashboardSettingsCell(title: "Fahrenheit", isOn: $viewModel.isFahrenheit)
                DashboardSettingsCell(title: "Air Quality Score", isOn: $viewModel.aqiScoreIsSelected)
                DashboardSettingsCell(title: "CO²", isOn: $viewModel.co2IsSelected)
                DashboardSettingsCell(title: "VOC", isOn: $viewModel.vocIsSelected)
                DashboardSettingsCell(title: "PM2.5", isOn: $viewModel.pm25IsSelected)
                DashboardSettingsCell(title: "Temperature", isOn: $viewModel.temperatureIsSelected)
                DashboardSettingsCell(title: "Humidity", isOn: $viewModel.humidityIsSelected)
            }
    }
}

struct DashboardSettingsCell: View {
    let title: String
    let isOn: Binding<Bool>
    var body: some View {
        HStack {
            Toggle(title, isOn: isOn)
                .font(.footnoteH6)
                .foregroundColor(.fontPrimary)
        }
    }
}


#if DEBUG
struct DashboardSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardSettingsView(viewModel: SettingsViewModel())
    }
}
#endif
