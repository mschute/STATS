import SwiftUI

//https://www.youtube.com/watch?v=1ZYE5FcUN4Y&list=PLBn01m5Vbs4DLU9Yiff2V8oyslCdB-pnj&index=3
//UIViewControllerRepresentable allows a SwiftUI view to wrap a UIKit view Controller
struct UIKitCamera: UIViewControllerRepresentable {
    //Allows the parent view to be notified when a picture is captured
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) var dismiss
    
    //Customise control: https://developer.apple.com/documentation/uikit/uiimagepickercontroller/customizing_an_image_picker_controller
    //Creates and configures UIImagePickerController
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    //Function is required by UiViewControllerRepresentable
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    //Handles delegate methods of UIImagePickerController
    //Required by the UIViewControllerRepresentable protocol
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    //Acts as a delegate for UIImagePickerController, handles user interactions when image is selected or camera is dismissed
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: UIKitCamera
        
        init(parent: UIKitCamera) {
            self.parent = parent
        }
        
        //Called when user picks an image
        //didFinishPickingMediaWithInfo delegate method called when user captures image
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.dismiss()
        }
    }
}
