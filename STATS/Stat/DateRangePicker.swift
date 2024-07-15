import SwiftUI

struct DateRangePicker: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    var body: some View {
        DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
            .datePickerStyle(.compact)
            .padding(.horizontal)
        
        DatePicker("End Date", selection: $endDate, displayedComponents: .date)
            .datePickerStyle(.compact)
            .padding(.horizontal)
    }
}

//#Preview {
//    DateRangePicker()
//}
