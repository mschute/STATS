import SwiftUI

struct Navbar: View {
    @State private var selectedTab: Tab = .StatList
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            NavigationStack {
                ContentView()
            }
            .tabItem {
                Image(systemName: "list.bullet.circle.fill")
                Text("Stat List")
            }
            .tag(Tab.StatList)
            
            NavigationStack {
                NewStatType(selectedTab: $selectedTab)
            }
            .tabItem{
                Image(systemName: "plus.circle.fill")
                Text("New Stat")
            }
            .tag(Tab.AddStat)
            
            Settings()
                .tabItem {
                    Image(systemName: "gearshape.circle.fill")
                    Text("Settings")
                }
                .tag(Tab.Settings)
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
