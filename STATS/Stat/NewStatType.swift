import SwiftUI

struct NewStatType: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack{
            Text("New Stat")
                .font(.largeTitle)
            
            NavigationLink {
                CounterForm(isEditMode: false, selectedTab: $selectedTab)
            } label: {
                  Text("Add Counter")
                    .padding()
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            NavigationLink {
                DecimalForm(isEditMode: false, selectedTab: $selectedTab)
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
