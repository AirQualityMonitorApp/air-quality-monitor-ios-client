import SwiftUI

struct DashboardSettingsView: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    var updateValues: () -> Void
    
    var body: some View {
        Section(header: Text("Dashboard Settings")
            .foregroundColor(.fontPrimary)
            .font(.bodyH4)) {
                DashboardSettingsCell(title: "Air Quality Score", isOn: $viewModel.aqiScoreIsSelected, updateValues: updateValues)
                DashboardSettingsCell(title: "CO²", isOn: $viewModel.co2IsSelected, updateValues: updateValues)
                DashboardSettingsCell(title: "VOC Index", isOn: $viewModel.vocIndexIsSelected, updateValues: updateValues)
                DashboardSettingsCell(title: "TVOC Index", isOn: $viewModel.tvocIsSelected, updateValues: updateValues)
                DashboardSettingsCell(title: "PM2.5", isOn: $viewModel.pm25IsSelected, updateValues: updateValues)
                DashboardSettingsCell(title: "PM10", isOn: $viewModel.pm10IsSelected, updateValues: updateValues)
                DashboardSettingsCell(title: "Temperature Celsius", isOn: $viewModel.tempCelsiusIsSelected, updateValues: updateValues)
                DashboardSettingsCell(title: "Temperature Fahrenheit", isOn: $viewModel.tempFahrenheitIsSelected, updateValues: updateValues)
                DashboardSettingsCell(title: "Humidity", isOn: $viewModel.humidityIsSelected, updateValues: updateValues)
            }
    }
}

struct DashboardSettingsCell: View, Equatable {
    static func == (lhs: DashboardSettingsCell, rhs: DashboardSettingsCell) -> Bool {
        return lhs.id == rhs.id
    }
    
    let title: String
    let isOn: Binding<Bool>
    var updateValues: () -> Void
    
    let id = UUID()
    
    var body: some View {
        HStack {
            Toggle(title, isOn: isOn)
                .font(.footnoteH6)
                .foregroundColor(.fontPrimary)
        }.onChange(of: self, perform: { _ in
            updateValues()
        })
    }
}


#if DEBUG
struct DashboardSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardSettingsView(viewModel: SettingsViewModel(), updateValues: {() -> Void in })
    }
}
#endif

