import SwiftUI

struct Settings: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true
    
    //Navigation Transitions: https://stackoverflow.com/questions/75635848/new-navigationstack-in-swiftui-transition-how-to-change-from-the-default-slide
    
    var body: some View {
        VStack {
            TopBar(title: "SETTINGS", topPadding: 40, bottomPadding: 20)
            List {
                Section {
                    NavigationLink(destination: {
                        EditCategory()
                    }, label: {
                        Label {
                            Text("Manage Tags")
                                .fontWeight(.semibold)
                        } icon: {
                            Image(systemName: "tag.fill")
                                .foregroundColor(.main)
                        }
                    })
                }
                .navigationTitle("")
                
                Section {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .onChange(of: isDarkMode, initial: true) {
                            UIApplication.shared.applyColorMode(isDarkMode: isDarkMode)
                        }
                }
                .fontWeight(.semibold)
                
                Section {
                    Label {
                        Text("Sync with Apple Health")
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.main)
                    }
                    
                    Label {
                        Text("Sync wih iCloud")
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "cloud.fill")
                            .foregroundColor(.main)
                    }
                }
                
                Section {
                    Label {
                        Text("Export to CSV")
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                            .foregroundColor(.main)
                    }
                }
                
                Section {
                    Label {
                        Text("Rate")
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "star.fill")
                            .foregroundColor(.main)
                    }
                    
                    Label {
                        Text("Feedback")
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "message.fill")
                            .foregroundColor(.main)
                    }

                    Label {
                        Text("Share")
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "square.and.arrow.up.fill")
                            .foregroundColor(.main)
                    }
                }
            }
        }
        //Remove list background: https://sarunw.com/posts/swiftui-list-background-color/
    }
}
