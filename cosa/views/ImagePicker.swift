import PhotosUI
import SwiftUI

///Used to manage UIViewController object in SwiftUI
struct ImagePicker: UIViewControllerRepresentable {
    ///Binding from the caller view – returned UIImage will be shown in the UI
    @Binding var image: UIImage?

    ///Creates the view controller of type PHPickerViewController
    func makeUIViewController(context: Context) -> PHPickerViewController {

        ///Configures the Picker, for example what to display
        var config = PHPickerConfiguration()
        config.filter = .images
        ///Creates the picker with the given configuration
        let picker = PHPickerViewController(configuration: config)

        ///Delegates the picker for the context's coordinator
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }

    ///Creates coordinator with parent of ImagePicker
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    ///Creating the coordinator of type PHPickerViewControllerDelegate
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            ///Checks if the selected image is valid
            guard let provider = results.first?.itemProvider else {return}

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    ///Sets the value of the binding to the fetched image
                    
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}
