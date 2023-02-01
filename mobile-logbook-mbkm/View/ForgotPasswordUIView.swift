//
//  ForgotPasswordUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 21/01/23.
//

import SwiftUI

struct ForgotPasswordUIView: View {
    @State private var email: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            VStack{
                Image("locked-forgot")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .infinity,height: 250)
                    .padding(.bottom)
                Text("Please enter your email addres,\nReceive a verification code!")
                    .padding(.leading)
                    .font(.title2.monospacedDigit())
            }
            Section {
                TextField("Email", text: $email)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(TextInputAutocapitalization.never)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray,lineWidth: 1)
                    )
                    .foregroundColor(.black)
            }.padding([.horizontal,.vertical])
            
            HStack{
                Spacer()
                Button {
                    
                } label: {
                    Text("Send")
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
            Spacer()
        }
    }
}

struct ForgotPasswordUIView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordUIView()
    }
}
