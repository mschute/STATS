import SwiftUI

struct Settings: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("isHaptics") private var isHaptics: Bool = true
    @AppStorage("isReminder") private var isReminder: Bool = false
    
    //Navigation Transitions: https://stackoverflow.com/questions/75635848/new-navigationstack-in-swiftui-transition-how-to-change-from-the-default-slide
    
    var body: some View {
        VStack {
            TopBar(title: "SETTINGS", topPadding: 40, bottomPadding: 20)
            List {
                Section {
                    NavigationLink(destination: {
                        About()
                            .tint(.main)
                    }, label: {
                        Label {
                            Text("About STATS")
                                .fontWeight(.semibold)
                        } icon: {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.main)
                        }
                    })
                }
                .navigationTitle("")
                
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
                        .onChange(of: isDarkMode, initial: false) {
                            UIApplication.shared.applyColorMode(isDarkMode: isDarkMode)
                        }
                    Toggle("Haptics", isOn: $isHaptics)
                        .onChange(of: isHaptics, initial: true) {}
                    Toggle("Reminders", isOn: $isReminder)
                        .onChange(of: isReminder, initial: true) {}
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
    }
}
