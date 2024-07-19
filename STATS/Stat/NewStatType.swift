import SwiftUI

struct NewStatType: View {
    
    var body: some View {
        VStack{
            Text("New Stat")
                .font(.largeTitle)
            
            NavigationLink {
                CounterForm(isEditMode: false)
            } label: {
                  Text("Add Counter Stat")
                    .padding()
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            NavigationLink {
                DecimalForm(isEditMode: false)
            } label: {
                  Text("Add Decimal Stat")
                    .padding()
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            NavigationLink {
                PictureForm(isEditMode: false)
            } label: {
                  Text("Add Picture Stat")
                    .padding()
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}
