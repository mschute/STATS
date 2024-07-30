import Charts
import SwiftUI

struct CounterReportContent: View {
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    @State var chartType: ChartType = .bar
    @State var chartYLow: Int = 0
    //TODO: Create function to calculate highest count per day
    @State var chartYHigh: Int = 10
    
    private var counterStat: CounterStat
    
    @State var total: String = ""
    @State var timePeriodTotal: Int = 0
    @State var timeOfDay: TimeOfDay = .morning
    @State var timeOfDayCount: String = ""
    
    @State var data: [CountDayData] = []
    
    init(counterStat: CounterStat) {
        self.counterStat = counterStat
        _startDate = State(initialValue: counterStat.created)
        _total = State(initialValue: String(counterStat.statEntry.count))
        _data = State(initialValue: createDayCountData(statEntries: counterStat.statEntry, startDate: startDate, endDate: endDate))
        _chartYHigh = State(initialValue: calcYRangeCount(statEntries: counterStat.statEntry, startDate: startDate, endDate: endDate))
    }
    
    //https://www.kodeco.com/36025169-swift-charts-tutorial-getting-started/page/4?page=1#toc-anchor-001
    var body: some View {
        VStack {
            Text("Report")
                .font(.largeTitle)
            
            ScrollView {
                DateRangePicker(startDate: $startDate, endDate: $endDate)
                    .onChange(of: startDate, initial: true) { updateCalcs() }
                    .onChange(of: endDate, initial: true) { updateCalcs() }
                
                VStack {
                    Text("Total for all time: \(total)")
                        .padding()
                    Text("A total number counted for this time period is: \(timePeriodTotal)")
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
                
                //TODO: If time, add option to view count by week and count by month
                //TODO: Need to fix the bar chart domain for this.
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
    
    private func updateCalcs() {
        timePeriodTotal = ReportUtility.calcTotalEntries(stat: counterStat, startDate: startDate, endDate: endDate)
        (timeOfDay, timeOfDayCount) = calcTimeOfDay(stat: counterStat)
        data = createDayCountData(statEntries: counterStat.statEntry, startDate: startDate, endDate: endDate)
    }
    
    //Count specific?
    func calcTimeOfDay(stat: any Stat) -> (timeOfDay: TimeOfDay, count: String) {
        var timeOfDayCounts: [TimeOfDay: Int] = [
            .morning: 0,
            .afternoon: 0,
            .evening: 0,
            .overnight: 0
        ]
        
        let calendar = Calendar.current
        
        for entry in stat.statEntry {
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
            return (timeOfDay: maxPeriod.key, count: String(maxPeriod.value))
        } else {
            //Structural binding
            return (timeOfDay: .morning, count: String(0))
        }
    }
    
    func createDayCountData(statEntries: [any Entry], startDate: Date, endDate: Date) -> [CountDayData] {
        return findDayCount(statEntries: statEntries, startDate: startDate, endDate: endDate).map{ CountDayData(day: $0.key, count: $0.value) }
    }
    
    func calcYRangeCount(statEntries: [any Entry], startDate: Date, endDate: Date) -> Int {
        let maxDayCount = findDayCount(statEntries: statEntries, startDate: startDate, endDate: endDate).values.max() ?? 0
        let buffer = 2
        
        return maxDayCount + buffer
    }
    
    func findDayCount(statEntries: [any Entry], startDate: Date, endDate: Date) -> [Date : Int] {
        var dateCounts: [Date : Int] = [:]
        let calendar = Calendar.current
        
        for entry in statEntries {
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
