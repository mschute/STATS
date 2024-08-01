import SwiftUI
import PhotosUI

struct PictureEntryFormEdit: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    var pictureEntry: PictureEntry
    
    @State private var timestamp: Date
    @State private var note: String
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    @State var cameraImage: UIImage?
    @State private var showCamera: Bool = false
    
    init(pictureEntry: PictureEntry) {
        self.pictureEntry = pictureEntry
        _timestamp = State(initialValue: pictureEntry.timestamp)
        _note = State(initialValue: pictureEntry.note)
        _selectedPhotoData = State(initialValue: pictureEntry.image)
    }
    
    var body: some View {
        Form(content: {
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            TextField("Note", text: $note)
            
            PicturePicker(selectedPhoto: $selectedPhoto, selectedPhotoData: $selectedPhotoData, cameraImage: $cameraImage, showCamera: $showCamera)
            
            Button("Update", action: saveEntry)
        })
    }

    func saveEntry() {
        pictureEntry.timestamp = timestamp
        pictureEntry.note = note
        pictureEntry.image = selectedPhotoData
        
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving entry")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

//#Preview {
//    PictureEntryFormEdit()
//}
