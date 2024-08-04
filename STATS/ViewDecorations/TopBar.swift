import SwiftUI

struct TopBar: View {
    @Environment(\.backgroundColor) var backgroundColor
    var title: String
    var topPadding: CGFloat
    var bottomPadding: CGFloat
    
    var body: some View {
        VStack {
            Text(title)
                .font(.custom("Menlo", size: 34))
                .fontWeight(.black)
                .padding(.top, topPadding)
                .padding(.bottom, bottomPadding)
                .kerning(4)
                .frame(maxWidth: .infinity)
                .background(Color.background.ignoresSafeArea())
        }
    }
}
