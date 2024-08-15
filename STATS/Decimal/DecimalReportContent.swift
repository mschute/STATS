import SwiftData
import SwiftUI

struct DecimalReportContent: View {
    @Environment(\.modelContext) var modelContext
    @Query() var decimalEntries: [DecimalEntry]
    
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    //https://www.hackingwithswift.com/example-code/language/how-to-sum-an-array-of-numbers-using-reduce
    private var sum: Double { decimalEntries.reduce(0) { $0 + $1.value } }
    private var average: Double {
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
        Section(header: Text("")) {
            HStack {
                Text("Total entries:")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(decimalEntries.count)")
                    .font(.custom("Menlo", size: 32))
                    .fontWeight(.bold)
                    .foregroundColor(.decimal)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.vertical, 10)
            
            HStack {
                Text("Largest value:")
                    .fontWeight(.semibold)
                    .frame(alignment: .leading)
                Text(String(format: "%.2f", decimalEntries.max(by: {$0.value < $1.value} )?.value ?? 0.0))
                    .font(.custom("Menlo", size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(.decimal)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.vertical, 10)
            
            HStack {
                Text("Smallest value:")
                    .fontWeight(.semibold)
                    .frame(alignment: .leading)
                Text(String(format: "%.2f", decimalEntries.min(by: {$0.value < $1.value} )?.value ?? 0.0))
                    .font(.custom("Menlo", size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(.decimal)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.vertical, 10)
        }
        
        Section(header: Text("")) {
            if (decimalEntries[0].stat?.trackTotal == true) {
                HStack {
                    Text("Sum:")
                        .fontWeight(.semibold)
                        .frame(alignment: .leading)
                    
                    Text(String(format: "%.2f", sum))
                        .font(.custom("Menlo", size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(.decimal)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.vertical, 10)
            }
        }
        
        Section(header: Text("")) {
            Text("Value Sum by Day")
                .fontWeight(.semibold)
                .font(.custom("Menlo", size: 24))
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .padding()
            
            DecimalReportCharts(decimalEntries: decimalEntries, chartValueType: .total)
                .foregroundStyle(.decimal)
        }
        
        
        
        Section(header: Text("")) {
            if (decimalEntries[0].stat?.trackAverage == true) {
                HStack {
                    Text("Average:")
                        .fontWeight(.semibold)
                        .frame(alignment: .leading)
                    
                    Text(String(format: "%.2f", average))
                        .font(.custom("Menlo", size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(.decimal)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.vertical, 10)
            }
        }
        
        Section(header: Text("")) {
            Text("Value Average by Day")
                .fontWeight(.semibold)
                .font(.custom("Menlo", size: 24))
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .padding()
            
            DecimalReportCharts(decimalEntries: decimalEntries, chartValueType: .average)
                .foregroundStyle(.decimal)
        }
    }
    
    private static func predicate(id: PersistentIdentifier, startDate: Date, endDate: Date) -> Predicate<DecimalEntry> {
        return #Predicate<DecimalEntry> {
            entry in entry.stat?.persistentModelID == id && (entry.timestamp >= startDate && entry.timestamp <= endDate)
        }
    }
}
