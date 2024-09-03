import SwiftUI
import PhotosUI

struct PictureEntryFormEdit: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var pictureEntry: PictureEntry
    
    @State private var timestamp: Date
    @State private var note: String
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    @State private var cameraImage: UIImage?
    @State private var showCamera: Bool = false
    
    @State private var showAlert: Bool = false
    
    init(pictureEntry: PictureEntry) {
        self.pictureEntry = pictureEntry
        _timestamp = State(initialValue: pictureEntry.timestamp)
        _note = State(initialValue: pictureEntry.note)
        _selectedPhotoData = State(initialValue: pictureEntry.image)
    }
    
    var body: some View {
        TopBar(title: "EDIT ENTRY", topPadding: 0, bottomPadding: 20)
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
                Button("Update") {}
                    .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .picture, statHighlightColor: .pictureHighlight))
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                if selectedPhotoData == nil {
                                    showAlert = true
                                } else {
                                    PictureEntry.saveEntry(pictureEntry: pictureEntry, timestamp: timestamp, note: note, selectedPhotoData: selectedPhotoData, modelContext: modelContext)
                                }
                                Haptics.shared.play(.light)
                                //Need delay to avoid loading bug
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                    dismiss()
                                }
                            }
                    )
            }
        }
        .dismissKeyboard()        
        .alert("Must add picture", isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                Haptics.shared.play(.light)
            }
        }
    }
}
