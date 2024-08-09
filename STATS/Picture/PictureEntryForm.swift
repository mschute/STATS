import SwiftUI
import PhotosUI

struct PictureEntryForm: View {
    @EnvironmentObject var selectedDetailTab: StatTabs
    var pictureStat: PictureStat
    @State private var entry: PictureEntry = PictureEntry()
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    
    @State private var cameraImage: UIImage?
    @State private var showCamera: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("TimeStamp").foregroundColor(.picture).fontWeight(.medium)) {
                DatePicker("Timestamp", selection: $entry.timestamp, displayedComponents: [.date, .hourAndMinute])
                    .fontWeight(.medium)
                    .padding(.vertical, 5)
            }
            
            PicturePicker(selectedPhoto: $selectedPhoto, selectedPhotoData: $selectedPhotoData, cameraImage: $cameraImage, showCamera: $showCamera)
            
            Section(header: Text("Additional Information").foregroundColor(.picture).fontWeight(.medium)) {
                TextField("Note", text: $entry.note)
            }
            
            Section {
                Button("Add") {}
                    .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .picture, statHighlightColor: .pictureHighlight))
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                addEntry()
                            }
                    )
            }
        }
        .dismissKeyboardOnTap()
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                entry.image = data
            }
        }
        .task(id: selectedPhotoData) {
            if let data = selectedPhotoData {
                entry.image = data
            }
        }
    }
    
    private func addEntry() {
        entry.stat = pictureStat
        pictureStat.statEntry.append(entry)
        selectedDetailTab.selectedDetailTab = .history
    }
}
