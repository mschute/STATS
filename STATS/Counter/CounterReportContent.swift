import Charts
import SwiftData
import SwiftUI

struct CounterReportContent: View {
    @Environment(\.modelContext) var modelContext
    @Query() var counterEntries: [CounterEntry]
    
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    private var chartYLow: Int = 0
    private var chartYHigh: Int {
        let maxDayCount = CounterEntry.findDayCount(counterEntries: counterEntries, startDate: startDate, endDate: endDate).values.max() ?? 0
        return maxDayCount + 2
    }
    
    private var timeOfDayAndCount: (timeOfDay: TimeOfDay, count: Int) { CounterEntry.calcTimeOfDay(counterEntries: counterEntries) }
    private var timeOfDay: TimeOfDay { timeOfDayAndCount.timeOfDay }
    private var timeOfDayCount: Int { timeOfDayAndCount.count }
    private var data: [CountDayData] { return CounterEntry.findDayCount(counterEntries: counterEntries, startDate: startDate, endDate: endDate).map{ CountDayData(day: $0.key, count: $0.value) } }
    
    init(id: PersistentIdentifier, startDate: Binding<Date>, endDate: Binding<Date>) {
        self._startDate = startDate
        self._endDate = endDate
        _counterEntries = Query(filter: CounterEntry.predicate(id: id, startDate: startDate.wrappedValue, endDate: endDate.wrappedValue))
    }
    
    //https://www.kodeco.com/36025169-swift-charts-tutorial-getting-started/page/4?page=1#toc-anchor-001
    var body: some View {
        if !counterEntries.isEmpty {
            Section(header: Text("")) {
                VStack {
                    HStack {
                        Text("Total Count:")
                            .fontWeight(.semibold)
                            .frame(alignment: .leading)
                        Text("\(counterEntries.count)")
                            .font(.custom("Menlo", size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(.cyan)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding(.top, 10)
                
                VStack {
                    HStack {
                        Text("Most frequent time of day:")
                            .fontWeight(.semibold)
                            .frame(alignment: .leading)
                        Text("\(timeOfDay.rawValue)")
                            .font(.custom("Menlo", size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(.cyan)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                }
                
                VStack {
                    HStack {
                        Text("With a occurence count of:")
                            .fontWeight(.semibold)
                            .frame(alignment: .leading)
                        
                        Text("\(timeOfDayCount)")
                            .font(.custom("Menlo", size: 32))
                            .fontWeight(.bold)
                            .foregroundColor(.cyan)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding(.bottom, 10)
                
            }
            
            if counterEntries.count > 1 {
                Section(header: Text("")) {
                    Text("Entry Count by Day")
                        .fontWeight(.semibold)
                        .font(.custom("Menlo", size: 24))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Chart {
                        ForEach(data) { entry in
                            BarMark(
                                x: .value("Date", entry.day, unit: .day),
                                y: .value("Total Count", entry.count)
                            )
                        }
                    }
                    //Chart modifiers: https://stackoverflow.com/questions/72879128/how-to-label-axes-in-swift-charts
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .chartYScale(domain: [chartYLow, chartYHigh])
                    .chartXAxisLabel(position: .bottom, alignment: .center) {
                        Text("Date")
                            .font(.custom("Menlo", size: 16))
                    }
                    .chartYAxisLabel(position: .leading, alignment: .center) {
                        Text("Total Count")
                            .font(.custom("Menlo", size: 16))
                    }
                    .frame(height: 200)
                    .padding(.vertical, 15)
                    .foregroundStyle(.cyan)
                }
            } else {
                Section(header: Text("")) {
                    Text("Not enough data for chart")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        } else {
            Section(header: Text("")) {
                Text("No available data")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
