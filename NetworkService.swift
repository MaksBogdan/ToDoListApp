//
//  NetworkService.swift
//  FEROMEET
//
//  Created by Максим Богдан on 12.02.26.
//

//import Foundation
//
//struct TodoResponse: Codable {
//    let todos: [Todo]
//}
//
//struct Todo: Codable {
//    let id: Int
//    let todo: String
//    let completed: Bool
//    let userId: Int
//}
//
//class NetworkService {
//    func fetchTodos(completion: @escaping (Result<[Todo], Error>) -> Void) {
//        guard let url = URL(string: "https://dummyjson.com/todos") else {
//            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
//            return
//        }
//        
//        DispatchQueue.global(qos: .background).async {
//            let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//                
//                guard let data = data else {
//                    completion(.failure(NSError(domain: "No data", code: -1)))
//                    return
//                }
//                
//                do {
//                    let response = try JSONDecoder().decode(TodoResponse.self, from: data)
//                    completion(.success(response.todos))
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//            task.resume()
//        }
//    }
//}
