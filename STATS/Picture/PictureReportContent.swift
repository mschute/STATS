import SwiftData
import SwiftUI

struct PictureReportContent: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \PictureEntry.timestamp) var pictureEntries: [PictureEntry]
    
    @Binding private var startDate: Date
    @Binding private var endDate: Date
    
    @State private var statSelection: AnyStat?
    @State private var stats: [AnyStat] = []
    @State private var filteredStatData: [AnyEntry] = []
    
    @Query(animation: .easeInOut) var counterStats: [CounterStat]
    @Query(animation: .easeInOut) var decimalStats: [DecimalStat]
    
    init(id: PersistentIdentifier, startDate: Binding<Date>, endDate: Binding<Date>) {
        self._startDate = startDate
        self._endDate = endDate
        _pictureEntries = Query(filter: PictureReportContent.predicate(id: id, startDate: startDate.wrappedValue, endDate: endDate.wrappedValue), sort: [SortDescriptor(\.timestamp)])
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Total entries:")
                        .fontWeight(.semibold)
                        .frame(alignment: .leading)
                    
                    Text("\(pictureEntries.count)")
                        .font(.custom("Menlo", size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(.counter)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
            .frame(maxWidth: .infinity)
            .formSectionMimic()
            
            VStack {
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
                .fontWeight(.semibold)
                .padding()
                
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(pictureEntries) { pictureEntry in
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
                                                Text("\(decimalEntry.value) \(decimalEntry.stat?.unitName ?? "")")
                                                    .padding(5)
                                                    .background(Color.black.opacity(0.7))
                                                    .foregroundColor(.white)
                                                    .clipShape(RoundedRectangle(cornerRadius: 5.0, style: .continuous))
                                                    .padding([.bottom, .trailing], 5)
                                            }
                                        }
                                        
                                        if let counterEntry = statEntry.entry as? CounterEntry {
                                            if (Calendar.current.isDate(counterEntry.timestamp, equalTo: pictureEntry.timestamp, toGranularity: .day)) {
                                                VStack {
                                                    Text("\(calcDaysBetween(from: counterEntry.stat?.created ?? Date(), to: counterEntry.timestamp)) days since started")
                                                    Text("\(counterEntry.stat?.statEntry.count ?? 0) entries since started")
                                                }
                                                .padding(5)
                                                .background(Color.black.opacity(0.7))
                                                .foregroundColor(.white)
                                                .clipShape(RoundedRectangle(cornerRadius: 5.0, style: .continuous))
                                                .padding([.bottom, .trailing], 5)
                                            }
                                        }
                                    }
                                }
                                Text("\(pictureEntry.timestamp.formatted(date: .abbreviated, time: .shortened))")
                                    .font(.custom("Menlo", size: 10))
                                    .foregroundColor(.gray)
                                    .padding(10)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .formSectionMimic()
        }
        .onAppear {
            combineStats()
        }
        .onChange(of: statSelection) {
            filteredStatData = createStatData(anyStat: statSelection ?? nil)
        }
        .onChange(of: startDate) {
            filteredStatData = createStatData(anyStat: statSelection ?? nil)
        }
        .onChange(of: endDate) {
            filteredStatData = createStatData(anyStat: statSelection ?? nil)
        }
    }
    
    
    private static func predicate(id: PersistentIdentifier, startDate: Date, endDate: Date) -> Predicate<PictureEntry> {
        return #Predicate<PictureEntry> {
            entry in entry.stat?.persistentModelID == id && (entry.timestamp >= startDate && entry.timestamp <= endDate)
        }
    }
    
    private func createStatData(anyStat: AnyStat?) -> [AnyEntry] {
        
        if let counterStat = anyStat?.stat as? CounterStat {
            return counterStat.statEntry.filter { $0.timestamp >= startDate && $0.timestamp <= endDate }.map { AnyEntry(entry: $0) }
        }
        
        if let decimalStat = anyStat?.stat as? DecimalStat {
            return decimalStat.statEntry.filter { $0.timestamp >= startDate && $0.timestamp <= endDate }.map { AnyEntry(entry: $0) }
        }
        
        return []
    }
    
    private func combineStats() {
        stats = []
        
        stats += counterStats.map { AnyStat(stat: $0) }
        stats += decimalStats.map { AnyStat(stat: $0) }
        
        sortStats()
    }
    
    private func sortStats() {
        stats.sort { $0.stat.name > $1.stat.name }
    }
    
    //Implementation: https://sarunw.com/posts/getting-number-of-days-between-two-dates/
    private func calcDaysBetween(from: Date, to: Date) -> Int {
        let calendar = Calendar.current
        let fromDate = calendar.startOfDay(for: from)
        let toDate = calendar.startOfDay(for: to)
        let numberOfDays = calendar.dateComponents([.day], from: fromDate, to: toDate)
        
        if let days = numberOfDays.day {
            return days + 1
        } else {
            return 0
        }
    }
}
