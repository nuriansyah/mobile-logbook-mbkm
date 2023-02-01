//
//  NewPasswordUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 21/01/23.
//

import SwiftUI

struct NewPasswordUIView: View {
    @State private var password: String = ""
    @State private var newPassword: String = ""
    var body: some View {
        VStack(alignment: .leading){
            Section{
                SecureField("8 symbols at least.", text: $password)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(TextInputAutocapitalization.never)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray,lineWidth: 1)
                    )
                    .padding(.horizontal)
                    .foregroundColor(.black)
            } header: {
                Text("Enter New Password")
                    .padding(.leading)
            }
            Section{
                SecureField("********", text: $newPassword)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(TextInputAutocapitalization.never)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray,lineWidth: 1)
                    )
                    .padding(.horizontal)
                    .foregroundColor(.black)
            } header: {
                Text("Confirm Password")
                    .padding(.leading)
            }
            HStack{
                Spacer()
                Button {
                    
                } label: {
                    Text("Submit")
                        .fontWeight(.semibold)
                        .font(.title2.smallCaps())
                }
                .padding(6)
                .foregroundColor(.white)
                .padding(.horizontal,40)
                .background(.blue)
                .cornerRadius(20)
                Spacer()
            }
        }
    }
}

struct NewPasswordUIView_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordUIView()
    }
}
