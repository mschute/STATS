import SwiftData
import SwiftUI

struct DecimalReportContent: View {
    @Environment(\.modelContext) var modelContext
    @Query() var decimalEntries: [DecimalEntry]
    
    @Binding var startDate: Date
    @Binding var endDate: Date
    
//https://www.hackingwithswift.com/example-code/language/how-to-sum-an-array-of-numbers-using-reduce
    var sum: Double { decimalEntries.reduce(0) { $0 + $1.value } }
    var average: Double {
        if (decimalEntries.count == 0) {
            return 0
        }
        return sum / Double(decimalEntries.count)
    }
    
    init(id: PersistentIdentifier, startDate: Binding<Date>, endDate: Binding<Date>){
        self._startDate = startDate
        self._endDate = endDate
        
        _decimalEntries = Query(filter: DecimalReportContent.predicate(id: id, startDate: startDate.wrappedValue, endDate: endDate.wrappedValue))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                Section(header: Text("Date Range")) {
                    Text("Total entries for date range: \(decimalEntries.count)")
                    Text("Largest value for date range: \(decimalEntries.max(by: {$0.value < $1.value} )?.value ?? 0.0)")
                    Text("Smallest value for date range: \(decimalEntries.min(by: {$0.value < $1.value} )?.value ?? 0.0)")
                    
                }
                .padding(.horizontal)
                
                if (decimalEntries[0].stat?.trackTotal == true) {
                    Section(header: Text("Total")) {
                        Text("Sum of entry values for date range: \(sum)")
                        
                        DecimalReportCharts(decimalEntries: decimalEntries, chartValueType: .total)
                    }
                    .padding(.horizontal)
                }
                
                if (decimalEntries[0].stat?.trackAverage == true) {
                    Section(header: Text("Average")) {
                        Text("Average for date range: \(average)")
                        
                        DecimalReportCharts(decimalEntries: decimalEntries, chartValueType: .average)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    private static func predicate(id: PersistentIdentifier, startDate: Date, endDate: Date) -> Predicate<DecimalEntry> {
        return #Predicate<DecimalEntry> {
            entry in entry.stat?.persistentModelID == id && (entry.timestamp >= startDate && entry.timestamp <= endDate)
        }
    }
}

//#Preview {
//    DecimalReport()
//}
