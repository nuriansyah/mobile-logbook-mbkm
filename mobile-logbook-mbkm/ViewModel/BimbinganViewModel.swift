//
//  BimbinganViewModel.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 13/02/23.
//

import Foundation

class ListRequestPendampingViewModel: ObservableObject {
    @Published var reports: [Bimbingan] = []

    func fetchReports(completion: @escaping (Result<[Bimbingan], Error>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""

        let headers = [            "Authorization": "Bearer \(token)",            "Content-Type": "application/json"        ]

        let url = URL(string: "http://localhost:8080/api/pembimbing/getRequest")!

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
                let reports = try decoder.decode([Bimbingan].self, from: data)
                DispatchQueue.main.async {
                    self.reports = reports
                }
                completion(.success(reports))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
class UpdateBimbinganViewModel: ObservableObject{
    @Published var bimbinganStatus: BimbinganStatus = .pending
    @Published var errorMessage: String?


    func updateBimbingan(mahasiswaID: Int, completion: @escaping (Result<SuccessPembimbingResponse, ErrorPembimbingResponse>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let url = URL(string: "http://localhost:8080/api/pembimbing/")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let body = ["MahasiswaID": mahasiswaID]
        request.httpBody = try! JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(ErrorPembimbingResponse(message: error.localizedDescription)))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(ErrorPembimbingResponse(message: "No data returned")))
                }
                return
            }

            let decoder = JSONDecoder()
            if let response = try? decoder.decode(SuccessPembimbingResponse.self, from: data) {
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            } else if let response = try? decoder.decode(ErrorPembimbingResponse.self, from: data) {
                DispatchQueue.main.async {
                    completion(.failure(response))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(ErrorPembimbingResponse(message: "Failed to parse response")))
                }
            }
        }
        task.resume()
    }


    
    func deletePembimbing(mahasiswaID: Int) {
            let url = URL(string: "http://localhost:8080/api/pembimbing/\(mahasiswaID)")!
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, error == nil else {
                    self.errorMessage = "Error: \(error?.localizedDescription ?? "Unknown error")"
                    return
                }

                if httpResponse.statusCode == 200 {
                    // Handle success
                } else {
                    self.errorMessage = "Server returned \(httpResponse.statusCode)"
                }
            }.resume()
        }
}

class UploadViewModel: ObservableObject {
    @Published var uploadSuccess = false
    @Published var errorMessage = ""

    func uploadFiles(files: [URL], completion: @escaping () -> Void) {
        // Set URL endpoint
        let url = URL(string: "http://localhost:8080/api/reports/upload")!

        // Set headers
        let token = UserDefaults.standard.string(forKey: "token") ?? ""

        let headers = ["Authorization": "Bearer \(token)"]

        // Set multipart/form-data request
        let boundary = UUID().uuidString
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = headers

        // Set body with multipart/form-data format
        let httpBody = createBody(with: files, boundary: boundary)
        request.httpBody = httpBody

        // Send request with URLSession
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else if let data = data {
                    do {
                        let response = try JSONDecoder().decode(UploadResponse.self, from: data)
                        self.uploadSuccess = true
                    } catch {
                        self.errorMessage = error.localizedDescription
                    }
                } else {
                    self.errorMessage = "Unknown error"
                }
                completion()
            }
        }
        task.resume()
    }

    
    // Helper function to create multipart/form-data body
    private func createBody(with files: [URL], boundary: String) -> Data {
        var body = Data()

        for file in files {
            let filename = file.lastPathComponent
            let mimetype = mimeType(for: file.pathExtension)

            body.append(Data("--\(boundary)\r\n".utf8))
            body.append(Data("Content-Disposition: form-data; name=\"docs\"; filename=\"\(filename)\"\r\n".utf8))
            body.append(Data("Content-Type: \(mimetype)\r\n\r\n".utf8))

            if let data = try? Data(contentsOf: file) {
                body.append(data)
            }

            body.append(Data("\r\n".utf8))
        }

        body.append(Data("--\(boundary)--\r\n".utf8))

        return body
    }
    
    // Helper function to get MIME type for file extension
    private func mimeType(for fileExtension: String) -> String {
        switch fileExtension {
        case "pdf":
            return "application/pdf"
        case "doc", "docx":
            return "application/msword"
        default:
            return "application/octet-stream"
        }
    }
}
class RequestPembimbingViewModel: ObservableObject {
    @Published var pembimbing: Pembimbing?
    @Published var error: String?
    @Published var isLoading = false
    
    func requestPembimbing(dosenId: Int) {
        isLoading = true
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let url = URL(string: "http://localhost:8080/api/pembimbing/reqPembimbing")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let params: [String: Any] = ["dosen_id": dosenId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.error = error.localizedDescription
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201,
                    let data = data else {
                        self.error = "Invalid response from server"
                        return
                }
                do {
                    let decoder = JSONDecoder()
                    let pembimbing = try decoder.decode(Pembimbing.self, from: data)
                    self.pembimbing = pembimbing
                } catch {
                    self.error = error.localizedDescription
                }
            }
        }
        task.resume()
    }
}
class BimbinganViewModel: ObservableObject {
    @Published var message: String = ""
    @Published var errorMessage: String = ""
    @Published var didApproveBimbingan = false
    @Published var didRejectedBimbingan = false


    func approveBimbingan(postId: Int) {
        guard let url = URL(string: "http://localhost:8080/api/pembimbing/\(postId)/accepted") else {
            errorMessage = "Invalid URL format"
            return
        }
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }

            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid response"
                }
                return
            }

            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.message = "Bimbingan approved successfully"
                    self.didApproveBimbingan = true
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to approve bimbingan"
                }
            }
        }.resume()
    }
    func rejectedBimbingan(postId: Int) {
        guard let url = URL(string: "http://localhost:8080/api/pembimbing/\(postId)/rejected") else {
            errorMessage = "Invalid URL format"
            return
        }
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }

            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid response"
                }
                return
            }

            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.message = "Bimbingan Rejected successfully"
                    self.didRejectedBimbingan = true
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to approve bimbingan"
                }
            }
        }.resume()
    }
}



enum BimbinganStatus: String {
  case accepted = "Accepted"
  case pending = "Pending"
}
extension ErrorPembimbingResponse: Error {}

