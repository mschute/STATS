import SwiftUI

struct StatDetailTabs: View {
    var stat: any Stat
    //TODO: Does this need to be an observed object? Environment object?
    //TODO: Change the number for selectedDetailTab to an enum
    @State var selectedDetailTab: DetailTab = .EditStat
    @State private var selectedTab: Tab = .StatList
    
    
    var body: some View {
        HStack{
            TabButton(title: "Edit", icon: "square.and.pencil", tag: .EditStat, selectedDetailTab: $selectedDetailTab, selectedTab: .StatList)
            TabButton(title: "Entry", icon: "plus.circle", tag: .AddEntry, selectedDetailTab: $selectedDetailTab, selectedTab: .StatList)
            TabButton(title: "Report", icon: "chart.xyaxis.line", tag: .Report, selectedDetailTab: $selectedDetailTab, selectedTab: .StatList)
            TabButton(title: "History", icon: "clock.arrow.circlepath", tag: .History, selectedDetailTab: $selectedDetailTab, selectedTab: .StatList)
        }
        .background(Color.gray.opacity(0.2))
        
        Group{
            switch selectedDetailTab {
                case .EditStat:
                    StatUtility.StatForm(stat: stat, selectedTab: $selectedTab, isEditMode: true)
                case .AddEntry:
                    StatUtility.EntryForm(stat: stat)
                case .Report:
                    StatUtility.Report(stat: stat)
                case .History:
                    History(stat: stat)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
