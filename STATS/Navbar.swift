import SwiftUI

struct Navbar: View {
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            
            NavigationStack {
                ContentView()
            }
            .tabItem {
                Image(systemName: "list.bullet.circle.fill")
                Text("Stat List")
            }
            .tag(1)
            
            NavigationStack {
                NewStatType(selectedTab: $selectedTab)
            }
            .tabItem{
                Image(systemName: "plus.circle.fill")
                Text("New Stat")
            }
            .tag(2)
            
            
            Settings()
                .tabItem {
                    Image(systemName: "gearshape.circle.fill")
                    Text("Settings")
                }
                .tag(3)
            
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
