import SwiftUI

struct TabButton: View {
    let title: String
    let icon: String
    let tag: DetailTab
    
    @EnvironmentObject var selectedDetailTab: StatTabs
    @Environment(\.colorScheme) var colorScheme
    
    private var textColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var body: some View {
        Button(action: {
            selectedDetailTab.selectedDetailTab = tag
        }) {
            VStack {
                Image(systemName: icon)
                    .padding(.vertical, 1)
                Text(title)
            }
            .fontWeight(selectedDetailTab.selectedDetailTab == tag ? .medium : .regular)
            .foregroundColor(selectedDetailTab.selectedDetailTab == tag ? .main : textColor)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
    }
}
