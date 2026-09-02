//
//  RegionRemoteDataSource.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/18/26.
//

import Foundation

final class RegionRemoteDataSource {
    
    //MARK: - Fetch Region Name
    
    func fetchPokemonRegion(id : Int) async throws -> RegionDTO {
        
      guard let url = URL(
        string: APIEndpoints.region(id: id)
      ) else {
          throw NetworkError.invalidURL
      }
        
        return try await APIClient.shared.fetch(
            url: url,
            type: RegionDTO.self)
    }
    
}
