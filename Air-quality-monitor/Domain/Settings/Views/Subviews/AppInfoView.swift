import SwiftUI

struct AppInfoView: View {
    
    var body: some View {
        Section(header: Text("About this app")
            .font(.bodyH4)) {
            HStack {
                Text("Version:")
                    .font(.footnoteH6)
                Spacer()
                Text("1.0.0")
                    .font(.footnoteH7)
            }
        }
    }
}

#if DEBUG
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoView()
    }
}
#endif