import SwiftUI
import PhotosUI

struct PicturePicker: View {
    @Environment (\.colorScheme) var colorScheme
    @Binding var selectedPhoto: PhotosPickerItem?
    @Binding var selectedPhotoData: Data?
    @Binding var cameraImage: UIImage?
    @Binding var showCamera: Bool
    @State private var cameraError: CameraPermission.CameraError?
    
    //Source for code/implementation: https://www.youtube.com/watch?v=y3LofRLPUM8
    //Source for code/implementation: https://www.youtube.com/watch?v=1ZYE5FcUN4Y&list=PLBn01m5Vbs4DLU9Yiff2V8oyslCdB-pnj&index=3
    
    var body: some View {
        Section(header: Text("Photo").foregroundColor(.picture).fontWeight(.medium)) {
            if let selectedPhotoData, let uiImage = UIImage(data: selectedPhotoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 300)
            }
            
                Button(action: {
                    if let error = CameraPermission.checkPermissions() {
                        cameraError = error
                    } else {
                        showCamera.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: "camera.fill")
                        Text("Camera")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .fontWeight(.medium)
                    }
                }
                .alert(isPresented: .constant(cameraError != nil), error: cameraError) { _ in
                    Button("OK") {
                        cameraError = nil
                    }
                } message: { error in
                    Text(error.recoverySuggestion ?? "Try again later")
                }
                .sheet(isPresented: $showCamera) {
                    UIKitCamera(selectedImage: $cameraImage)
                        .ignoresSafeArea()
                }
                
                PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                    HStack {
                        Image(systemName: "photo.fill")
                        Text("Add Library Image")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .fontWeight(.medium)
                    }
                }
            
            if selectedPhotoData != nil {
                Button(role: .destructive) {
                    withAnimation {
                        selectedPhoto = nil
                        selectedPhotoData = nil
                    }
                } label: {
                    Label("Remove Picture", systemImage: "trash")
                        .foregroundStyle(.cancel)
                }
            }
        }
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                selectedPhotoData = data
            }
        }
        .onChange(of: cameraImage) {
            if let image = cameraImage {
                selectedPhotoData = image.jpegData(compressionQuality: 0.8)
                showCamera = false
            }
        }
    }
}
