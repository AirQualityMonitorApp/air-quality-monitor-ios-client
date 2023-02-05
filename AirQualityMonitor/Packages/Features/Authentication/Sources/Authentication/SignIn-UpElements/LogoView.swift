import SwiftUI

public struct LogoView: View {
    
    var size: CGSize
    
    public var body: some View {
        HStack {
            Text("AQM")
        }
        .frame(width: size.width, height: size.height * 0.33, alignment: .center)
        .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
    }
}

#if DEBUG
struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(size: CGSize(width: 500, height: 500))
    }
}
#endif
