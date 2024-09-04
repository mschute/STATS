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
            .padding(.vertical, 10)  // Add vertical padding to the tab bar
            .padding(.horizontal, 10)
            .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color(UIColor.systemBackground)) // Sleek background color
            .clipShape(RoundedRectangle(cornerRadius: 10))  // Rounded tab bar for sleek appearance
        
        }
        .frame(maxWidth: .infinity)
        .background(colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.systemGray6))
        
        Group {
            switch selectedDetailTab.selectedDetailTab {
            case .editStat:
                AnyStat.StatEditForm(stat: stat)
            case .addEntry:
                AnyStat.EntryForm(stat: stat)
            case .report:
                Report(stat: stat)
            case .history:
                History(stat: stat)
            }
        }
    }
}
