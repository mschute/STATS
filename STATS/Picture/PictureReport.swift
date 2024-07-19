import Charts
import SwiftUI

struct PictureReport: View {
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    @State var chartType: ChartType = .bar
    
    private var pictureStat: PictureStat
        
    //TODO: Need to determine which facts will be in this report
    
    @State var data: [CountDayData] = []
    
    init(pictureStat: PictureStat) {
        self.pictureStat = pictureStat
        _startDate = State(initialValue: pictureStat.created)
        //TODO: Need to add data and any other state properties I need
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
                    //TODO: NEED TO ADD FACTS
                }
                .padding()
                
                //TODO: NEED TO ADD CHART, Need to add picture marquee paired with stat
            }
        }
    }
    
    private func updateCalcs() {
//        timePeriodTotal = ReportUtility.calcTimePeriodTotal(stat: pictureStat, startDate: startDate, endDate: endDate)
//        (timeOfDay, timeOfDayCount) = ReportUtility.calcTimeOfDay(stat: pictureStat)
//        data = ReportUtility.createDayCountData(statEntries: pictureStat.statEntry, startDate: startDate, endDate: endDate)
    }
}

//#Preview {
//    CounterReport()
//}
