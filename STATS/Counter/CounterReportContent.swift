import Charts
import SwiftData
import SwiftUI

struct CounterReportContent: View {
    @Environment(\.modelContext) var modelContext
    @Query() var counterEntries: [CounterEntry]
    
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    var chartYLow: Int = 0
    var chartYHigh: Int {
        let maxDayCount = findDayCount().values.max() ?? 0
        return maxDayCount + 2
    }
    
    private var timeOfDayAndCount: (timeOfDay: TimeOfDay, count: Int) {
        calcTimeOfDay()
    }
    
    var timeOfDay: TimeOfDay {
        timeOfDayAndCount.timeOfDay
    }
    
    var timeOfDayCount: Int {
        timeOfDayAndCount.count
    }
    
    var data: [CountDayData] {
        return findDayCount().map{ CountDayData(day: $0.key, count: $0.value) }
    }
    
    init(id: PersistentIdentifier, startDate: Binding<Date>, endDate: Binding<Date>) {
        self._startDate = startDate
        self._endDate = endDate
        
        _counterEntries = Query(filter: CounterReportContent.predicate(id: id, startDate: startDate.wrappedValue, endDate: endDate.wrappedValue))
    }
    
    //https://www.kodeco.com/36025169-swift-charts-tutorial-getting-started/page/4?page=1#toc-anchor-001
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("A total number counted for this time period is: \(counterEntries.count)")
                        .padding()
                    //Prevent from not wrapping: https://stackoverflow.com/questions/56505929/the-text-doesnt-get-wrapped-in-swift-ui
                    Text("The time period this occurred the most frequently in was: \(timeOfDay.rawValue) with a count of \(timeOfDayCount) occurrences")
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                    Text("Note: Morning is 6am-11:59am, Afternoon is 12pm-5:59pm, Evening is 6pm-11:59pm, Overnight is 12am-5:59am")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.footnote)
                        .padding()
                }
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
                }
                .chartYAxisLabel(position: .leading, alignment: .center) {
                    Text("Total Count")
                }
                .frame(height: 200)
                .padding(.horizontal)
            }
        }
    }
    
    private static func predicate(id: PersistentIdentifier, startDate: Date, endDate: Date) -> Predicate<CounterEntry> {
        return #Predicate<CounterEntry> {
            entry in entry.stat?.persistentModelID == id && (entry.timestamp >= startDate && entry.timestamp <= endDate)
        }
    }
    
    func calcTimeOfDay() -> (timeOfDay: TimeOfDay, count: Int) {
        var timeOfDayCounts: [TimeOfDay: Int] = [
            .morning: 0,
            .afternoon: 0,
            .evening: 0,
            .overnight: 0
        ]
        
        let calendar = Calendar.current
        
        for entry in counterEntries {
            let hour = calendar.component(.hour, from: entry.timestamp)
            
            switch hour {
            case 6..<12:
                //https://www.hackingwithswift.com/sixty/2/6/dictionary-default-values
                timeOfDayCounts[.morning, default: 0] += 1
            case 12..<18:
                timeOfDayCounts[.afternoon, default: 0] += 1
            case 18..<24:
                timeOfDayCounts[.evening, default: 0] += 1
            default:
                timeOfDayCounts[.overnight, default: 0] += 1
            }
        }
        
        if let maxPeriod = timeOfDayCounts.max(by: { $0.value < $1.value } ) {
            return (timeOfDay: maxPeriod.key, count: maxPeriod.value)
        } else {
            return (timeOfDay: .morning, count: 0)
        }
    }
    
    func findDayCount() -> [Date : Int] {
        var dateCounts: [Date : Int] = [:]
        let calendar = Calendar.current
        
        for entry in counterEntries {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                //https://developer.apple.com/documentation/foundation/calendar/2293783-startofday
                let date = calendar.startOfDay(for: entry.timestamp)
                dateCounts[date, default: 0] += 1
            }
        }
        return dateCounts
    }
}

//#Preview {
//    CounterReport()
//}
