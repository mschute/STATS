import SwiftUI

//TODO: Where should this file be moved?
struct TabButton: View {
    let title: String
    let icon: String
    let tag: DetailTab
    @Binding var selectedDetailTab: DetailTab
    var selectedTab: Tab = .StatList
    
    var body: some View {
        Button(action: {
            selectedDetailTab = tag
        }) {
            VStack {
                Image(systemName: icon)
                    .foregroundColor(selectedDetailTab == tag ? .blue : .black)
                    .padding(.vertical, 1)
                Text(title)
                    .foregroundColor(selectedDetailTab == tag ? .blue : .black)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
    }
}

#Preview {
    TabButton(title: "Edit", icon: "square.and.pencil", tag: .EditStat, selectedDetailTab: .constant(.EditStat), selectedTab: .StatList)
}
