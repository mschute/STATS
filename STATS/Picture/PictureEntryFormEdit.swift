import SwiftUI
import PhotosUI

struct PictureEntryFormEdit: View {
    @Environment(\.modelContext) var modelContext
    //TODO: Should this be dismiss instead?
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
        Form {
            Section(header: Text("TimeStamp").foregroundColor(.picture).fontWeight(.medium)) {
                DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
                    .fontWeight(.medium)
                    .padding(.vertical, 5)
            }
            
            PicturePicker(selectedPhoto: $selectedPhoto, selectedPhotoData: $selectedPhotoData, cameraImage: $cameraImage, showCamera: $showCamera)

            Section(header: Text("Additional Information").foregroundColor(.picture).fontWeight(.medium)) {
                TextField("Note", text: $note)
            }
            
            Section {
                Button("Update", action: saveEntry)
                    .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .picture))
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
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
