import UIKit
import AVFoundation

//Implementation source: https://www.youtube.com/watch?v=1ZYE5FcUN4Y&list=PLBn01m5Vbs4DLU9Yiff2V8oyslCdB-pnj&index=3
enum CameraPermission {
    enum CameraError: Error, LocalizedError {
        case unauthorized
        case unavailable
        
        var errorDescription: String? {
            switch self {
            case .unauthorized:
                //NSLocalizedString allows the error message to be shown in multiple languages if you have those settings checked
                return NSLocalizedString("You have no authorized the camera use", comment: "")
            case .unavailable:
                return NSLocalizedString("A camera is not available for this device", comment: "")
            }
        }
        
        var recoverySuggestion: String? {
            switch self {
            case .unauthorized:
                return "Open Settings > Privacy and Security > Camera and grant permissions for this app"
            case .unavailable:
                return "Please use the photo album instead"
            }
        }
    }
    
    static func checkPermissions() -> CameraError? {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authStatus {
            case .notDetermined:
                return nil
            case .restricted:
                return nil
            case .denied:
                return .unauthorized
            case .authorized:
                return nil
            @unknown default:
                return nil
            }
        } else {
            return .unavailable
        }
    }
}
