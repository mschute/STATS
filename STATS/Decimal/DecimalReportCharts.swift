import Charts
import SwiftUI

struct DecimalReportCharts: View {
    var decimalEntries: [DecimalEntry]
    var data: [ValueDayData] = []
    var chartValueType: ChartValueType
    
    var chartYLow: Double {
        let minValue = decimalEntries.min(by: {$0.value < $1.value} )?.value ?? 0.0
        let pad = minValue * 0.2
        return minValue - pad
    }
    var chartYHigh: Double {
        let maxValue = decimalEntries.max(by: {$0.value < $1.value} )?.value ?? 0.0
        let pad = maxValue * 0.2
        return maxValue + pad
    }
    
    init(decimalEntries: [DecimalEntry], chartValueType: ChartValueType) {
        self.decimalEntries = decimalEntries
        self.chartValueType = chartValueType
        
        if (chartValueType == .total) {
            self.data = createDayTotalValueData(decimalEntries: decimalEntries)
        } else {
            self.data = createDayAvgValueData(decimalEntries: decimalEntries)
        }
    }
    
    var body: some View {
        //Adjusting look of line chart https://blog.stackademic.com/line-chart-using-swift-charts-swiftui-cd1abeac9e44
        VStack {
            Chart {
                ForEach(data) { entry in
                    LineMark(
                        x: .value("Date", entry.day),
                        y: .value("\(decimalEntries[0].stat?.unitName ?? "")", entry.value)
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
            .chartYScale(domain: [chartYLow, chartYHigh])
            .chartXAxisLabel(position: .bottom, alignment: .center) {
                Text("Date")
            }
            .chartYAxisLabel(position: .leading, alignment: .center) {
                Text("\(decimalEntries[0].stat?.unitName ?? "")")
            }
            .frame(height: 200)
            .padding(.horizontal)
        }
    }
    
    func createDayTotalValueData(decimalEntries: [DecimalEntry]) -> [ValueDayData] {
        var dateValues: [Date : Double] = [:]
        let calendar = Calendar.current
        
        if (decimalEntries.isEmpty) { return [] }
        
        for entry in decimalEntries {
            //https://developer.apple.com/documentation/foundation/calendar/2293783-startofday
            let date = calendar.startOfDay(for: entry.timestamp)
            dateValues[date, default: 0] += entry.value
        }
        
        let data = dateValues.map{ ValueDayData(day: $0.key, value: $0.value) }
        //Sorting https://stackoverflow.com/questions/25377177/sort-dictionary-by-keys
        return data.sorted(by: { $0.day < $1.day })
    }
    
    func createDayAvgValueData(decimalEntries: [DecimalEntry]) -> [ValueDayData] {
        var dateValues: [Date : (total: Double, count: Int)] = [:]
        let calendar = Calendar.current
        
        if (decimalEntries.isEmpty) { return [] }
        
        for entry in decimalEntries {
            //https://developer.apple.com/documentation/foundation/calendar/2293783-startofday
            let date = calendar.startOfDay(for: entry.timestamp)
            if dateValues[date] == nil {
                dateValues[date] = (total: 0, count: 0)
            }
            dateValues[date]?.total += entry.value
            dateValues[date]?.count += 1
        }
        
        let data = dateValues.map{ ValueDayData(day: $0.key, value: $0.value.total / Double ($0.value.count)) }
        //Sorting https://stackoverflow.com/questions/25377177/sort-dictionary-by-keys
        return data.sorted(by: { $0.day < $1.day })
    }
}

//#Preview {
//    DecimalReportCharts()
//}
