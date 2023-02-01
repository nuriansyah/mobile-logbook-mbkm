//
//  LoginViewModel.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 28/01/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    var nrp: String = ""
    var email: String = ""
    var password: String = ""
    @Published var isAuthenticated: Bool = false
    
    func loginDosen() {
        
        let defaults = UserDefaults.standard
        
        Webservice().loginDosen(email: email, password: password) { result in
            switch result {
                case .success(let token):
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    func loginMahasiswa() {
        
        let defaults = UserDefaults.standard
        
        Webservice().loginMahasiswa(nrp: nrp, password: password) { result in
            switch result {
                case .success(let token):
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func signout() {
           
           let defaults = UserDefaults.standard
           defaults.removeObject(forKey: "jsonwebtoken")
           DispatchQueue.main.async {
               self.isAuthenticated = false
           }
           
       }
    
}
