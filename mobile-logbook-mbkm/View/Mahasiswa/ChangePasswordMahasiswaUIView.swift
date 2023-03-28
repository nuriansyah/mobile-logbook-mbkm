//
//  ChangePasswordMahasiswaUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 25/03/23.
//

import SwiftUI

struct ChangePasswordMahasiswaUIView: View {
    @State private var password = ""
    @ObservedObject var viewModel = UserViewModel()
    
    var body: some View {
        VStack {
            TextField("New Password", text: $password)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.03)))
                .overlay {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black,lineWidth: 1)
                            .overlay {
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        viewModel.changePasswordMahasiswa(password: password)
                                    }) {
                                        Image(systemName: "lock.rotation")
                                            .font(.title2)
                                    }.padding(.trailing)
                                }
                            }
                    }
                }
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
            }
            if viewModel.isSuccessful {
                Text("Password changed successfully")
                    .foregroundColor(.green)
            }
        }
        .padding()
    }
}

struct ChangePasswordMahasiswaUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordMahasiswaUIView()
    }
}
