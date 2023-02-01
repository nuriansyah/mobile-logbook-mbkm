//
//  LoginMahasiswaUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 01/02/23.
//

import SwiftUI

struct LoginMahasiswaUIView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    @State var showPassword = false
    var body: some View {
        NavigationView {
            ZStack {
                Color.mint.ignoresSafeArea()
                VStack(spacing:10) {
                    
                        headerView
                    VStack(alignment:.leading) {
                        nrpForm
                        passwordForm
                            
                        
                    }

                    HStack{
                        Spacer()
                        Button("Forget Password?") {
                            //                        self.sessionVM.login(email: self.email, password: self.password)
                        }
                    }
                    NavigationLink(destination: HomeMahasiswaUIView().navigationBarBackButtonHidden(), isActive: $loginViewModel.isAuthenticated){EmptyView()}
                    Button(action: {
                        loginViewModel.loginMahasiswa()
                    }) {
                        Text("Login")
                            .fontWeight(.semibold)
                            .font(.title2.smallCaps())
                            .padding(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 60)
                            .background(.blue)
                            .cornerRadius(20)
                    }
                }
            .padding()
            }
        }
    }
}

struct LoginMahasiswaUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginMahasiswaUIView()
    }
}
extension LoginMahasiswaUIView {
    private var headerView: some View{
        VStack(alignment: .center){
            Text("Welcome,")
                .font(.title.bold().monospaced())
            Text("Glad to see you!")
                .font(.largeTitle.monospacedDigit().uppercaseSmallCaps())
        }
    }//:MARK header
    private var nrpForm: some View{
        Section {
            TextField("NRP", text: $loginViewModel.nrp)
                .autocorrectionDisabled()
                .textInputAutocapitalization(TextInputAutocapitalization.never)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.2)))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white,lineWidth: 1)
                    )
                    .foregroundColor(.black)
                
                
        }header: {
            Text("NRP")
                .font(.callout.smallCaps())
        }
    }//::MARK loginform
    private var passwordForm: some View{
            Section{
                if showPassword {
                    TextField("Password", text: $loginViewModel.password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.2)))
                        .overlay {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white,lineWidth: 1)
                                    .overlay {
                                        HStack{
                                            Spacer()
                                            Button(action: {self.showPassword.toggle()}) {
                                                Text(showPassword ? Image(systemName: "eye.slash") : Image(systemName: "eye.fill")).foregroundColor(.black)
                                            }.padding(.trailing)
                                        }
                                    }
                            }
                        }
                } else {
                    SecureField("Password", text: $loginViewModel.password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.2)))
                        .overlay {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white,lineWidth: 1)
                                    .overlay {
                                        HStack{
                                            Spacer()
                                            Button(action: {self.showPassword.toggle()}) {
                                                Text(showPassword ? Image(systemName: "eye.slash") : Image(systemName: "eye.fill")).foregroundColor(.black)
                                            }.padding(.trailing)
                                        }
                                    }
                            }
                        }
                }
            }header: {
                Text("Password")
                    .font(.callout.smallCaps())
            }
        }
}
