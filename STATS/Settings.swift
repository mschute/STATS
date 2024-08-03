import SwiftUI

struct Settings: View {
    @Environment(\.backgroundColor) var backgroundColor
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.custom("Menlo", size: 34))
                .fontWeight(.black)
                .padding(.top, 60)
            List {
                Section {
                    NavigationLink(destination: {
                        EditCategory()
                    }, label: {
                        Label {
                            Text("Manage Tags")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        } icon: {
                            Image(systemName: "tag.fill")
                                .foregroundColor(.universal)
                        }
                    })
                }
                .foregroundColor(.universal)
                .listRowBackground(Color.background)
                
                Section {
                    Label {
                        Text("Sync with Apple Health")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.universal)
                    }
                    
                    Label {
                        Text("Sync wih iCloud")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "cloud.fill")
                            .foregroundColor(.universal)
                    }
                }
                .listRowBackground(Color.background)
                
                Section {
                    Label {
                        Text("Export to CSV")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                            .foregroundColor(.universal)
                    }
                }
                .listRowBackground(Color.background)
                
                Section {
                    Label {
                        Text("Rate")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "star.fill")
                            .foregroundColor(.universal)
                    }
                    
                    Label {
                        Text("Feedback")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "message.fill")
                            .foregroundColor(.universal)
                    }

                    Label {
                        Text("Share")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "square.and.arrow.up.fill")
                            .foregroundColor(.universal)
                    }
                }
                .listRowBackground(Color.background)
            }
            .background(Color.black)
            .scrollContentBackground(.hidden)
            
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor.ignoresSafeArea())
        
        //Remove list background: https://sarunw.com/posts/swiftui-list-background-color/
    }
}
