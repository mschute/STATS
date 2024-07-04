import Foundation
import SwiftData
import SwiftUI

//TODO: Need to add picture stat to these functions
class StatUtility {
    static func Remove(stat: any Stat, modelContext: ModelContext) {
        if (stat is DecimalStat) {
            // as! https://stackoverflow.com/questions/28723625/how-to-convert-cast-from-a-protocol-to-a-class-in-swift
            //TODO: Remove force unwrapping?
            modelContext.delete(stat as! DecimalStat)
        }
        
        if (stat is CounterStat){
            modelContext.delete(stat as! CounterStat)
        }
    }
    
//    static func Remove(index: Int, statItems: inout[AnyStat], modelContext: ModelContext){
//        Remove(stat: statItems[index].stat, modelContext: modelContext)
//        
//        statItems.remove(at: index)
//    }
    
    static func Remove(offsets: IndexSet, statItems: inout[AnyStat], modelContext: ModelContext) {
        for index in offsets {
            Remove(stat: statItems[index].stat, modelContext: modelContext)
        }
        
        statItems.remove(atOffsets: offsets)
    }
    
//TODO: Need to decide what to do with this code
//    static func fetchStats() {
//        stats = []
//        
//        let fetchedCounters = FetchDescriptor<CounterStat>()
//        let fetchedDecimals = FetchDescriptor<DecimalStat>()
//        
//        do{
//            let counters = try modelContext.fetch(fetchedCounters)
//            let decimals = try modelContext.fetch(fetchedDecimals)
//            
//            stats += counters.map { AnyStat(stat: $0) }
//            stats += decimals.map { AnyStat(stat: $0) }
//            
//        } catch {
//            print("Add a stat!")
//        }
//    }
    
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
    static func StatForm(stat: any Stat, selectedTab: Binding<Int>, isEditMode: Bool) -> some View {
        if (stat is CounterStat) {
            return AnyView(CounterForm(counterStat: stat as? CounterStat, isEditMode: isEditMode, selectedTab: selectedTab))
        }
        
        if (stat is DecimalStat) {
            return AnyView(DecimalForm(decimalStat: stat as? DecimalStat, isEditMode: isEditMode, selectedTab: selectedTab))
        }
        
        return AnyView(Text("No stat available"))
    }
    
    //TODO: Potentially remove the force unwrap
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
