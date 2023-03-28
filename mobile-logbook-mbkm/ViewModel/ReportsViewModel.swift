//
//  ReportsViewModel.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 03/02/23.
//

import Foundation

class ListReportViewModel: ObservableObject {
    @Published var reports: [Report] = []
    @Published var mahasiswas = [MahasiswaDetail]()

    
    func fetchReports(completion: @escaping (Result<[Report], Error>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        
        let headers = [            "Authorization": "Bearer \(token)",            "Content-Type": "application/json"        ]
        
        let url = URL(string: "http://localhost:8080/api/reports/postsMhs")!
        
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
                let reports = try decoder.decode([Report].self, from: data)
                
                DispatchQueue.main.async {
                    self.reports = reports
                }
                completion(.success(reports))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }// MARK: fetchReports
    
    func fetchMahasiswaByDsn(completion: @escaping (Result<[MahasiswaDetail], Error>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        
        let headers = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        guard let url = URL(string: "http://localhost:8080/api/dosen/fetch") else { return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            if let data = data {
                do {
                    let mahasiswas = try JSONDecoder().decode([MahasiswaDetail].self, from: data)
                    DispatchQueue.main.async {
                        self.mahasiswas = mahasiswas
                        completion(.success(mahasiswas))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
// MARK: fetchMhsDetailReports
}


class ReportingAPI {
    static let shared = ReportingAPI()
    
    private init() {}
    
    
    func insertReport(title: String, content: String, completion: @escaping (Result<Int, Error>) -> Void) {
        let request = RequestReporting(title: title, content: content)
        guard let requestData = try? JSONEncoder().encode(request) else {
            completion(.failure(APIError.encodingError))
            return
        }
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        
        var urlRequest = URLRequest(url: URL(string: "http://localhost:8080/api/reports/")!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = requestData
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(.failure(APIError.serverError))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ResponseInsertReporting.self, from: data)
                completion(.success(response.id))
            } catch {
                completion(.failure(error))
                print(error)
            }
            
        }.resume()
    }
}

enum APIError: Error {
    case encodingError
    case serverError
}

class ReportsListViewModel: ObservableObject {
    @Published var reportsPending: [Report] = []
    @Published var reportsApproved: [Reports] = []
    @Published var reportsReject: [Reports] = []
    @Published var error: Error?
    @Published var countApproved: Int = 0
    @Published var countPending: Int = 0
    @Published var countRejected: Int = 0
    
    private let baseUrl = "http://localhost:8080/api/reports"
    private let session = URLSession.shared
    let token = UserDefaults.standard.string(forKey: "token") ?? ""
    func getPendingReports() {
        
        guard let url = URL(string: "\(baseUrl)/pendingList") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.error = error
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode),
                  let data = data else {
                DispatchQueue.main.async {
                    self.error = NSError(domain: "Response error", code: 0, userInfo: nil)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(PendingReportsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.reportsPending = response.pending
                    self.countPending = response.countPending.pending
                }
            } catch let error {
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }.resume()
    }//MARK: getPending
    func getApprovedReports() {
        guard let url = URL(string: "\(baseUrl)/approvedList") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.error = error
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode),
                  let data = data else {
                DispatchQueue.main.async {
                    self.error = NSError(domain: "Response error", code: 0, userInfo: nil)
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ApprovedReportsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.reportsApproved = response.approved
                    self.countApproved = response.countApproved.approved
                }
            } catch let error {
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }.resume()
    }//MARK: getApproved
    func getRejectedReports() {
        guard let url = URL(string: "\(baseUrl)/rejectList") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.error = error
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode),
                  let data = data else {
                DispatchQueue.main.async {
                    self.error = NSError(domain: "Response error", code: 0, userInfo: nil)
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(RejectedReportsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.reportsReject = response.reject
                    self.countRejected = response.countRejected.reject
                }
            } catch let error {
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }.resume()
    }//MARK: getApproved
}
