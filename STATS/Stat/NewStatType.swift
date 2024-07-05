import SwiftUI

struct NewStatType: View {
    
    var body: some View {
        VStack{
            Text("New Stat")
                .font(.largeTitle)
            
            NavigationLink {
                CounterForm(isEditMode: false)
            } label: {
                  Text("Add Counter")
                    .padding()
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            NavigationLink {
                DecimalForm(isEditMode: false)
            } label: {
                  Text("Add Decimal")
                    .padding()
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}
