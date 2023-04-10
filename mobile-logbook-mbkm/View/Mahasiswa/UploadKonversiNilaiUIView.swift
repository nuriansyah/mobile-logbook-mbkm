//
//  UploadKonversiNilaiUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 30/03/23.
//

import SwiftUI

struct UploadKonversiNilaiUIView: View {
    @StateObject var viewModel = ViewModel()
    @State var selectedImages: [UIImage] = []
    
    var body: some View {
        VStack {
            Button(action: {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = false
                imagePicker.delegate = ImagePickerDelegate(onImagePicked: { image in
                    selectedImages.append(image)
                })
                UIApplication.shared.windows.first?.rootViewController?.present(imagePicker, animated: true, completion: nil)
            }) {
                Text("Select Images")
            }
            .padding()
            
            
                Button(action: {
                    let imagesData = selectedImages.map { $0.pngData()! }
                    viewModel.uploadImages(for: 1, images: imagesData) { result in
                        switch result {
                        case .success(let response):
                            print(response.message)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }) {
                    Text("Upload Images")
                }
                .padding()
            
        }
    }
}

class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    let onImagePicked: (UIImage) -> Void
    
    init(onImagePicked: @escaping (UIImage) -> Void) {
        self.onImagePicked = onImagePicked
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        onImagePicked(image)
        picker.dismiss(animated: true, completion: nil)
    }
}


struct UploadKonversiNilaiUIView_Previews: PreviewProvider {
    static var previews: some View {
        UploadKonversiNilaiUIView()
    }
}
