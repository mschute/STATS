import SwiftUI
import PhotosUI

struct PictureEntryForm: View {
    var pictureStat: PictureStat
    
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    @State var entry: PictureEntry = PictureEntry()
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    
    @State var cameraImage: UIImage?
    @State private var showCamera: Bool = false
    
    var body: some View {
        Form(content: {
            Section(header: Text("TimeStamp")) {
                DatePicker("Timestamp", selection: $entry.timestamp, displayedComponents: [.date, .hourAndMinute])
            }
            
              PicturePicker(selectedPhoto: $selectedPhoto, selectedPhotoData: $selectedPhotoData, cameraImage: $cameraImage, showCamera: $showCamera)
            
            Section(header: Text("Additional Information")) {
                TextField("Note", text: $entry.note)
            }
            
            
            Section {
                Button("Add", action: addEntry)
            }
            
        })
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                entry.image = data
            }
        }
    }
    
    func addEntry() {
        entry.stat = pictureStat
        
        pictureStat.statEntry.append(entry)
        
        selectedDetailTab.selectedDetailTab = .history
    }
}

//#Preview {
//    PictureEntryForm()
//}
