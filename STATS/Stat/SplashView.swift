import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Image(systemName: "chart.bar.xaxis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text("STATS")
                    .font(.custom("Menlo", size: 100))
            }
            .foregroundColor(.white)
        }
    }
}
