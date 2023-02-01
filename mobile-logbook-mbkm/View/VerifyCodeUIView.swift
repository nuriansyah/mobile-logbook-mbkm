//
//  VerifyCodeUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 21/01/23.
//

import SwiftUI

struct VerifyCodeUIView: View {
    @State private var email: String = ""
    var body: some View {
        VStack{
            Image("verif-forgot")
                .resizable()
                .scaledToFill()
                .frame(width: .infinity,height: 200)
                .padding()
            
            Text("Email Verification Code")
                .padding(.top)
            HStack {
                TextField("", text: $email)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(TextInputAutocapitalization.never)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray,lineWidth: 1)
                    )
                    .padding(.horizontal)
                    .foregroundColor(.black)
            }
            HStack{
                Text("If you didn't receive a code!")
            }
            HStack{
                Spacer()
                Button {
                    
                } label: {
                    Text("Verify")
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

struct VerifyCodeUIView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyCodeUIView()
    }
}
