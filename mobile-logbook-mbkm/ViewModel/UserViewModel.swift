//
//  UserViewModel.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 02/02/23.
//

import Foundation

class UserViewModel: ObservableObject {
  @Published var user: User?
    @Published var errorMessage = ""
    @Published var isSuccessful = false
    
  func fetchUser() {
    guard let token = retrieveToken() else { return }
    let url = URL(string: "http://localhost:8080/api/mahasiswa/fetch")!
    var request = URLRequest(url: url)
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
      if let error = error {
        print(error)
        return
      }
      guard let data = data else {
        print("No data returned")
        return
      }
      do {
        let user = try JSONDecoder().decode(User.self, from: data)
        DispatchQueue.main.async {
          self?.user = user
        }
      } catch {
        print(error)
      }
    }.resume()
  }
    func changePasswordMahasiswa(password: String) {
            let requestPassword = RequestPassword(password: password)
            guard let url = URL(string: "http://localhost:8080/api/dosen/changePasswordMhs") else {
                self.errorMessage = "Invalid URL"
                return
            }
            let token = UserDefaults.standard.string(forKey: "token") ?? ""
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            do {
                let jsonData = try JSONEncoder().encode(requestPassword)
                urlRequest.httpBody = jsonData
            } catch {
                self.errorMessage = error.localizedDescription
                return
            }
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    self.errorMessage = "Unexpected response"
                    return
                }
                self.isSuccessful = true
            }.resume()
        }
  
  private func retrieveToken() -> String? {
      return UserDefaults.standard.string(forKey: "token")
  }
}
class DosenViewModel: ObservableObject {
  @Published var dosen: Dosen?
  @Published var errorMessage = ""
  @Published var isSuccessful = false
    
  func fetchUser() {
    guard let token = retrieveToken() else { return }
    let url = URL(string: "http://localhost:8080/api/dosen/fetchData")!
    var request = URLRequest(url: url)
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
      if let error = error {
        print(error)
        return
      }
      guard let data = data else {
        print("No data returned")
        return
      }
      do {
        let user = try JSONDecoder().decode(Dosen.self, from: data)
        DispatchQueue.main.async {
          self?.dosen = user
        }
      } catch {
        print(error)
      }
    }.resume()
  }
    func changePasswordDosen(password: String) {
            let requestPassword = RequestPassword(password: password)
            guard let url = URL(string: "http://localhost:8080/api/dosen/changePasswordDosen") else {
                self.errorMessage = "Invalid URL"
                return
            }
            let token = UserDefaults.standard.string(forKey: "token") ?? ""
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            do {
                let jsonData = try JSONEncoder().encode(requestPassword)
                urlRequest.httpBody = jsonData
            } catch {
                self.errorMessage = error.localizedDescription
                return
            }
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    self.errorMessage = "Unexpected response"
                    return
                }
                self.isSuccessful = true
            }.resume()
        }
  
  private func retrieveToken() -> String? {
      return UserDefaults.standard.string(forKey: "token")
  }
}


class ListUserViewModel: ObservableObject {
    @Published var users: [User] = []

    func fetchReports(completion: @escaping (Result<[User], Error>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""

        let headers = [            "Authorization": "Bearer \(token)",            "Content-Type": "application/json"        ]

        let url = URL(string: "http://localhost:8080/api/dosen/fetch")!

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data not found."])
                completion(.failure(error))
                return
            }

            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    self.users = users
                }
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
class MahasiswaDetailViewModel: ObservableObject {
    @Published var mahasiswa: Mahasiswa
    

    init(mahasiswa: Mahasiswa) {
        self.mahasiswa = mahasiswa
    }

    func editDetailMahasiswa() {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        guard let url = URL(string: "http://localhost:8080/api/mahasiswa/") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        guard let jsonData = try? encoder.encode(mahasiswa) else {
            return
        }

        URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil,
                  response.statusCode == 200 else {
                return
            }
            DispatchQueue.main.async {
                           print("Mahasiswa details updated successfully")
            }
        }.resume()
    }
}

struct RequestPassword: Encodable {
    let password: String
}
