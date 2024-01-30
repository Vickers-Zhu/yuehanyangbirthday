import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var imageName: String
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // No need to update the picker controller
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else {
                return
            }

            provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self, let newImage = image as? UIImage else { return }

                    // Load the current image
                    let currentImageName = self.parent.imageName
                    if let currentImage = loadImageFromDisk(named: currentImageName),
                       currentImage.pngData() == newImage.pngData() {
                        // Images are the same, no action needed
                        return
                    }
                    // If a different image is selected or no image was previously selected
                    if !currentImageName.isEmpty {
                        deleteImageFromDisk(named: currentImageName)
                        print("Deleted old image from disk.")
                    }                   
                    let imageName = saveImageToDisk(newImage)
                    self.parent.imageName = imageName
                }
            }
        }
    }

}
func saveImageToDisk(_ uiImage: UIImage) -> String {
    let imageName = UUID().uuidString + ".jpg"
    let folderPath = getDocumentsDirectory().appendingPathComponent("Yue_Memes")

    // Check if the folder exists, if not, create it
    if !FileManager.default.fileExists(atPath: folderPath.path) {
        do {
            try FileManager.default.createDirectory(at: folderPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating Yue_Memes folder in documents dir: \(error)")
            return ""
        }
    }

    let imagePath = folderPath.appendingPathComponent(imageName)

    if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
        do {
            try jpegData.write(to: imagePath)
            return imageName
        } catch {
            print("Error saving image to Yue_Memes folder: \(error)")
            return ""
        }
    } else {
        return ""
    }
}

func deleteImageFromDisk(named imageName: String) {
    let folderPath = getDocumentsDirectory().appendingPathComponent("Yue_Memes")
    let imagePath = folderPath.appendingPathComponent(imageName)
    do {
        try FileManager.default.removeItem(at: imagePath)
    } catch {
        print("Error deleting image from Yue_Memes folder: \(error)")
    }
}

func loadImageFromDisk(named imageName: String) -> UIImage? {
    let folderPath = getDocumentsDirectory().appendingPathComponent("Yue_Memes")
    let imagePath = folderPath.appendingPathComponent(imageName)
    return UIImage(contentsOfFile: imagePath.path)
}


func getDocumentsDirectory() -> URL {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}
