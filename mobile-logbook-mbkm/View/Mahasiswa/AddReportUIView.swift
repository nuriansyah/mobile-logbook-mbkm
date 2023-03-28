//
//  AddReportUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 20/01/23.
//

import SwiftUI

struct AddReportUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var showSuccessAlert: Bool = false
    @State private var showErrorAlert: Bool = false
    @State private var errorMessage: String = ""
    @State private var date = Date()
    @State private var selectedImage: UIImage?
    @State private var imagePickerVisible: Bool = false
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            DatePicker("Date Now", selection: $date, in: Date().addingTimeInterval(-846000)...Date(), displayedComponents: [.date])
            Text("Title")
            TextField("title..", text: $title)
                .padding(.vertical,5)
                .padding(.horizontal,5)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(.black,lineWidth: 2))
            
            Text("Fill your Report")
                .font(.system(.subheadline).bold())
            TextField("Reportings yours..", text: $content,axis: .vertical)
            
                .padding([.horizontal,.vertical])
                .lineLimit(8, reservesSpace: true)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.black,lineWidth: 2))
            HStack{
                Text("Upload Your Photo")
                Spacer()
                Button(action: {
                    self.imagePickerVisible = true
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                })
            }
            .padding([.trailing,.vertical])
            .sheet(isPresented: $imagePickerVisible) {
                        ImagePickerView(selectedImage: self.$selectedImage)
                    }
                    .alert(isPresented: $showErrorAlert) {
                        Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK"),action: {
                            presentationMode.wrappedValue.dismiss()
                        }))
                    }
            Button(action: {
                ReportingAPI.shared.insertReport(title: self.title, content: self.content) { (result) in
                    switch result {
                    case .success:
                        self.showSuccessAlert = true
                    case .failure(let error):
                        self.showErrorAlert = true
                        self.errorMessage = error.localizedDescription
                        print(error)
                    }
                }
            }, label: {
                Text("Submit Report")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(5)
            })
            .padding(.vertical)
            
        }
        .padding()
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK"),action: {
                presentationMode.wrappedValue.dismiss()
            }))
        }
        if showSuccessAlert{
            NavigationLink(destination: HomeMahasiswaUIView(), isActive: $showSuccessAlert) {
                EmptyView()
            }
            .alert(isPresented: $showSuccessAlert) {
                Alert(title: Text("Success"), message: Text("Report submitted successfully"), dismissButton: .default(Text("OK"), action: {
                    presentationMode.wrappedValue.dismiss()
                }))
                
            }
        }
    }
}



struct AddReportUIView_Previews: PreviewProvider {
    static var previews: some View {
        AddReportUIView()
    }
}


struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // nothing to do here
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
