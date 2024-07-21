import Charts
import SwiftUI

struct DecimalReport: View {
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    @State var chartType: ChartType = .line
    
    private var decimalStat: DecimalStat
    
    @State var totalEntries: String = "0"
    @State var dateRangeEntries: String = "0"
    
    @State var largestAllTime: String = "0.0"
    @State var smallestAllTime: String = "0.0"
    @State var largestDateRange: String = "0.0"
    @State var smallestDateRange: String = "0.0"
    
    @State var totalValue: String = "0.0"
    @State var dateRangeValue: String = "0.0"
    
    @State var avgAllTime: String = "0.0"
    @State var avgDateRange: String = "0.0"
    
    @State var data: [ValueDayData] = []
    
    init(decimalStat: DecimalStat){
        self.decimalStat = decimalStat
        _startDate = State(initialValue: decimalStat.created)
        _totalEntries = State(initialValue: ReportUtility.calcTotalEntries(stat: decimalStat))
        _dateRangeEntries = State(initialValue: ReportUtility.calcTotalEntriesDateRange(stat: decimalStat, startDate: startDate, endDate: endDate))
        _largestAllTime = State(initialValue: ReportUtility.calcLargestValueAllTime(statEntries: decimalStat.statEntry))
        _smallestAllTime = State(initialValue: ReportUtility.calcSmallestValueAllTime(statEntries: decimalStat.statEntry))
        _largestDateRange = State(initialValue: ReportUtility.calcLargestValueDateRange(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate))
        _smallestDateRange = State(initialValue: ReportUtility.calcSmallestValueDateRange(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate))
        _totalValue = State(initialValue: ReportUtility.calcTotalValue(statEntries: decimalStat.statEntry))
        _dateRangeValue = State(initialValue: ReportUtility.calcTotalValueDateRange(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate))
        _avgAllTime = State(initialValue: ReportUtility.calcAvgValue(statEntries: decimalStat.statEntry))
        _avgDateRange = State(initialValue: ReportUtility.calcAvgValueDateRange(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate))
        _data = State(initialValue: ReportUtility.createDayValueData(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate))
    }
    var body: some View {
        VStack {
            Text("Decimal Report")
                .font(.largeTitle)
            
            ScrollView {
                DateRangePicker(startDate: $startDate, endDate: $endDate)
                    .onChange(of: startDate, initial: true) { updateCalcs() }
                    .onChange(of: endDate, initial: true) { updateCalcs() }
                
                Section(header: Text("All Time")) {
                    Text("Total entries for all time: \(totalEntries)")
                    Text("Largest value for all time: \(largestAllTime)")
                    Text("Smallest value for all time: \(smallestAllTime)")
                }
                .padding(.horizontal)
                 
                Section(header: Text("Date Range")) {
                    Text("Total entries for date range: \(dateRangeEntries)")
                    Text("Largest value for date range: \(largestDateRange)")
                    Text("Smallest value for date range: \(smallestDateRange)")
                    
                    //Adjusting look of line chart https://blog.stackademic.com/line-chart-using-swift-charts-swiftui-cd1abeac9e44
                    Chart {
                        
                        ForEach(data) { entry in
                            LineMark(
    
                                x: .value("Date", entry.day),
                                //TODO: Need to
                                y: .value("\(decimalStat.unitName)", entry.value)
                            )
                            .interpolationMethod(.catmullRom)
                            .lineStyle(.init(lineWidth: 2))
                            .symbol {
                                //TODO: Need to format the mark labels
                                
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 12, height: 12)
                                    .overlay {
                                        Text(String(format: "%0.2f", entry.value))
                                            .frame(width: 20)
                                            .font(.system(size: 6, weight: .medium))
                                            .offset(y: -15)
                                    }
                                    .padding(.horizontal)
                            }
                            
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .chartYScale(domain: [55, 57])
                    .chartXAxisLabel(position: .bottom, alignment: .center) {
                        Text("Date")
                    }
                    .chartYAxisLabel(position: .leading, alignment: .center) {
                        Text("\(decimalStat.unitName)")
                    }
                    .frame(height: 200)
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                
                if (decimalStat.trackTotal == true) {
                    Section(header: Text("Total")) {
                        Text("Sum of entry values for all time: \(totalValue)")
                        Text("Sum of entry values for date range: \(dateRangeValue)")
                        
                    }
                    .padding(.horizontal)
                }
                
                if (decimalStat.trackAverage == true) {
                    Section(header: Text("Average")) {
                        Text("Average for all time: \(avgAllTime)")
                        Text("Average for date range: \(avgDateRange)")
                        
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    //TODO: Would I need this if used an Observable Object in a ViewModel?
    private func updateCalcs() {
        dateRangeEntries = ReportUtility.calcTotalEntriesDateRange(stat: decimalStat, startDate: startDate, endDate: endDate)
        largestDateRange = ReportUtility.calcLargestValueDateRange(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate)
        smallestDateRange = ReportUtility.calcSmallestValueDateRange(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate)
        dateRangeValue = ReportUtility.calcTotalValueDateRange(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate)
        avgDateRange = ReportUtility.calcAvgValueDateRange(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate)
        data = ReportUtility.createDayValueData(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate)
    }
}

//#Preview {
//    DecimalReport()
//}
