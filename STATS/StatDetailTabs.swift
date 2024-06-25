//
//  StatDetailTabs.swift
//  STATS
//
//  Created by Staff on 24/06/2024.
//

import SwiftUI
//
//struct Tab {
//    var icon: Image?
//    var title: String
//}

struct StatDetailTabs: View {
    //var fixed = true
    //var tabs: [Tab]
    //var geoWidth: CGFloat
    var stat: Stat
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
                //TODO: Need to create switch statement for Form
                CounterForm(counterStat: stat as? CounterStat, isEditMode: true, selectedTab: $selectedTab)
            case 1:
                StatUtility.EntryForm(stat: stat)
            case 2:
                StatUtility.Report(stat: stat)
            case 3:
                History()
            default:
                Text("Page does not exist")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    StatDetailTabs(stat: CounterStat(name: "Weight", created: Date.now))
}
