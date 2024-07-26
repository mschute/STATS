import SwiftUI

struct Navbar: View {
    @EnvironmentObject var selectedTab: NavbarTabs
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    var body: some View {
        TabView(selection: $selectedTab.selectedTab) {
            
            NavigationStack {
                ContentView()
            }
            .tabItem {
                Image(systemName: "list.bullet.circle.fill")
                Text("Stat List")
            }
            .tag(Tab.statList)
            
            NavigationStack {
                NewStatType()
            }
            .tabItem{
                Image(systemName: "plus.circle.fill")
                Text("New Stat")
            }
            .tag(Tab.addStat)
            
            NavigationStack {
                Settings()
            }
            .tabItem {
                Image(systemName: "gearshape.circle.fill")
                Text("Settings")
            }
            .tag(Tab.settings)
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
