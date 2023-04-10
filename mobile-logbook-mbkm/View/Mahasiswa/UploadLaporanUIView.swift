//
//  UploadLaporanUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 08/02/23.
//

import SwiftUI

struct UploadLaporanUIView: View {
    @StateObject private var uploadViewModel = UploadViewModel()
    @State private var showDocumentPicker = false

    var body: some View {
        VStack {
            if uploadViewModel.uploadSuccess {
                Text("File berhasil diupload!")
                    .foregroundColor(.green)
            } else if !uploadViewModel.errorMessage.isEmpty {
                Text("Terjadi kesalahan: \(uploadViewModel.errorMessage)")
                    .foregroundColor(.red)
            }

            Button(action: {
                self.showDocumentPicker.toggle()
            }) {
                Image(systemName: "doc.badge.arrow.up.fill")
                    .font(.title)
                Text("Upload Konversi Nilai")
            }
            .sheet(isPresented: $showDocumentPicker) {
                DocumentPickerView(isPresented: self.$showDocumentPicker, uploadViewModel: self.uploadViewModel)
            }
        }
    }
}

struct UploadLaporanUIView_Previews: PreviewProvider {
    static var previews: some View {
        UploadLaporanUIView()
    }
}

struct DocumentPickerView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @ObservedObject var uploadViewModel: UploadViewModel

    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPickerView>) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPickerView>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPickerView

        init(_ parent: DocumentPickerView) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            parent.uploadViewModel.uploadFiles(files: [url]) { [self] in
                parent.isPresented = false
            }
        }
    }
}
