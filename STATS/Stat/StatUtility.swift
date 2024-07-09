import Foundation
import SwiftData
import SwiftUI

class StatUtility {
    // as! https://stackoverflow.com/questions/28723625/how-to-convert-cast-from-a-protocol-to-a-class-in-swift
    static func Remove(stat: any Stat, modelContext: ModelContext) {
        if (stat is DecimalStat) {
            
            modelContext.delete(stat as! DecimalStat)
        }
        
        if (stat is CounterStat){
            modelContext.delete(stat as! CounterStat)
        }
    }
    
//    static func Remove(stat: any Stat, modelContext: ModelContext) {
//        if let decimalStat = stat as? DecimalStat {
//            modelContext.delete(decimalStat)
//        }
//        
//        if let counterStat = stat as? CounterStat {
//            modelContext.delete(counterStat)
//        }
//    }
    
    static func Remove(index: Int, statItems: inout[AnyStat], modelContext: ModelContext){
        Remove(stat: statItems[index].stat, modelContext: modelContext)
        
        statItems.remove(at: index)
    }
    
    static func Remove(offsets: IndexSet, statItems: inout[AnyStat], modelContext: ModelContext) {
        for index in offsets {
            Remove(stat: statItems[index].stat, modelContext: modelContext)
        }
        
        statItems.remove(atOffsets: offsets)
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
            return AnyView(CounterReport())
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
