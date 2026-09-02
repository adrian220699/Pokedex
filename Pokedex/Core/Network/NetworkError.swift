//
//  NetworkError.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/22/26.
//

import Foundation

enum NetworkError : Error {
    
       case invalidURL
       case invalidResponse
       case invalidStatusCode(Int)
       case decodingError
       case noData
       case unknown(Error)
    
}
