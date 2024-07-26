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
    }
    
    //https://www.kodeco.com/36025169-swift-charts-tutorial-getting-started/page/4?page=1#toc-anchor-001
    //Tutorial for marquee: https://talk.objc.io/episodes/S01E374-interactive-marquee-view-part-1
    var body: some View {
        VStack {
            Text("Report")
                .font(.largeTitle)
            
            ScrollView {
                DateRangePicker(startDate: $startDate, endDate: $endDate)
                    .onChange(of: startDate, initial: true) { updateCalcs() }
                    .onChange(of: endDate, initial: true) { updateCalcs() }
                    .padding()
                
                VStack {
                    ScrollView(.horizontal) {
                        HStack(spacing: 40) {
                            ForEach(pictureStat.statEntry) { entry in
                                VStack(spacing: 20) {
                                    if let imageData = entry.image, let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: 250, maxHeight: 250)
                                        
                                    }

                                    Text("\(entry.timestamp)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                
                
                //Need a marquee of the pictures
                //Label with timestamp underneath the picture?
                //Need a dropdown menu of different Stats - Just the names
                //Need an overlay of the decimal value on top of the picture
                //How would I do count? #2nd entry?
                
                //Count of pictures taken in date range
                
                
            }
            .padding(.horizontal)
            
            //TODO: NEED TO ADD CHART, Need to add picture marquee paired with stat
        }
    }
}

private func updateCalcs() {
    //        timePeriodTotal = ReportUtility.calcTimePeriodTotal(stat: pictureStat, startDate: startDate, endDate: endDate)
    //        (timeOfDay, timeOfDayCount) = ReportUtility.calcTimeOfDay(stat: pictureStat)
    //        data = ReportUtility.createDayCountData(statEntries: pictureStat.statEntry, startDate: startDate, endDate: endDate)
}


//#Preview {
//    CounterReport()
//}
