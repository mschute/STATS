import Charts
import SwiftUI

struct DecimalReportCharts: View {
    private var decimalEntries: [DecimalEntry]
    private var data: [ValueDayData] = []
    private var chartValueType: ChartValueType
    
    private var chartYLow: Double {
        let minValue = decimalEntries.min(by: {$0.value < $1.value} )?.value ?? 0.0
        let pad = minValue * 0.2
        return minValue - pad
    }
    private var chartYHigh: Double {
        let maxValue = decimalEntries.max(by: {$0.value < $1.value} )?.value ?? 0.0
        let pad = maxValue * 0.2
        return maxValue + pad
    }
    
    init(decimalEntries: [DecimalEntry], chartValueType: ChartValueType) {
        self.decimalEntries = decimalEntries
        self.chartValueType = chartValueType
        
        if (chartValueType == .total) {
            self.data = DecimalEntry.createDayTotalValueData(decimalEntries: decimalEntries)
        } else {
            self.data = DecimalEntry.createDayAvgValueData(decimalEntries: decimalEntries)
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
                        .foregroundStyle(.mint)
                        .interpolationMethod(.catmullRom)
                        .lineStyle(.init(lineWidth: 2))
                        .symbol {
                            Circle()
                                .fill(.mint)
                                .frame(width: 12, height: 12)
                                .overlay {
                                    Text(String(format: "%0.2f", entry.value))
                                        .frame(width: 20)
                                        .font(.system(size: 7, weight: .medium))
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
                        .font(.custom("Menlo", size: 16))
                }
                .chartYAxisLabel(position: .leading, alignment: .center) {
                    Text("\(decimalEntries[0].stat?.unitName ?? "")")
                        .font(.custom("Menlo", size: 16))
                }
                .frame(height: 200)
                .padding(.horizontal)
            }
        }
    }
