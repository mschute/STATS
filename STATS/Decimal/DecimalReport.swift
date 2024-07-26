import Charts
import SwiftUI

struct DecimalReport: View {
    var decimalStat: DecimalStat
    var chartType: ChartType = .line
    
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    @State var chartYLow: Double = 0.0
    @State var chartYHigh: Double = 100.0
    @State var data: [ValueDayData] = []
    
    @State var entriesCount: Int = 0
    
    @State var largestValue: Double = 0.0
    @State var smallestValue: Double = 0.0
    
    @State var sum: Double = 0.0
    @State var average: Double = 0.0
    
    //TODO: DO I create a function to calculate report range but use the calc smallest value and largest value functions to do it?
    //TODO: Question, the Report is not dealing with @Model, should this have an associated ObservableObject or ViewModel?
    init(decimalStat: DecimalStat){
        self.decimalStat = decimalStat
        _startDate = State(initialValue: decimalStat.created)
        _entriesCount = State(initialValue: ReportUtility.calcTotalEntries(stat: decimalStat, startDate: startDate, endDate: endDate))
        _largestValue = State(initialValue: calcLargestValue(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate))
        _smallestValue = State(initialValue: calcSmallestValue(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate))
        _sum = State(initialValue: calcTotalValue(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate))
        _average = State(initialValue: calcAvgValue(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate))
        _data = State(initialValue: createDayValueData(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate))
        _chartYLow = State(initialValue: smallestValue)
        _chartYHigh = State(initialValue: largestValue)
    }
    
    var body: some View {
        VStack {
            Text("Decimal Report")
                .font(.largeTitle)
            
            ScrollView {
                //TODO: Refactor date range so it cant be selected before the start of the stat
                DateRangePicker(startDate: $startDate, endDate: $endDate)
                    .onChange(of: startDate, initial: true) { updateCalcs() }
                    .onChange(of: endDate, initial: true) { updateCalcs() }
                 
                Section(header: Text("Date Range")) {
                    Text("Total entries for date range: \(entriesCount)")
                    Text("Largest value for date range: \(largestValue)")
                    Text("Smallest value for date range: \(smallestValue)")
                    
                    //Adjusting look of line chart https://blog.stackademic.com/line-chart-using-swift-charts-swiftui-cd1abeac9e44
                    Chart {
                        ForEach(data) { entry in
                            LineMark(
                                x: .value("Date", entry.day),
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
                    //TODO: Need to adjust the range to be based on the values in the entries plus buffer
                    .chartYScale(domain: [chartYLow, chartYHigh])
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
                        Text("Sum of entry values for date range: \(sum)")
                        
                    }
                    .padding(.horizontal)
                }
                
                if (decimalStat.trackAverage == true) {
                    Section(header: Text("Average")) {
                        Text("Average for date range: \(average)")
                        
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    private func updateCalcs() {
        entriesCount = ReportUtility.calcTotalEntries(stat: decimalStat, startDate: startDate, endDate: endDate)
        largestValue = calcLargestValue(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate)
        smallestValue = calcSmallestValue(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate)
        sum = calcTotalValue(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate)
        average = calcAvgValue(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate)
        data = createDayValueData(statEntries: decimalStat.statEntry, startDate: startDate, endDate: endDate)
    }
    
    func calcSmallestValue (statEntries: [DecimalEntry], startDate: Date, endDate: Date) -> Double {
        if(statEntries.isEmpty) {
            return 0.0
        }
        
        var smallestValue = statEntries[0].value
        
        for entry in statEntries {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                if (entry.value < smallestValue) {
                    smallestValue = entry.value
                }
            }
        }
        return smallestValue
    }
    
    func calcLargestValue (statEntries: [DecimalEntry], startDate: Date, endDate: Date) -> Double {
        if(statEntries.isEmpty) {
            return 0.0
        }
        
        var largestValue = statEntries[0].value
        
        for entry in statEntries {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                if (entry.value > largestValue) {
                    largestValue = entry.value
                }
            }
        }
        return largestValue
    }
    
    func calcTotalValue (statEntries: [DecimalEntry], startDate: Date, endDate: Date) -> Double {
        if(statEntries.isEmpty) {
            return 0.0
        }
        
        var sumValue = 0.0
        
        for entry in statEntries {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                sumValue += entry.value
            }
        }
        return sumValue
    }
    
    func calcAvgValue (statEntries: [DecimalEntry], startDate: Date, endDate: Date) -> Double {
        if(statEntries.isEmpty) {
            return 0.0
        }
        
        var sumValue = 0.0
        var count = 0.0
        
        for entry in statEntries {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                sumValue += entry.value
                count += 1
            }
        }
        return sumValue / count
    }
    
    func createDayValueData(statEntries: [DecimalEntry], startDate: Date, endDate: Date) -> [ValueDayData] {
        var dateValues: [Date : Double] = [:]
        let calendar = Calendar.current
        
        for entry in statEntries {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                //https://developer.apple.com/documentation/foundation/calendar/2293783-startofday
                let date = calendar.startOfDay(for: entry.timestamp)
                dateValues[date, default: 0] += entry.value
            }
        }
        
        let data = dateValues.map{ ValueDayData(day: $0.key, value: $0.value) }
        //Sorting https://stackoverflow.com/questions/25377177/sort-dictionary-by-keys
        return data.sorted(by: { $0.day < $1.day })
    }
}

//#Preview {
//    DecimalReport()
//}
