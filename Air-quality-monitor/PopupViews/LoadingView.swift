import SwiftUI

struct LoadingView: View {
    let width: CGFloat
    let height: CGFloat
    
    @State private var isCircleRotating = true
    @State private var animateStart = false
    @State private var animateEnd = true
    
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .opacity(0.5)
                    
                    Circle()
                        .stroke(lineWidth: 20)
                        .fill(Color.init(red: 0.96, green: 0.96, blue: 0.96))
                        .frame(width: 150, height: 150)
                    
                    Circle()
                        .trim(from: animateStart ? 1/3 : 1/9, to: animateEnd ? 2/5 : 1)
                        .stroke(lineWidth: 10)
                        .rotationEffect(.degrees(isCircleRotating ? 0 : 360))
                        .frame(width: 150, height: 150)
                        .foregroundColor(Color.green)
                        .onAppear() {
                            withAnimation(Animation
                                .linear(duration: 1)
                                .repeatForever(autoreverses: false)) {
                                    self.isCircleRotating.toggle()
                                }
                            withAnimation(Animation
                                .linear(duration: 1)
                                .delay(0.5)
                                .repeatForever(autoreverses: true)) {
                                    self.animateStart.toggle()
                                }
                            withAnimation(Animation
                                .linear(duration: 1)
                                .delay(1)
                                .repeatForever(autoreverses: true)) {
                                    self.animateEnd.toggle()
                                }
                        }
                }
                Text("Loading")
                    .font(.headlineH3)
                    .foregroundColor(.green)
            }
            .background(Color.white)
            .frame(width: width, height: height)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(width: 400, height: 200)
    }
}
