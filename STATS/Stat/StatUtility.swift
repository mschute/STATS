import Foundation
import SwiftData
import SwiftUI

class StatUtility {
    // as! https://stackoverflow.com/questions/28723625/how-to-convert-cast-from-a-protocol-to-a-class-in-swift
    
    static func Remove(stat: any Stat, modelContext: ModelContext) {
        if (stat is DecimalStat) {
            do {
                modelContext.delete(stat as! DecimalStat)
                
                try modelContext.save()
            } catch {
                    print("Error deleting stat")
                }
            }
        
        if (stat is CounterStat){
            do {
                modelContext.delete(stat as! CounterStat)
                
                try modelContext.save()
            } catch {
                    print("Error deleting stat")
                }
            }
        }
    
//    static func Remove(index: Int, statItems: inout[AnyStat], modelContext: ModelContext){
//        Remove(stat: statItems[index].stat, modelContext: modelContext)
//        
//        //statItems.remove(at: index)
//    }
    
    //Index set and offets for deleting https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-delete-rows-from-a-list
    static func Remove(offsets: IndexSet, statItems: [AnyStat], modelContext: ModelContext) {
        for index in offsets {
            Remove(stat: statItems[index].stat, modelContext: modelContext)
        }
    }
    
    static func Card(stat: any Stat) -> some View {
        if (stat is DecimalStat) {
            return AnyView(DecimalCard(stat: stat as! DecimalStat))
        }
        
        if (stat is CounterStat) {
            return AnyView(CounterCard(stat: stat as! CounterStat))
        }
        
        return AnyView(Text("No stat available"))
    }
    
    //TODO: https://forums.developer.apple.com/forums/thread/120034
    static func StatForm(stat: any Stat, isEditMode: Bool) -> some View {
        if (stat is CounterStat) {
            return AnyView(CounterForm(counterStat: stat as? CounterStat, isEditMode: isEditMode))
        }
        
        if (stat is DecimalStat) {
            return AnyView(DecimalForm(decimalStat: stat as? DecimalStat, isEditMode: isEditMode))
        }
        
        return AnyView(Text("No stat available"))
    }
    
    static func EntryForm(stat: any Stat) -> some View {
        if (stat is CounterStat) {
            return AnyView(CounterEntryForm(counterStat: stat as! CounterStat))
        }
        
        if (stat is DecimalStat) {
            return AnyView(DecimalEntryForm(decimalStat: stat as! DecimalStat))
        }
        
        return AnyView(Text("No stat available"))
    }
    
    static func Report(stat: any Stat) -> some View {
        if (stat is CounterStat) {
            return AnyView(CounterReport(counterStat: stat as! CounterStat))
        }
        
        if (stat is DecimalStat) {
            return AnyView(DecimalReport())
        }
        
        return AnyView(Text("No stat available"))
    }
    
    static func EntryList(stat: any Stat, startDate: Binding<Date>, endDate: Binding<Date>) -> some View {
        let id = stat.persistentModelID
        
        if (stat is CounterStat) {
            return AnyView(CounterEntryList(id: id, startDate: startDate, endDate: endDate))
        }
        
        if (stat is DecimalStat) {
            return AnyView(DecimalEntryList(id: id, startDate: startDate, endDate: endDate))
        }
        
        return AnyView(Text("No stat available"))
        
    }
}
