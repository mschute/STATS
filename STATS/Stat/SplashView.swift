import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Text("STATS")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    SplashView()
}
