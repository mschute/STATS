import SwiftUI

struct StatDetailTabs: View {
    @EnvironmentObject var selectedDetailTab: StatTabs
    @Environment(\.colorScheme) var colorScheme
    var stat: any Stat
    
    var body: some View {
        VStack {
            HStack {
                TabButton(title: "Edit", icon: "square.and.pencil", tag: .editStat)
                TabButton(title: "Entry", icon: "plus.circle", tag: .addEntry)
                TabButton(title: "Report", icon: "chart.xyaxis.line", tag: .report)
                TabButton(title: "History", icon: "clock.arrow.circlepath", tag: .history)
            }
        }
        .frame(maxWidth: .infinity)
        .background(colorScheme == .dark ? .background : .white)
        
        Group {
            switch selectedDetailTab.selectedDetailTab {
            case .editStat:
                StatUtility.StatForm(stat: stat, isEditMode: true)
            case .addEntry:
                StatUtility.EntryForm(stat: stat)
            case .report:
                Report(stat: stat)
            case .history:
                History(stat: stat)
            }
        }
    }
}
