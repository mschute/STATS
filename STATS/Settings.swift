import SwiftUI

struct Settings: View {
    var body: some View {
        
        List {
            Section {
                NavigationLink(destination: {
                    EditCategory()
                }, label: {
                    Label("Manage Tags", systemImage: "tag")
                })
            }
            
            Section {
                Label("Sync with Apple Health", systemImage: "heart")
                Label("Sync wih iCloud", systemImage: "cloud")
            }
            
            Section {
                Label("Export to CSV", systemImage: "rectangle.portrait.and.arrow.right")
            }
            
            Section {
                Label("Rate", systemImage: "star")
                Label("Feedback", systemImage: "message")
                Label("Share", systemImage: "square.and.arrow.up")
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    Settings()
}
