import SwiftData
import SwiftUI

struct PictureReport: View {
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    private var pictureStat: PictureStat
    
    @State var pictureData: [PictureData] = []
    
//    private var sortedPictureEntries: [PictureEntry] {
//        pictureStat.statEntry.sorted { $0.timestamp < $1.timestamp}
//    }
    
    private var filteredPictureData: [PictureData] {
        pictureData.filter { $0.timestamp >= startDate && $0.timestamp <= endDate }
    }
    
    @State private var total: Int = 0
    
    @State private var statSelection: AnyStat?
    @State private var stats: [AnyStat] = []
    @State private var filteredStatData: [AnyEntry] = []
    
    @Query(animation: .easeInOut) private var counterStats: [CounterStat]
    @Query(animation: .easeInOut) private var decimalStats: [DecimalStat]
    
    init(pictureStat: PictureStat) {
        self.pictureStat = pictureStat
        _startDate = State(initialValue: pictureStat.created)
        _total = State(initialValue: ReportUtility.calcTotalEntries(stat: pictureStat, startDate: startDate, endDate: endDate))
    }
    
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
                    
                    Text("Total entries in date range: \(total)")
                    
                    LabeledContent("Pair a stat") {
                        Picker("Pair stat", selection: $statSelection) {
                            Text("").tag(nil as AnyStat?)
                            ForEach(stats) { stat in
                                Text(stat.stat.name)
                                    .tag(stat as AnyStat?)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(sortedPictureEntries) { pictureEntry in
                                VStack {
                                    ZStack(alignment: .bottom) {
                                        if let imageData = pictureEntry.image, let uiImage = UIImage(data: imageData) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(maxWidth: 250, maxHeight: 250)
                                                .clipped()
                                        }
                                        
                                        ForEach(filteredStatData) { statEntry in
                                            //Compare timestamps https://www.hackingwithswift.com/example-code/system/how-to-check-whether-one-date-is-similar-to-another
                                            if let decimalEntry = statEntry.entry as? DecimalEntry {
                                                if (Calendar.current.isDate(decimalEntry.timestamp, equalTo: pictureEntry.timestamp, toGranularity: .day)) {
                                                    Text("\(decimalEntry.value) \(decimalEntry.decimalStat?.unitName ?? "")")
                                                        .padding(5)
                                                        .background(Color.black.opacity(0.7))
                                                        .foregroundColor(.white)
                                                        .cornerRadius(5)
                                                        .padding([.bottom, .trailing], 5)
                                                }
                                            }
                                            
                                            if let counterEntry = statEntry.entry as? CounterEntry {
                                                if (Calendar.current.isDate(counterEntry.timestamp, equalTo: pictureEntry.timestamp, toGranularity: .day)) {
                                                    VStack {
                                                        Text("\(calcDaysBetween(from: counterEntry.counterStat?.created ?? Date(), to: counterEntry.timestamp)) days since started")
                                                        Text("\(counterEntry.counterStat?.statEntry.count ?? 0) entries since started")
                                                    }
                                                    .padding(5)
                                                    .background(Color.black.opacity(0.7))
                                                    .foregroundColor(.white)
                                                    .cornerRadius(5)
                                                    .padding([.bottom, .trailing], 5)
                                                }
                                            }
                                        }
                                    }
                                    Text("\(pictureEntry.timestamp.formatted(date: .abbreviated, time: .shortened))")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
//                            ForEach(filteredPictureData) { pictureEntry in
//                                VStack {
//                                    ZStack(alignment: .bottom) {
//                                        if let imageData = pictureEntry.image, let uiImage = UIImage(data: imageData) {
//                                            Image(uiImage: uiImage)
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(maxWidth: 250, maxHeight: 250)
//                                                .clipped()
//                                        }
//                                        
//                                        ForEach(filteredStatData) { statEntry in
//                                            //Compare timestamps https://www.hackingwithswift.com/example-code/system/how-to-check-whether-one-date-is-similar-to-another
//                                            if let decimalEntry = statEntry.entry as? DecimalEntry {
//                                                if (Calendar.current.isDate(decimalEntry.timestamp, equalTo: pictureEntry.timestamp, toGranularity: .day)) {
//                                                    Text("\(decimalEntry.value) \(decimalEntry.decimalStat?.unitName ?? "")")
//                                                        .padding(5)
//                                                        .background(Color.black.opacity(0.7))
//                                                        .foregroundColor(.white)
//                                                        .cornerRadius(5)
//                                                        .padding([.bottom, .trailing], 5)
//                                                }
//                                            }
//                                            
//                                            if let counterEntry = statEntry.entry as? CounterEntry {
//                                                if (Calendar.current.isDate(counterEntry.timestamp, equalTo: pictureEntry.timestamp, toGranularity: .day)) {
//                                                    VStack {
//                                                        Text("\(calcDaysBetween(from: counterEntry.counterStat?.created ?? Date(), to: counterEntry.timestamp)) days since started")
//                                                        Text("\(counterEntry.counterStat?.statEntry.count ?? 0) entries since started")
//                                                    }
//                                                    .padding(5)
//                                                    .background(Color.black.opacity(0.7))
//                                                    .foregroundColor(.white)
//                                                    .cornerRadius(5)
//                                                    .padding([.bottom, .trailing], 5)
//                                                }
//                                            }
//                                        }
//                                    }
//                                    Text("\(pictureEntry.timestamp.formatted(date: .abbreviated, time: .shortened))")
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
//                                }
//                            }
                        }
                    }
                }
            }
            .padding(.horizontal)

        }
        .onAppear {
            pictureData = createPictureData(pictureStat: pictureStat)
            combineStats()
        }
        .onChange(of: statSelection){
            filteredStatData = createStatData(anyStat: statSelection ?? nil)
        }
    }
    
    private func updateCalcs() {
        total = ReportUtility.calcTotalEntries(stat: pictureStat, startDate: startDate, endDate: endDate)
    }
    
    func createPictureData(pictureStat: PictureStat) -> [PictureData] {
        var newPictureDataArray: [PictureData] = []
        
        for entry in pictureStat.statEntry {
            if let unwrappedImage = entry.image {
                let newPictureData = PictureData(id: UUID(), timestamp: entry.timestamp, image: unwrappedImage)
                newPictureDataArray.append(newPictureData)
            }
        }
        
        return newPictureDataArray.sorted { $0.timestamp < $1.timestamp}
    }
    
    func createStatData(anyStat: AnyStat?) -> [AnyEntry] {
        
        if let counterStat = anyStat?.stat as? CounterStat {
            return counterStat.statEntry.filter { $0.timestamp >= startDate && $0.timestamp <= endDate }.map { AnyEntry(entry: $0) }
        }
        
        if let decimalStat = anyStat?.stat as? DecimalStat {
            return decimalStat.statEntry.filter { $0.timestamp >= startDate && $0.timestamp <= endDate }.map { AnyEntry(entry: $0) }
        }
        
        return []
    }
    
    func combineStats() {
        stats = []
        
        stats += counterStats.map { AnyStat(stat: $0) }
        stats += decimalStats.map { AnyStat(stat: $0) }
        
        sortStats()
    }
    
    func sortStats() {
        stats.sort { $0.stat.name > $1.stat.name }
    }
    
    //Implementation: https://sarunw.com/posts/getting-number-of-days-between-two-dates/
    func calcDaysBetween(from: Date, to: Date) -> Int {
        let calendar = Calendar.current
        let fromDate = calendar.startOfDay(for: from)
        let toDate = calendar.startOfDay(for: to)
        let numberOfDays = calendar.dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day! + 1
    }
    
    //@ViewBuilder solution: https://stackoverflow.com/questions/74605422/function-declares-an-opaque-return-type-some-view-but-the-return-statements-i
    @ViewBuilder
    private func renderImage(pictureEntry: PictureData) -> some View {
        if let imageData = pictureEntry.image, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 250, maxHeight: 250)
                .clipped()
        }
    }
}




//#Preview {
//    CounterReport()
//}
