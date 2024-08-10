import SwiftUI

struct DateRangePicker: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.main)
                        .padding(.trailing, 5)
                    
                    Text("Start Date")
                        .font(.custom("Menlo", size: 16))
                        .fontWeight(.bold)
                }
                .frame(alignment: .center)
                
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    .labelsHidden()
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .datePickerStyle(.compact)
                    .fontWeight(.medium)
            }
            .padding()
            
            Spacer()
            
            VStack {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.main)
                        .padding(.trailing, 5)
                    
                    Text("End Date")
                        .font(.custom("Menlo", size: 16))
                        .fontWeight(.bold)
                }
                .frame(alignment: .center)
                
                DatePicker("", selection: $endDate, displayedComponents: .date)
                    .labelsHidden()
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .datePickerStyle(.compact)
                    .fontWeight(.medium)
            }
            .padding()
        }
    }
}
