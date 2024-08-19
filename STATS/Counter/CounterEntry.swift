import Foundation
import SwiftData
import SwiftUI

@Model
class CounterEntry: Entry, Identifiable {
    var entryId: UUID
    var timestamp: Date
    var note: String
    //Associated relationship must be optional / does not need @Relationship https://www.youtube.com/watch?v=dAMFgq4tDPM
    //https://stackoverflow.com/questions/46092508/code-134110-validation-error-missing-attribute-values-on-mandatory-destination
    var stat: CounterStat?
    
    init(entryId: UUID = UUID(), timestamp: Date = Date(), note: String = "") {
        self.entryId = entryId
        self.timestamp = timestamp
        self.note = note
        self.stat = stat
    }
}

extension CounterEntry {
    static func calcTimeOfDay(counterEntries: [CounterEntry]) -> (timeOfDay: TimeOfDay, count: Int) {
        var timeOfDayCounts: [TimeOfDay: Int] = [
            .morning: 0,
            .afternoon: 0,
            .evening: 0,
            .overnight: 0
        ]
        
        let calendar = Calendar.current
        
        for entry in counterEntries {
            let hour = calendar.component(.hour, from: entry.timestamp)
            
            switch hour {
            case 6..<12:
                //https://www.hackingwithswift.com/sixty/2/6/dictionary-default-values
                timeOfDayCounts[.morning, default: 0] += 1
            case 12..<18:
                timeOfDayCounts[.afternoon, default: 0] += 1
            case 18..<24:
                timeOfDayCounts[.evening, default: 0] += 1
            default:
                timeOfDayCounts[.overnight, default: 0] += 1
            }
        }
        
        if let maxPeriod = timeOfDayCounts.max(by: { $0.value < $1.value } ) {
            return (timeOfDay: maxPeriod.key, count: maxPeriod.value)
        } else {
            return (timeOfDay: .morning, count: 0)
        }
    }
    
   static func findDayCount(counterEntries: [CounterEntry], startDate: Date, endDate: Date) -> [Date : Int] {
        var dateCounts: [Date : Int] = [:]
        let calendar = Calendar.current
        
        for entry in counterEntries {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                //https://developer.apple.com/documentation/foundation/calendar/2293783-startofday
                let date = calendar.startOfDay(for: entry.timestamp)
                dateCounts[date, default: 0] += 1
            }
        }
        return dateCounts
    }
    
    //https://developer.apple.com/documentation/swiftdata/filtering-and-sorting-persistent-data
    static func predicate(id: PersistentIdentifier, startDate: Date, endDate: Date) -> Predicate<CounterEntry> {
        return #Predicate<CounterEntry> {
            entry in entry.stat?.persistentModelID == id && (entry.timestamp >= startDate && entry.timestamp <= endDate)
        }
    }
}

extension CounterEntry {
    //Use append for inserting child objects into the model https://forums.swift.org/t/append-behaviour-in-swiftdata-arrays/72969/4
    static func addEntry(counterStat: CounterStat, timestamp: Date, note: String) {
        let newEntry = CounterEntry(
            timestamp: timestamp,
            note: note
        )
        counterStat.statEntry.append(newEntry)
    }
    
    static func saveEntry(counterEntry: CounterEntry, timestamp: Date, note: String, modelContext: ModelContext) {
        counterEntry.timestamp = timestamp
        counterEntry.note = note
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving entry")
        }
    }
    
    static func deleteItems(offsets: IndexSet, entries: [CounterEntry], modelContext: ModelContext) {
        withAnimation {
            // Uses IndexSet to remove from [AnyStat] and ModelContext
            for index in offsets {
                do {
                    modelContext.delete(entries[index])
                    try modelContext.save()
                } catch {
                        print("Error deleting entry")
                    }
            }
        }
    }
}
