import SwiftUI

struct StatDetailTabs: View {
    var stat: any Stat
    //TODO: Does this need to be an observed object? Environment object?
    @State var selectedDetailTab = 0
    @State private var selectedTab = 1
    
    
    var body: some View {
        HStack{
            TabButton(title: "Edit", icon: "square.and.pencil", tag: 0, selectedDetailTab: $selectedDetailTab, selectedTab: 1)
            TabButton(title: "Entry", icon: "plus.circle", tag: 1, selectedDetailTab: $selectedDetailTab, selectedTab: 1)
            TabButton(title: "Report", icon: "chart.xyaxis.line", tag: 2, selectedDetailTab: $selectedDetailTab, selectedTab: 1)
            TabButton(title: "History", icon: "clock.arrow.circlepath", tag: 3, selectedDetailTab: $selectedDetailTab, selectedTab: 1)
        }
        .background(Color.gray.opacity(0.2))
        
        Group{
            switch selectedDetailTab {
            case 0:
                StatUtility.StatForm(stat: stat, selectedTab: $selectedTab, isEditMode: true)
            case 1:
                StatUtility.EntryForm(stat: stat)
            case 2:
                StatUtility.Report(stat: stat)
            case 3:
                History(stat: stat)
            default:
                Text("Page does not exist")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
