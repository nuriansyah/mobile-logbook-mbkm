//
//  CommentsViewModel.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 25/03/23.
//

import Foundation

struct CreateCommentRequest: Codable {
    let post_id: Int
    let comment: String
}


class CreateCommentViewModel: ObservableObject{
    @Published var errrorMessage = ""
    @Published var isSuccessful = false
    
    func createCommentMahasiswa(postID: Int,comment: String){
        let createCommentRequest = CreateCommentRequest(post_id:postID,comment:comment)
        guard let url = URL(string: "http://localhost:8080/api/comments/mhs") else{
            self.errrorMessage = "Invalid URL"
            return
        }
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do{
            let jsonData = try JSONEncoder().encode(createCommentRequest)
            urlRequest.httpBody = jsonData
        } catch{
            self.errrorMessage = error.localizedDescription
            return
        }
        URLSession.shared.dataTask(with: urlRequest){ data,response,error in
            if let error = error {
                self.errrorMessage = error.localizedDescription
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                self.errrorMessage = "Unexpected response"
                return
            }
            self.isSuccessful = true
        }.resume()
    }
    func createCommentDosen(postID: Int,comment: String){
        let createCommentRequest = CreateCommentRequest(post_id:postID,comment:comment)
        guard let url = URL(string: "http://localhost:8080/api/comments/dosen") else{
            self.errrorMessage = "Invalid URL"
            return
        }
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do{
            let jsonData = try JSONEncoder().encode(createCommentRequest)
            urlRequest.httpBody = jsonData
        } catch{
            self.errrorMessage = error.localizedDescription
            return
        }
        URLSession.shared.dataTask(with: urlRequest){ data,response,error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errrorMessage = error.localizedDescription
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                DispatchQueue.main.async {
                    self.errrorMessage = "Unexpected response"
                }
                return
            }
            DispatchQueue.main.async {
                self.isSuccessful = true
            }
        }.resume()
        
    }
}

class CommentViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    @Published var errorMessage: String = ""
    
    func fetchComments(postID: Int) {
        if let url = URL(string: "http://localhost:8080/api/comments/dosen/\(postID)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        return
                    }
                    guard let data = data else {
                        self.errorMessage = "No data found"
                        return
                    }
                    do {
                        self.comments = try JSONDecoder().decode([Comment].self, from: data)
                    } catch {
                        self.errorMessage = "Failed to decode data: \(error.localizedDescription)"
                    }
                }
            }.resume()
        }
    }
    
    func getAllComments(postID: Int) {
            guard let url = URL(string: "http://localhost:8080/api/comments/\(postID)") else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error while fetching comments: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let commentLists = try decoder.decode([Comment].self, from: data)
                    DispatchQueue.main.async {
                        self.comments = commentLists
                    }
                } catch {
                    print("Error while decoding comments: \(error.localizedDescription)")
                }
            }.resume()
        }
}





