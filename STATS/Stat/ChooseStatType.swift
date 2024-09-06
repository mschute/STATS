import SwiftUI

struct ChooseStatType: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            TopBar(title: "NEW STAT", topPadding: 60, bottomPadding: 20)
            Spacer()
            VStack(spacing: 40) {
                NavigationLink(destination: CounterFormAdd()) {
                    Text("Counter")
                        .textButtonStyle(fontSize: 20, verticalPadding: 20, horizontalPadding: 50, align: .center, statColor: .cyan, statHighlightColor: .counterHighlight)
                }
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            Haptics.shared.play(.light)
                        }
                )
                
                NavigationLink(destination: DecimalFormAdd()) {
                    Text("Decimal")
                        .textButtonStyle(fontSize: 20, verticalPadding: 20, horizontalPadding: 50, align: .center, statColor: .mint, statHighlightColor: .decimalHighlight)
                }
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            Haptics.shared.play(.light)
                        }
                )
                
                NavigationLink(destination: PictureFormAdd()) {
                    Text("Picture")
                        .font(.custom("Menlo", size: 20))
                        .textButtonStyle(fontSize: 20, verticalPadding: 20, horizontalPadding: 50, align: .center, statColor: .teal, statHighlightColor: .pictureHighlight)
                }
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            Haptics.shared.play(.light)
                        }
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(colorScheme == .light ? Color(UIColor.secondarySystemBackground) : Color.clear)
        }
        .navigationTitle("")
        .globalBackground()
    }
}
