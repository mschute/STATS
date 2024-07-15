import Charts
import SwiftUI

struct CounterReport: View {
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    @State var chartType: ChartType = .bar
    
    private var counterStat: CounterStat
    
    @State var total: String = ""
    @State var timePeriodTotal: String = ""
    @State var timeOfDay: TimeOfDay = .morning
    @State var timeOfDayCount: String = ""
    
    @State var data: [CountDayData] = []
    
    init(counterStat: CounterStat) {
        self.counterStat = counterStat
        _startDate = State(initialValue: counterStat.created)
        _total = State(initialValue: String(counterStat.statEntry.count))
        _data = State(initialValue: ReportUtility.createDayCountData(statEntries: counterStat.statEntry, startDate: startDate, endDate: endDate))
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
        
        //for the bar chart have it span the time range, we need to bar time range to be either a day, a week or a month. Should this automatically adjust based on the total time frame?
        //TODO: Bar chart, count per day, per week, per month, add count next to the chart
    }
    
    private func updateCalcs() {
        timePeriodTotal = ReportUtility.calcTimePeriodTotal(stat: counterStat, startDate: startDate, endDate: endDate)
        (timeOfDay, timeOfDayCount) = ReportUtility.calcTimeOfDay(stat: counterStat)
        data = ReportUtility.createDayCountData(statEntries: counterStat.statEntry, startDate: startDate, endDate: endDate)
    }
}

//#Preview {
//    CounterReport()
//}
