import SwiftUI
import PhotosUI

struct PicturePicker: View {
    @Binding var selectedPhoto: PhotosPickerItem?
    @Binding var selectedPhotoData: Data?
    
    var body: some View {
        Section(header: Text("Photo")) {
            if let selectedPhotoData, let uiImage = UIImage(data: selectedPhotoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 300)
            }
            
            PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                Label("Add Library Image", systemImage: "photo.fill")
            }
            
            if selectedPhotoData != nil {
                Button(role: .destructive) {
                    withAnimation {
                        selectedPhoto = nil
                        selectedPhotoData = nil
                    }
                } label: {
                    Label("Remove Image", systemImage: "xmark")
                        .foregroundStyle(.red)
                }
            }
        }
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                selectedPhotoData = data
            }
        }
    }
}

//#Preview {
//    PicturePicker()
//}
