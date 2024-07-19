import SwiftUI

struct StatDetailTabs: View {
    var stat: any Stat
    
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    var body: some View {
        HStack{
            TabButton(title: "Edit", icon: "square.and.pencil", tag: .editStat)
            TabButton(title: "Entry", icon: "plus.circle", tag: .addEntry)
            TabButton(title: "Report", icon: "chart.xyaxis.line", tag: .report)
            TabButton(title: "History", icon: "clock.arrow.circlepath", tag: .history)
        }
        .background(Color.gray.opacity(0.2))
        
        Group{
            switch selectedDetailTab.selectedDetailTab {
                case .editStat:
                    StatUtility.StatForm(stat: stat, isEditMode: true)
                case .addEntry:
                    StatUtility.EntryForm(stat: stat)
                case .report:
                    StatUtility.Report(stat: stat)
                case .history:
                    History(stat: stat)
            }
        }
    }
}
