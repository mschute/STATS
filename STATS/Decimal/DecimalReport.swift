import Charts
import SwiftUI

struct DecimalReport: View {
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    @State var chartType: ChartType = .line
    
    private var decimalStat: DecimalStat
    
    //TODO: Need to come up with the unique analysis stats here based on total or average
    //TODO: Need to create data
    
    init(decimalStat: DecimalStat){
        self.decimalStat = decimalStat
        _startDate = State(initialValue: decimalStat.created)
        //TODO: Need to initialise some data and other potential stats
    }
    var body: some View {
        VStack {
            Text("Decimal Report")
                .font(.largeTitle)
            
            ScrollView {
                DateRangePicker(startDate: $startDate, endDate: $endDate)
                    .onChange(of: startDate, initial: true) { updateCalcs() }
                    .onChange(of: endDate, initial: true) { updateCalcs() }
            }
            
            VStack {
                Text("DATA")
                //TODO: Add data bits
            }
            .padding()
            
            //TODO: Add Chart based on data
        }
        
        
    }
    
    private func updateCalcs() {
//        timePeriodTotal = ReportUtility.calcTimePeriodTotal(stat: decimalStat, startDate: startDate, endDate: endDate)
//        (timeOfDay, timeOfDayCount) = ReportUtility.calcTimeOfDay(stat: counterStat)
//        data = ReportUtility.createDayCountData(statEntries: counterStat.statEntry, startDate: startDate, endDate: endDate)
    }
}

//#Preview {
//    DecimalReport()
//}
