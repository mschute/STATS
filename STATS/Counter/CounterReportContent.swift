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
        let maxDayCount = findDayCount().values.max() ?? 0
        return maxDayCount + 2
    }
    
    private var timeOfDayAndCount: (timeOfDay: TimeOfDay, count: Int) { calcTimeOfDay() }
    private var timeOfDay: TimeOfDay { timeOfDayAndCount.timeOfDay }
    private var timeOfDayCount: Int { timeOfDayAndCount.count }
    private var data: [CountDayData] { return findDayCount().map{ CountDayData(day: $0.key, count: $0.value) } }
    
    init(id: PersistentIdentifier, startDate: Binding<Date>, endDate: Binding<Date>) {
        self._startDate = startDate
        self._endDate = endDate
        _counterEntries = Query(filter: CounterReportContent.predicate(id: id, startDate: startDate.wrappedValue, endDate: endDate.wrappedValue))
    }
    
    //https://www.kodeco.com/36025169-swift-charts-tutorial-getting-started/page/4?page=1#toc-anchor-001
    var body: some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("Total Count:")
                            .fontWeight(.semibold)
                            .frame(alignment: .leading)
                        Text("\(counterEntries.count)")
                            .font(.custom("Menlo", size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(.counter)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                .frame(maxWidth: .infinity)
                Divider()
                
                VStack {
                    HStack {
                        Text("Most frequent time of day:")
                            .fontWeight(.semibold)
                            .frame(alignment: .leading)
                        Text("\(timeOfDay.rawValue)")
                            .font(.custom("Menlo", size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(.counter)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                .frame(maxWidth: .infinity)
                Divider()

                VStack {
                    HStack {
                        Text("With a occurence count of:")
                            .fontWeight(.semibold)
                            .frame(alignment: .leading)
                        
                        Text("\(timeOfDayCount)")
                            .font(.custom("Menlo", size: 32))
                            .fontWeight(.bold)
                            .foregroundColor(.counter)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                
                Text("Note: Morning is 6am-11:59am, Afternoon is 12pm-5:59pm, Evening is 6pm-11:59pm, Overnight is 12am-5:59am")
                    .font(.custom("Menlo", size: 10))
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
            }
            .formSectionMimic()

            VStack {
                Text("Entry Count by Day")
                    .fontWeight(.semibold)
                    .font(.custom("Menlo", size: 24))
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
                .foregroundStyle(.counter)
            }
            .formSectionMimic()
        }
    }
    
    private static func predicate(id: PersistentIdentifier, startDate: Date, endDate: Date) -> Predicate<CounterEntry> {
        return #Predicate<CounterEntry> {
            entry in entry.stat?.persistentModelID == id && (entry.timestamp >= startDate && entry.timestamp <= endDate)
        }
    }
    
    private func calcTimeOfDay() -> (timeOfDay: TimeOfDay, count: Int) {
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
    
    private func findDayCount() -> [Date : Int] {
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
