import SwiftUI

//TODO: Where should this file be moved?
//TODO: Need source
struct TabButton: View {
    let title: String
    let icon: String
    let tag: DetailTab
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    var body: some View {
        Button(action: {
            selectedDetailTab.selectedDetailTab = tag
        }) {
            VStack {
                Image(systemName: icon)
                    .foregroundColor(selectedDetailTab.selectedDetailTab == tag ? .blue : .black)
                    .padding(.vertical, 1)
                Text(title)
                    .foregroundColor(selectedDetailTab.selectedDetailTab == tag ? .blue : .black)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
    }
}

//#Preview {
//    TabButton(title: "Edit", icon: "square.and.pencil", tag: .editStat, selectedDetailTab: )
//}
