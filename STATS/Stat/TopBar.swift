import SwiftUI

struct TopBar: View {
    var title: String
    var topPadding: CGFloat
    var bottomPadding: CGFloat
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text(title)
                .font(.custom("Menlo", size: 34))
                .fontWeight(.black)
                .padding(.top, topPadding)
                .padding(.bottom, bottomPadding)
                .kerning(4)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .background(topBarGradient().ignoresSafeArea())
        }
    }
    
    //Refined gradients: https://www.hackingwithswift.com/books/ios-swiftui/gradients
    private func topBarGradient() -> LinearGradient {
        let stops: [Gradient.Stop]
        
        if colorScheme == .light {
            stops = [
                .init(color: Color(UIColor.systemGray), location: 0.0),
                .init(color: Color(UIColor.systemGray2), location: 0.3),
                .init(color: Color(UIColor.systemGray3), location: 0.5),
                .init(color: Color(UIColor.systemGray4), location: 0.7),
                .init(color: Color(UIColor.systemGray5), location: 0.9),
                .init(color: Color(UIColor.systemGray6), location: 1.0)
            ]
        } else {
            stops = [
                .init(color: Color(UIColor.systemGray2), location: 0.0),
                .init(color: Color(UIColor.systemGray3), location: 0.2),
                .init(color: Color(UIColor.systemGray4), location: 0.4),
                .init(color: Color(UIColor.systemGray5), location: 0.6),
                .init(color: Color(UIColor.systemGray6), location: 0.8),
                .init(color: Color(UIColor.systemGroupedBackground), location: 1.0)
            ]
        }
        
        return LinearGradient(gradient: Gradient(stops: stops), startPoint: .top, endPoint: .bottom)
    }
}
