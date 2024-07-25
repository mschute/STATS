import SwiftUI
import PhotosUI

//TODO: Need to add picture uploading / taking functionality
struct PictureEntryFormEdit: View {
    @Environment(\.presentationMode) var presentationMode
    
    //Bindable allows for changes to automatically be saved
    @Bindable var pictureEntry: PictureEntry
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    
    @State var timestamp: Date
    @State var note: String
    
    //State initialValue https://stackoverflow.com/questions/56691630/swiftui-state-var-initialization-issue
    init(pictureEntry: PictureEntry) {
        self.pictureEntry = pictureEntry
        _timestamp = State(initialValue: pictureEntry.timestamp)
        _note = State(initialValue: pictureEntry.note)
        _selectedPhotoData = State(initialValue: pictureEntry.image)
    }
    
    var body: some View {
        Form(content: {
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            
            //Source for code/implementation: https://www.youtube.com/watch?v=y3LofRLPUM8
            PicturePicker(selectedPhoto: $selectedPhoto, selectedPhotoData: $selectedPhotoData)
            
            Button("Update", action: saveEntry)
        })
    }
    
    //TODO: Navigation is wrong, it is going to Home first and then to history, it should go straight to history
    func saveEntry() {
        pictureEntry.timestamp = timestamp
        pictureEntry.image = selectedPhotoData
        presentationMode.wrappedValue.dismiss()
    }
}

//#Preview {
//    PictureEntryFormEdit()
//}
