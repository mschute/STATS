import Foundation
import SwiftData
import SwiftUI

@Model
final class DecimalEntry: Entry, Identifiable {
    var timestamp: Date
    var value: Double
    var note: String
    //Associated relationship must be optional / does not need @Relationship
    var stat: DecimalStat?
    
    init(timestamp: Date = Date(), value: Double = 0.0, note: String = "") {
        self.timestamp = timestamp
        self.value = value
        self.note = note
    }
}

extension DecimalEntry {
    static func addEntry(decimalStat: DecimalStat, timestamp: Date, value: String, note: String, alertMessage: inout String, showAlert: inout Bool, modelContext: ModelContext) {
        
        if !validateValueEntry(value: value, alertMessage: &alertMessage, showAlert: &showAlert) {
            return
        }
        
        let newEntry = DecimalEntry(
            timestamp: timestamp,
            value: Double(value) ?? 0.0,
            note: note
        )
        decimalStat.statEntry.append(newEntry)
        
        //Save() not necessary but included it for clarity in the purpose of the method
        do {
            try modelContext.save()
        } catch {
            print("Error adding entry")
        }
    }
    
    static func saveEntry(decimalEntry: DecimalEntry, value: String, timestamp: Date, note: String, alertMessage: inout String, showAlert: inout Bool, modelContext: ModelContext) {
        
        if !validateValueEntry(value: value, alertMessage: &alertMessage, showAlert: &showAlert) {
            return
        }
        
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
    
    // TODO: Can remove IndexSet because working directly on the model
    // TODO: Put delete directly in the views?
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
        
        return dateValues.map{ ValueDayData(day: $0.key, value: $0.value) }
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
        
        return dateValues.map{ ValueDayData(day: $0.key, value: $0.value.total / Double ($0.value.count)) }
    }
    
    //TODO: Combine this with the one in counter
    static func calculateTotalForDateRange(filteredDecimals: [AnyEntry], photoTimestamp: Date) -> Double {
        var total = 0.0
        
        for decimalEntry in filteredDecimals {
            if let decimalEntry = decimalEntry.entry as? DecimalEntry {
                if Calendar.current.compare(decimalEntry.timestamp, to: photoTimestamp, toGranularity: .day) != .orderedSame {
                    total += decimalEntry.value
                }
            }
        }
        
        return total
    }
    
    static func calculateAverageForDateRange(filteredDecimals: [AnyEntry], photoTimestamp: Date) -> Double {
        var total = 0.0
        var count = 0.0
        
        for decimalEntry in filteredDecimals {
            if let decimalEntry = decimalEntry.entry as? DecimalEntry {
                if Calendar.current.compare(decimalEntry.timestamp, to: photoTimestamp, toGranularity: .day) != .orderedSame {
                    total += decimalEntry.value
                    count += 1
                }
            }
        }
        
        return total / count
    }
}
