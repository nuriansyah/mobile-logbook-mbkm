//
//  ChangePasswordUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 14/02/23.
//

import SwiftUI

struct ChangePasswordUIView: View {
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.02))
                    .padding([.vertical,.horizontal])
                    .frame(width: .infinity,height: 300)
                    .overlay {
                        VStack(alignment:.leading, spacing:5){
                            Text("Old Password")
                                .font(.footnote.lowercaseSmallCaps())
                                .padding(.leading)
                            SecureField("Old Password", text: $oldPassword)
                                .textInputAutocapitalization(TextInputAutocapitalization.never)
                                .padding()
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(5.0)
                                .padding(.horizontal)
                            Text("New Password")
                                .font(.footnote.lowercaseSmallCaps())
                                .padding(.leading)
                            SecureField("New Password", text: $newPassword)
                                .textInputAutocapitalization(TextInputAutocapitalization.never)
                                .padding()
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(5.0)
                                .padding(.horizontal)
                            Text("Confirm Password")
                                .font(.footnote.lowercaseSmallCaps())
                                .padding(.leading)
                            SecureField("Confirm Password", text: $confirmPassword)
                                .textInputAutocapitalization(TextInputAutocapitalization.never)
                                .padding()
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(5.0)
                                .padding(.horizontal)
                        }.padding()
                    }
            }
            Spacer()
            Button(action: {
                // Perform password change here
                NavigationLink(destination: ProfileUIView()){
                    Text("dakasime")
                }
            }) {
                Text("Change Password")
                    .font(.headline)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(15.0)
            .padding(.bottom)
        }.navigationTitle("Change Password")
    }
}

struct ChangePasswordUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordUIView()
    }
}

