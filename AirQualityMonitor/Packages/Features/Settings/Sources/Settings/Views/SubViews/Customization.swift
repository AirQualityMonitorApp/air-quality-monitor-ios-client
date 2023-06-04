//
//  SwiftUIView.swift
//  
//
//  Created by Pietro Ballarin on 15.04.23.
//

import SwiftUI

struct Customization: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
            List {
                Section(header: Text("Your Server URL")) {
                    TextField("URL", text: viewModel.$baseUrl)
                    TextField("Additional path (optional)", text: viewModel.$urlPath)
                }
                Section(header: Text("HTTP Request Header 1")) {
                    TextField("Header 1", text: viewModel.$headerField1)
                    TextField("Value 1", text: viewModel.$headerFieldValue1)
                }
                Section(header: Text("HTTP Request Header 2")) {
                    TextField("Header 2", text: viewModel.$headerField2)
                    TextField("Value 2", text: viewModel.$headerFieldValue2)
                }
                Section(header: Text("Request time interval")) {
                    TextField("Time in seconds", text: viewModel.$requestInterval)
                        .keyboardType(.numberPad)
                }
            }.modifier(SettingsListStyle())
        
    }
}


//struct Customization_Previews: PreviewProvider {
//    static var previews: some View {
//        Customization(viewModel: SettingsView.SettingsViewModel())
//    }
//}
