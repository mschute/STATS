import SwiftUI
import PhotosUI

struct PictureEntryForm: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var selectedDetailTab: StatTabs
    @Environment(\.colorScheme) var colorScheme
    var pictureStat: PictureStat
    
    @State private var timestamp: Date = Date()
    @State private var note: String = ""
    @State private var image: Data?
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    
    @State private var cameraImage: UIImage?
    @State private var showCamera: Bool = false
    
    @State private var showAlert: Bool = false
    
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
                Button("Add") {}
                    .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .picture, statHighlightColor: .pictureHighlight))
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                if image == nil {
                                    showAlert = true
                                } else {
                                    PictureEntry.addEntry(pictureStat: pictureStat, timestamp: timestamp, note: note, image: image, modelContext: modelContext)
                                    selectedDetailTab.selectedDetailTab = .history
                                }
                                Haptics.shared.play(.light)
                            }
                    )
            }
        }
        .dismissKeyboardOnTap()
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                image = data
            }
        }
        .task(id: selectedPhotoData) {
            if let data = selectedPhotoData {
                image = data
            }
        }
        //Alerts: https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-an-alert
        .alert("Must add picture", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
        // Change alert tint color: https://www.hackingwithswift.com/forums/swiftui/alert-button-color-conforming-to-accentcolor/7193#:~:text=There%20is%20no%20way%20to,the%20system%20do%20its%20thing.
        .onAppear() {
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.dynamicMainColor(colorScheme: colorScheme)
        }
    }
}
