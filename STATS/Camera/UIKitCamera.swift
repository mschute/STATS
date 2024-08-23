import SwiftUI

//https://www.youtube.com/watch?v=1ZYE5FcUN4Y&list=PLBn01m5Vbs4DLU9Yiff2V8oyslCdB-pnj&index=3
//UIViewControllerRepresentable allows a SwiftUI view to wrap a UIKit view Controller
struct UIKitCamera: UIViewControllerRepresentable {
    //Allows the parent view to be notified when a picture is captured
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) var dismiss
//https://developer.apple.com/documentation/uikit/uiimagepickercontroller/1619113-cameraoverlayview
    //Allow an overlay over the camera view
    var overlayView: UIView? = CameraOverlay()
    
    //Customise control: https://developer.apple.com/documentation/uikit/uiimagepickercontroller/customizing_an_image_picker_controller
    //Creates and configures UIImagePickerController
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
        
        //Assign overlay to preview
        if imagePicker.sourceType == .camera {
            if let overlayView = overlayView {
                overlayView.frame = calculateCameraPreviewFrame(picker: imagePicker)
                imagePicker.cameraOverlayView = overlayView
            }
        }
        
        return imagePicker
    }
    
    //Calculates the cameras preview for the overlay
    func calculateCameraPreviewFrame(picker: UIImagePickerController) -> CGRect {
        //Get screen size: https://designcode.io/swiftui-handbook-detect-screen-size
        let fullScreenSize = UIScreen.main.bounds.size
        //Sizing: https://www.youtube.com/watch?v=JmH3uZUubkE
        let cameraPreviewHeight = (fullScreenSize.width / 3.0) * 4.0
        //Hardcoded as could not find coordinates of preview / size of controls
        let offsetY = 48.0
        let y = (fullScreenSize.height - cameraPreviewHeight) * 0.5 - offsetY
        
        let previewFrame = CGRect(x: 0, y: y, width: fullScreenSize.width, height: cameraPreviewHeight)
        
        return previewFrame
    }
    
    //Function is required by UiViewControllerRepresentable
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    //Handles delegate methods of UIImagePickerController
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
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.dismiss()
        }
    }
}
