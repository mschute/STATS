import SwiftUI

struct Navbar: View {
    @EnvironmentObject var selectedTab: NavbarTabs
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        TabView(selection: $selectedTab.selectedTab) {
            Group {
                NavigationStack {
                    ContentView()
                }
                .tabItem {
                        Image(systemName: "list.bullet.circle.fill")
                        Text("Stat List")
                    
                }
                .tag(Tab.statList)
                
                NavigationStack {
                    ChooseStatType()
                }
                .tabItem {
                        Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                        Text("New Stat")
                }
                .tag(Tab.addStat)
                
                NavigationStack {
                    Settings()
                }
                .tabItem {
                        Image(systemName: "gearshape.circle.fill")
                        .imageScale(.large)
                        Text("Settings")
                }
                .tag(Tab.settings)
            }
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
