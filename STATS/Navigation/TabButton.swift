import SwiftUI

struct TabButton: View {
    let title: String
    let icon: String
    let tag: DetailTab
    
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    //Custom tab bar: https://www.youtube.com/watch?v=R_KZwX-yP4o
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
