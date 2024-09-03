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
    
    @Query() var counterStats: [CounterStat]
    @Query() var decimalStats: [DecimalStat]
    
    init(id: PersistentIdentifier, startDate: Binding<Date>, endDate: Binding<Date>) {
        self._startDate = startDate
        self._endDate = endDate
        _pictureEntries = Query(filter: PictureEntry.predicate(id: id, startDate: startDate.wrappedValue, endDate: endDate.wrappedValue), sort: [SortDescriptor(\.timestamp)])
    }
    
    var body: some View {
        if !pictureEntries.isEmpty {
            Group {
                Section(header: Text("")) {
                    HStack {
                        Text("Total entries:")
                            .fontWeight(.semibold)
                            .frame(alignment: .leading)
                        
                        Text("\(pictureEntries.count)")
                            .font(.custom("Menlo", size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(.picture)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                
                Section(header: Text("")) {
                    LabeledContent("Pair a stat") {
                        Picker("", selection: $statSelection) {
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
                                                    Text("\(String(format: "%.2f", decimalEntry.value)) \(decimalEntry.stat?.unitName ?? "")")
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
                                                        Text("\(PictureStat.calcDaysBetween(from: counterEntry.stat?.created ?? Date(), to: counterEntry.timestamp)) days since started")
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
            }
            .onAppear {
                PictureEntry.combineStats(stats: &stats, counterStats: counterStats, decimalStats: decimalStats)
            }
            .onChange(of: statSelection) {
                filteredStatData = PictureStat.createStatData(anyStat: statSelection ?? nil, startDate: startDate, endDate: endDate)
            }
            .onChange(of: startDate) {
                filteredStatData = PictureStat.createStatData(anyStat: statSelection ?? nil, startDate: startDate, endDate: endDate)
            }
            .onChange(of: endDate) {
                filteredStatData = PictureStat.createStatData(anyStat: statSelection ?? nil, startDate: startDate, endDate: endDate)
            }
        } else {
            Section(header: Text("")) {
                Text("No available data")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
