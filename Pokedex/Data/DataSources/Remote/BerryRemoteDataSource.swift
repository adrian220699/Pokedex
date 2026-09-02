//
//  BerryRemoteDataSource.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/15/26.
//

import Foundation

final class BerryRemoteDataSource  {
    
    //MARK: - Fetch Single Berry
    
    func fetchBerry(id : Int) async throws -> BerryDTO {
        
        guard let url = URL(
            
            string: APIEndpoints.berry(id: id)
            
        ) else {
            throw NetworkError.invalidURL
        }
        
        return try await APIClient.shared.fetch(
            url: url,
            type: BerryDTO.self)
        
    }
    
    //MARK: - Fetch Berries List
    
    func fetchBerries(limit: Int, offset: Int) async throws -> BerryListDTO {
        
        guard let url = URL(
            
            string : APIEndpoints.berryList(limit: APIConstants.defaultLimit, offset: offset)
        ) else {
            
            throw NetworkError.invalidURL
        }
        
        return try await APIClient.shared.fetch(
            url: url,
            type: BerryListDTO.self)
        
    }
    
    //MARK: - Fetch Item Detail
    
    func fetchItemDetail(
        
        urlString : String
        
    ) async throws -> ItemDetailDTO {
        
        guard let url = URL(
            string: urlString
        ) else {
            throw NetworkError.invalidURL
        }
        
        return try await APIClient.shared.fetch(
            url: url,
            type: ItemDetailDTO.self
        )
        
    }
    
}
