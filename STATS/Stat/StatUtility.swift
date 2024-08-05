import Foundation
import SwiftData
import SwiftUI

class StatUtility {
    static func Remove(stat: any Stat, modelContext: ModelContext) {
        if let stat = stat as? CounterStat {
            modelContext.delete(stat)
        } else if let stat = stat as? DecimalStat {
            modelContext.delete(stat)
        } else if let stat = stat as? PictureStat {
            modelContext.delete(stat as PictureStat)
        }
        //try? https://codewithchris.com/swift-try-catch/#:~:text=You%20can%20still%20call%20a,do%2Dtry%2Dcatch%20syntax.&text=If%20you%20use%20the%20try,assigned%20to%20the%20audioPlayer%20variable.
        try? modelContext.save()
    }
    
    //Index set and offets for deleting https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-delete-rows-from-a-list
    static func Remove(offsets: IndexSet, statItems: [AnyStat], modelContext: ModelContext) {
        for index in offsets {
            Remove(stat: statItems[index].stat, modelContext: modelContext)
        }
    }
    
    static func Card(stat: any Stat) -> some View {
        //https://sarunw.com/posts/optional-binding-switch-case/#:~:text=When%20you%20want%20to%20unwrap,let%20or%20guard%20let%20syntax.&text=print(%22Hello%2C%20%5C(name)!%22)&text=print(%22Hello%2C%20World!%22)
        switch stat {
        case let stat as CounterStat:
            return AnyView(CounterCard(stat: stat))
        case let stat as DecimalStat:
            return AnyView(DecimalCard(stat: stat))
        case let stat as PictureStat:
            return AnyView(PictureCard(stat: stat))
        default:
            return AnyView(Text("No stat available"))
        }
    }

    static func StatForm(stat: any Stat, isEditMode: Bool) -> some View {
        switch stat {
        case let stat as CounterStat:
            return AnyView(CounterForm(counterStat: stat, isEditMode: isEditMode))
        case let stat as DecimalStat:
            return AnyView(DecimalForm(decimalStat: stat, isEditMode: isEditMode))
        case let stat as PictureStat:
            return AnyView(PictureForm(pictureStat: stat, isEditMode: isEditMode))
        default:
            return AnyView(Text("No stat available"))
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
            return AnyView(Text("No stat available"))
        }
    }
    
    static func EntryList(stat: any Stat, startDate: Binding<Date>, endDate: Binding<Date>) -> some View {
        let id = stat.persistentModelID
        
        if(stat.statEntry.isEmpty) {
            return AnyView(Text("No current entries"))
        }
        
        switch stat {
        case is CounterStat:
            return AnyView(CounterEntryList(id: id, startDate: startDate, endDate: endDate))
        case is DecimalStat:
            return AnyView(DecimalEntryList(id: id, startDate: startDate, endDate: endDate))
        case is PictureStat:
            return AnyView(PictureEntryList(id: id, startDate: startDate, endDate: endDate))
        default:
            return AnyView(Text("No stat available"))
        }
    }
    
    static func ReportContent(stat: any Stat, startDate: Binding<Date>, endDate: Binding<Date>) -> some View {
        let id = stat.persistentModelID
        
        if(stat.statEntry.isEmpty) {
            return AnyView(Text("No available data for report"))
        }
        
        switch stat {
        case is CounterStat:
            return AnyView(CounterReportContent(id: id, startDate: startDate, endDate: endDate))
        case is DecimalStat:
            return AnyView(DecimalReportContent(id: id, startDate: startDate, endDate: endDate))
        case is PictureStat:
            return AnyView(PictureReportContent(id: id, startDate: startDate, endDate: endDate))
        default:
            return AnyView(Text("No stat available"))
        }
    }
}
