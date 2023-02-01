//
//  Services.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 28/01/23.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequestBodyMahasiswa: Codable {
    let nrp: String
    let password: String
}

struct LoginRequestBodyDosen: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}

class Webservice {
    func loginDosen(email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
            
            guard let url = URL(string: "http://localhost:8080/loginDosen") else {
                completion(.failure(.custom(errorMessage: "URL is not correct")))
                return
            }
            
            let body = LoginRequestBodyDosen(email: email, password: password)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONEncoder().encode(body)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard let data = data, error == nil else {
                    completion(.failure(.custom(errorMessage: "No data")))
                    return
                }
                
                try! JSONDecoder().decode(LoginResponse.self, from: data)
                
                guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                    completion(.failure(.invalidCredentials))
                    return
                }
                
                guard let token = loginResponse.token else {
                    completion(.failure(.invalidCredentials))
                    return
                }
                
                completion(.success(token))
                
            }.resume()
            
        }
    func loginMahasiswa(nrp: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
            
            guard let url = URL(string: "http://localhost:8080/loginMahasiswa") else {
                completion(.failure(.custom(errorMessage: "URL is not correct")))
                return
            }
            
            let body = LoginRequestBodyMahasiswa(nrp: nrp, password: password)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONEncoder().encode(body)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard let data = data, error == nil else {
                    completion(.failure(.custom(errorMessage: "No data")))
                    return
                }
                
                try! JSONDecoder().decode(LoginResponse.self, from: data)
                
                guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                    completion(.failure(.invalidCredentials))
                    return
                }
                
                guard let token = loginResponse.token else {
                    completion(.failure(.invalidCredentials))
                    return
                }
                
                completion(.success(token))
                
            }.resume()
            
        }
}
