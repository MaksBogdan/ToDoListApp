//
//  NetworkService.swift
//  ToDoListApp
//
//  Created by Максим Богдан on 15.02.26.
//

import Foundation

struct TodoResponse: Codable {
    let todos: [Todo]
}

struct Todo: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case unknown(Error)
}

final class NetworkService: Sendable {
    
    func fetchTodos() async throws -> [Todo] {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(TodoResponse.self, from: data)
            return response.todos
        } catch {
            throw NetworkError.decodingError
        }
    }
}
