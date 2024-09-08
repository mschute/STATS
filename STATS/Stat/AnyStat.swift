import Foundation
import SwiftData
import SwiftUI

class AnyStat: Identifiable, Hashable {
    var stat: any Stat
    
    init(stat: any Stat) {
        self.stat = stat
    }
    
    //Could this be removed if I change the ForEach in StatList to identify by id?
    //Conform to hashable https://www.hackingwithswift.com/forums/swift/form-picker-error-requires-that-x-conform-to-hashable/19961
    static func == (lhs: AnyStat, rhs: AnyStat) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension AnyStat {
    static func updateDateRange(stat: any Stat, dateRange: inout (startDate: Date, endDate: Date), startDate: inout Date, endDate: inout Date) {
        dateRange = AnyEntry.getEntryDateRange(entryArray: stat.statEntry)
        startDate = dateRange.startDate
        endDate = dateRange.endDate
    }
}

extension AnyStat {
    //Index set and offsets for deleting https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-delete-rows-from-a-list
    static func deleteItems(offsets: IndexSet, stats: [AnyStat], modelContext: ModelContext) {
        withAnimation {
            // Uses IndexSet to remove from [AnyStat] and ModelContext
            for index in offsets {
                remove(stat: stats[index].stat, modelContext: modelContext)
            }
        }
    }
    
    static func remove(stat: any Stat, modelContext: ModelContext) {
        if let stat = stat as? CounterStat {
            modelContext.delete(stat)
        } else if let stat = stat as? DecimalStat {
            modelContext.delete(stat)
        } else if let stat = stat as? PictureStat {
            modelContext.delete(stat)
        }
    }
    
    static func sortStats(sortType: SortType, stats: inout [AnyStat], isCreatedAscending: inout Bool, isNameAscending: inout Bool) {
        
        switch sortType {
        case .created where isCreatedAscending == false:
            stats.sort { $0.stat.created < $1.stat.created}
            isCreatedAscending = true
        case .created:
            stats.sort { $0.stat.created > $1.stat.created }
            isCreatedAscending = false
        case .name where isNameAscending == false:
            stats.sort { $0.stat.name < $1.stat.name }
            isNameAscending = true
        case .name:
            stats.sort { $0.stat.name > $1.stat.name }
            isNameAscending = false
        }
    }
}

extension AnyStat {
    static func CardLatestEntryContent(stat: any Stat) -> some View {
        //https://sarunw.com/posts/optional-binding-switch-case/#:~:text=When%20you%20want%20to%20unwrap,let%20or%20guard%20let%20syntax.&text=print(%22Hello%2C%20%5C(name)!%22)&text=print(%22Hello%2C%20World!%22)
        switch stat {
        case let stat as CounterStat:
            return AnyView(CounterCardLatestEntry(stat: stat))
        case let stat as DecimalStat:
            return AnyView(DecimalCardLatestEntry(stat: stat))
        case let stat as PictureStat:
            return AnyView(PictureCardLatestEntry(stat: stat))
        default:
            return AnyView(
                Section(header: Text("")) {
                    Text("No entry data")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            )
        }
    }
    
    static func EntryCardDestination(statEntry: any Entry) -> some View {
        switch statEntry {
        case let statEntry as CounterEntry:
            return AnyView(CounterEntryFormEdit(counterEntry: statEntry))
        case let statEntry as DecimalEntry:
            return AnyView(DecimalEntryFormEdit(decimalEntry: statEntry))
        case let statEntry as PictureEntry:
            return AnyView(PictureEntryFormEdit(pictureEntry: statEntry))
        default:
            return AnyView(
                Section(header: Text("")) {
                    Text("No entry data")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            )
        }
    }

    static func StatEditForm(stat: any Stat) -> some View {
        switch stat {
        case let stat as CounterStat:
            return AnyView(CounterFormEdit(counterStat: stat))
        case let stat as DecimalStat:
            return AnyView(DecimalFormEdit(decimalStat: stat))
        case let stat as PictureStat:
            return AnyView(PictureFormEdit(pictureStat: stat))
        default:
            return AnyView(
                Section(header: Text("")) {
                    Text("No stat available")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            )
        }
    }
    
    static func EntryForm(stat: any Stat) -> some View {
        switch stat {
        case let stat as CounterStat:
            return AnyView(CounterEntryForm(counterStat: stat))
        case let stat as DecimalStat:
            return AnyView(DecimalEntryForm(decimalStat: stat))
        case let stat as PictureStat:
            return AnyView(PictureEntryForm(pictureStat: stat))
        default:
            return AnyView(
                Section(header: Text("")) {
                    Text("No stat available")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            )
        }
    }
    
    static func EntryList(stat: any Stat, startDate: Binding<Date>, endDate: Binding<Date>) -> some View {
        let id = stat.persistentModelID
        
        if(stat.statEntry.isEmpty) {
            return AnyView(
                Section(header: Text("")) {
                    Text("No current entries")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            )
        }
        
        switch stat {
        case is CounterStat:
            return AnyView(CounterEntryList(id: id, startDate: startDate, endDate: endDate))
        case is DecimalStat:
            return AnyView(DecimalEntryList(id: id, startDate: startDate, endDate: endDate))
        case is PictureStat:
            return AnyView(PictureEntryList(id: id, startDate: startDate, endDate: endDate))
        default:
            return AnyView(Text(""))
        }
    }
    
    static func ReportContent(stat: any Stat, startDate: Binding<Date>, endDate: Binding<Date>) -> some View {
        let id = stat.persistentModelID
        
        if(stat.statEntry.isEmpty) {
            return AnyView(
                Section(header: Text("")) {
                    Text("No available data")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            )
        }
        
        switch stat {
        case is CounterStat:
            return AnyView(CounterReportContent(id: id, startDate: startDate, endDate: endDate))
        case is DecimalStat:
            return AnyView(DecimalReportContent(id: id, startDate: startDate, endDate: endDate))
        case is PictureStat:
            return AnyView(PictureReportContent(id: id, startDate: startDate, endDate: endDate))
        default:
            return AnyView(Text(""))
        }
    }
}

extension AnyStat {
    //https://www.hackingwithswift.com/example-code/language/how-to-use-map-to-transform-an-array
    //https://www.tutorialspoint.com/how-do-i-concatenate-or-merge-arrays-in-swift
    static func combineAllStats(stats: inout [AnyStat], filteredCounterStats: [CounterStat], filteredDecimalStats: [DecimalStat], filteredPictureStats: [PictureStat]) {
        stats = []
        
        stats += filteredCounterStats.map { AnyStat(stat: $0) }
        stats += filteredDecimalStats.map { AnyStat(stat: $0) }
        stats += filteredPictureStats.map { AnyStat(stat: $0) }
        
        sortAllStats(stats: &stats)
    }
    
    static func sortAllStats(stats: inout [AnyStat]) {
        stats.sort { $0.stat.created > $1.stat.created }
    }
}
