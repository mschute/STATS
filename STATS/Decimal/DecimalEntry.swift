import Foundation
import SwiftData
import SwiftUI

@Model
class DecimalEntry: Entry, Identifiable {
    var entryId: UUID
    var timestamp: Date
    var value: Double
    var note: String
    //Associated relationship must be optional / does not need @Relationship
    var stat: DecimalStat?
    
    init(entryId: UUID = UUID(), timestamp: Date = Date(), value: Double = 0.0, note: String = "") {
        self.entryId = entryId
        self.timestamp = timestamp
        self.value = value
        self.note = note
    }
}

extension DecimalEntry {
    static func addEntry(decimalStat: DecimalStat, timestamp: Date, value: String, note: String, alertMessage: inout String, showAlert: inout Bool) {
        
        if !validateValueEntry(value: value, alertMessage: &alertMessage, showAlert: &showAlert) {
            return
        }
        
        let newEntry = DecimalEntry(
            timestamp: timestamp,
            value: Double(value) ?? 0.0,
            note: note
        )
        decimalStat.statEntry.append(newEntry)
    }
    
    static func saveEntry(decimalEntry: DecimalEntry, value: String, timestamp: Date, note: String, alertMessage: inout String, showAlert: inout Bool, modelContext: ModelContext) {
        
        if !validateValueEntry(value: value, alertMessage: &alertMessage, showAlert: &showAlert) {}
        
        decimalEntry.value = Double(value) ?? 0.0
        decimalEntry.timestamp = timestamp
        decimalEntry.note = note
        
        //Save() not necessary but included it for clarity in the purpose of the method
        do {
            try modelContext.save()
        } catch {
            print("Error saving entry")
        }
    }
    
    static func predicate(id: PersistentIdentifier, startDate: Date, endDate: Date) -> Predicate<DecimalEntry> {
        return #Predicate<DecimalEntry> {
            entry in entry.stat?.persistentModelID == id && (entry.timestamp >= startDate && entry.timestamp <= endDate)
        }
    }
    
    static func deleteItems(offsets: IndexSet, entries: [DecimalEntry], modelContext: ModelContext) {
        withAnimation {
            // Uses IndexSet to remove from [AnyStat] and ModelContext
            // Set to Index set rather than Index for scalability
            for index in offsets {
                    modelContext.delete(entries[index])
            }
        }
    }
}

extension DecimalEntry {  
    static func validateValueEntry(value: String, alertMessage: inout String, showAlert: inout Bool) -> Bool {
        if(value.isEmpty) {
            alertMessage = "Must add value"
            showAlert = true
            return false
        } else if (ValidationUtility.moreThanOneDecimalPoint(value: value)) {
            alertMessage = "Invalid value"
            showAlert = true
            return false
        } else if (ValidationUtility.decimalNumberTooBig(value: value)) {
            alertMessage = "Value is too big"
            showAlert = true
            return false
        } else if (ValidationUtility.intNumberTooBig(value: value)) {
            alertMessage = "Value is too big"
            showAlert = true
            return false
        }
        return true
    }
    
    static func createDayTotalValueData(decimalEntries: [DecimalEntry]) -> [ValueDayData] {
        var dateValues: [Date : Double] = [:]
        let calendar = Calendar.current
        
        if (decimalEntries.isEmpty) { return [] }
        
        for entry in decimalEntries {
            let date = calendar.startOfDay(for: entry.timestamp)
            dateValues[date, default: 0] += entry.value
        }
        
        let data = dateValues.map{ ValueDayData(day: $0.key, value: $0.value) }
        //Sorting https://stackoverflow.com/questions/25377177/sort-dictionary-by-keys
        return data.sorted(by: { $0.day < $1.day })
    }
    
    static func createDayAvgValueData(decimalEntries: [DecimalEntry]) -> [ValueDayData] {
        var dateValues: [Date : (total: Double, count: Int)] = [:]
        let calendar = Calendar.current
        
        if (decimalEntries.isEmpty) { return [] }
        
        for entry in decimalEntries {
            let date = calendar.startOfDay(for: entry.timestamp)
            if dateValues[date] == nil {
                dateValues[date] = (total: 0, count: 0)
            }
            dateValues[date]?.total += entry.value
            dateValues[date]?.count += 1
        }
        
        let data = dateValues.map{ ValueDayData(day: $0.key, value: $0.value.total / Double ($0.value.count)) }
        return data.sorted(by: { $0.day < $1.day })
    }
}
