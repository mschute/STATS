import SwiftUI
import PhotosUI

//TODO: Need to Add picture functionality
struct PictureEntryForm: View {
    var pictureStat: PictureStat
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    //TODO: Create the temp object with blank values rather than individual properties?
    @State var timestamp = Date.now
    @State var note = ""
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    
    var body: some View {
        Form(content: {
            Section(header: Text("TimeStamp")) {
                DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            }
            
            //Source for code/implementation: https://www.youtube.com/watch?v=y3LofRLPUM8
            //TODO: Extract this out into a view
              PicturePicker(selectedPhoto: $selectedPhoto, selectedPhotoData: $selectedPhotoData)
//            Section(header: Text("Photo")) {
//                if let selectedPhotoData, let uiImage = UIImage(data: selectedPhotoData) {
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(maxWidth: .infinity, maxHeight: 300)
//                }
//                
//                PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
//                    Label("Add Library Image", systemImage: "photo.fill")
//                }
//                
//                if selectedPhotoData != nil {
//                    Button(role: .destructive) {
//                        withAnimation {
//                            selectedPhoto = nil
//                            selectedPhotoData = nil
//                        }
//                    } label: {
//                        Label("Remove Image", systemImage: "xmark")
//                            .foregroundStyle(.red)
//                    }
//                }
//            }
            
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
        //TODO: Will need to add additional guards if each required field is empty
        //TODO: Add alert that a field is empty if they try to submit with an empty field
        
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
