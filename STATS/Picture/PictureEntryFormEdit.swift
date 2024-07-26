import SwiftUI
import PhotosUI

struct PictureEntryFormEdit: View {
    @Environment(\.presentationMode) var presentationMode
    
    //Bindable allows for changes to automatically be saved
    @Bindable var pictureEntry: PictureEntry
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var cameraImage: UIImage?
    
    @State private var showCamera: Bool = false
    
    var body: some View {
        Form(content: {
            DatePicker("Timestamp", selection: $pictureEntry.timestamp, displayedComponents: [.date, .hourAndMinute])
            TextField("Note", text: $pictureEntry.note)
            
            PicturePicker(selectedPhoto: $selectedPhoto, selectedPhotoData: $pictureEntry.image, cameraImage: $cameraImage, showCamera: $showCamera)
            
            Button("Update", action: saveEntry)
        })
    }

    func saveEntry() {
        presentationMode.wrappedValue.dismiss()
    }
}

//#Preview {
//    PictureEntryFormEdit()
//}
