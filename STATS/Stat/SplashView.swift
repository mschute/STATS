import SwiftUI

struct SplashView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true
    
    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                Image(systemName: "chart.bar.xaxis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text("STATS")
                    .font(.custom("Menlo", size: 100))
            }
            .foregroundColor(isDarkMode ? .white : .black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isDarkMode ? Color.black : Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}
