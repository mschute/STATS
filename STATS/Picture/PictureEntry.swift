import Foundation
import SwiftData
import SwiftUI

@Model
class PictureEntry: Entry, Identifiable {
    var entryId: UUID
    var timestamp: Date
    var note: String
    //Associated relationship must be optional / does not need @Relationship
    var stat: PictureStat?
    @Attribute(.externalStorage) var image: Data?
    
    init(entryId: UUID = UUID(), timestamp: Date = Date(), note: String = "", image: Data? = nil) {
        self.entryId = entryId
        self.timestamp = timestamp
        self.note = note
        self.image = image
    }
}

extension PictureEntry {
    static func addEntry(pictureStat: PictureStat, timestamp: Date, note: String, image: Data?) {
        let newEntry = PictureEntry(
            timestamp: timestamp,
            note: note,
            image: image
        )
        
        pictureStat.statEntry.append(newEntry)
    }
    
    static func saveEntry(pictureEntry: PictureEntry, timestamp: Date, note: String, selectedPhotoData: Data?, modelContext: ModelContext) {
        pictureEntry.timestamp = timestamp
        pictureEntry.note = note
        pictureEntry.image = selectedPhotoData
        
        //Save() not necessary but included it for clarity in the purpose of the method
        do {
            try modelContext.save()
        } catch {
            print("Error saving entry")
        }
    }
    
    static func deleteItems(offsets: IndexSet, entries: [PictureEntry], modelContext: ModelContext) {
        withAnimation {
            // Uses IndexSet to remove from [AnyStat] and ModelContext
            // Used IndexSet rather than Index for future scalability
            for index in offsets {
                modelContext.delete(entries[index])
            }
        }
    }
    
    static func predicate(id: PersistentIdentifier, startDate: Date, endDate: Date) -> Predicate<PictureEntry> {
        return #Predicate<PictureEntry> {
            entry in entry.stat?.persistentModelID == id && (entry.timestamp >= startDate && entry.timestamp <= endDate)
        }
    }
}

extension PictureEntry {
    static func createStatData(anyStat: AnyStat?, startDate: Date, endDate: Date) -> [AnyEntry] {
        
        if let counterStat = anyStat?.stat as? CounterStat {
            return counterStat.statEntry.filter { $0.timestamp >= startDate && $0.timestamp <= endDate }.map { AnyEntry(entry: $0) }
        }
        
        if let decimalStat = anyStat?.stat as? DecimalStat {
            return decimalStat.statEntry.filter { $0.timestamp >= startDate && $0.timestamp <= endDate }.map { AnyEntry(entry: $0) }
        }
        
        return []
    }
    
    static func combineStats(stats: inout [AnyStat], counterStats: [CounterStat], decimalStats: [DecimalStat]) {
        stats = []
        
        stats += counterStats.map { AnyStat(stat: $0) }
        stats += decimalStats.map { AnyStat(stat: $0) }
        
        sortStats(stats: &stats)
    }
    
    static func sortStats(stats: inout [AnyStat]) {
        stats.sort { $0.stat.name > $1.stat.name }
    }
    
    //Implementation: https://sarunw.com/posts/getting-number-of-days-between-two-dates/
    static func calcDaysBetween(from: Date, to: Date) -> Int {
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
