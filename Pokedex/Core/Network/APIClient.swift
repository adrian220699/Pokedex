//
//  APIClient.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/22/26.
//


import Foundation

final class APIClient {
    
    static let shared = APIClient()
    
    private init() {}
    
    func fetch<T: Decodable>(
        url : URL,
        type: T.Type
    ) async throws -> T {
        
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse,
              200...299 ~= response.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
}
