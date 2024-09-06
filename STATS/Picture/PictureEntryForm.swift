import SwiftUI
import PhotosUI

struct PictureEntryForm: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    var pictureStat: PictureStat
    
    @State private var timestamp: Date = Date()
    @State private var note: String = ""
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var cameraImage: UIImage?
    @State private var selectedPhotoData: Data?
    @State private var showCamera: Bool = false
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("TimeStamp").foregroundColor(.teal).fontWeight(.medium)) {
                DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
                    .fontWeight(.medium)
                    .padding(.vertical, 5)
            }
            
            PicturePicker(selectedPhoto: $selectedPhoto, selectedPhotoData: $selectedPhotoData, cameraImage: $cameraImage, showCamera: $showCamera)
            
            Section(header: Text("Additional Information").foregroundColor(.teal).fontWeight(.medium)) {
                TextField("Note", text: $note)
            }
            
            Section {
                Button("Add") {}
                    .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .teal, statHighlightColor: .pictureHighlight))
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                if selectedPhotoData == nil {
                                    showAlert = true
                                } else {
                                    PictureEntry.addEntry(pictureStat: pictureStat, timestamp: timestamp, note: note, image: selectedPhotoData, modelContext: modelContext)
                                    selectedDetailTab.selectedDetailTab = .history
                                }
                                Haptics.shared.play(.light)
                            }
                    )
            }
        }
        .dismissKeyboard()
        //TODO: Refactor this into a separate function? Repeated in entry
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                selectedPhotoData = data
            }
        }
        //Alerts: https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-an-alert
        .alert("Must add picture", isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                Haptics.shared.play(.light)
            }
        }
    }
}
