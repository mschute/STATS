import SwiftUI

struct NewStatType: View {
    @Environment(\.backgroundColor) var backgroundColor
    
    var body: some View {
        VStack {
            Text("New Stat")
                .font(.custom("Menlo", size: 34))
                .fontWeight(.black)
                .padding(.top, 60)
                .padding(.bottom, 150)
            VStack(spacing: 40) {
                NavigationLink {
                    CounterForm(isEditMode: false)
                } label: {
                    Text("Counter")
                        .font(.custom("Menlo", size: 20))
                        .counterTextStyle()
                }
                
                NavigationLink {
                    DecimalForm(isEditMode: false)
                } label: {
                    Text("Decimal")
                        .font(.custom("Menlo", size: 20))
                        .decimalTextStyle()
                }
                
                NavigationLink {
                    PictureForm(isEditMode: false)
                } label: {
                    Text("Picture")
                        .font(.custom("Menlo", size: 20))
                        .pictureTextStyle()
                }
            }
            Spacer()
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor.ignoresSafeArea())
    }
}
