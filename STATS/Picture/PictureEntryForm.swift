import SwiftUI
import PhotosUI

struct PictureEntryForm: View {
    var pictureStat: PictureStat
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    //TODO: Create the temp object with blank values rather than individual properties? Use @Bindable
    @State var timestamp = Date.now
    @State var note = ""
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    
    @State var cameraImage: UIImage?
    @State private var showCamera: Bool = false
    
    var body: some View {
        Form(content: {
            Section(header: Text("TimeStamp")) {
                DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            }
            
              PicturePicker(selectedPhoto: $selectedPhoto, selectedPhotoData: $selectedPhotoData, cameraImage: $cameraImage, showCamera: $showCamera)
            
            Section(header: Text("Additional Information")) {
                TextField("Note", text: $note)
            }
            
            
            Section {
                Button("Add", action: addEntry)
            }
            
        })
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                selectedPhotoData = data
            }
        }
    }
    
    func addEntry() {
        let entry = PictureEntry(pictureStat: pictureStat, entryId: UUID(), timestamp: timestamp, note: note, image: selectedPhotoData)
        
        pictureStat.statEntry.append(entry)
        
        note = ""
        timestamp = Date.now
        dismiss()
        selectedDetailTab.selectedDetailTab = .history
    }
}

//#Preview {
//    PictureEntryForm()
//}
