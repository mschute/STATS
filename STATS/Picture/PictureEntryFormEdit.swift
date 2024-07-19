import SwiftUI

//TODO: Need to add picture uploading / taking functionality
struct PictureEntryFormEdit: View {
    @Environment(\.presentationMode) var presentationMode
    var pictureEntry: PictureEntry
    
    @State var timestamp: Date
    @State var note: String
    
    //State initialValue https://stackoverflow.com/questions/56691630/swiftui-state-var-initialization-issue
    init(pictureEntry: PictureEntry) {
        self.pictureEntry = pictureEntry
        _timestamp = State(initialValue: pictureEntry.timestamp)
        _note = State(initialValue: pictureEntry.note)
    }
    
    var body: some View {
        Form(content: {
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            
            Button("Update", action: saveEntry)
        })
    }
    
    //TODO: Navigation is wrong, it is going to Home first and then to history, it should go straight to history
    func saveEntry() {
        pictureEntry.timestamp = timestamp
        presentationMode.wrappedValue.dismiss()
    }
}

//#Preview {
//    PictureEntryFormEdit()
//}
