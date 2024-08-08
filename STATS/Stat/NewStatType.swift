import SwiftUI

struct NewStatType: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            TopBar(title: "NEW STAT", topPadding: 40, bottomPadding: 20)
            Spacer()
            VStack(spacing: 40) {
                NavigationLink {
                    CounterForm(isEditMode: false)
                } label: {
                    Text("Counter")
                        .textButtonStyle(fontSize: 20, verticalPadding: 20, horizontalPadding: 50, align: .center, statColor: .counter, statHighlightColor: .counterHighlight)
                }
                
                NavigationLink {
                    DecimalForm(isEditMode: false)
                } label: {
                    Text("Decimal")
                        .textButtonStyle(fontSize: 20, verticalPadding: 20, horizontalPadding: 50, align: .center, statColor: .decimal, statHighlightColor: .decimalHighlight)
                }
                
                NavigationLink {
                    PictureForm(isEditMode: false)
                } label: {
                    Text("Picture")
                        .font(.custom("Menlo", size: 20))
                        .textButtonStyle(fontSize: 20, verticalPadding: 20, horizontalPadding: 50, align: .center, statColor: .picture, statHighlightColor: .pictureHighlight)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(colorScheme == .light ? Color(UIColor.secondarySystemBackground) : Color.clear)
        }
        .navigationTitle("")
    }
}
