//
//  ItemsRemoteDataSource.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/16/26.
//

import Foundation

struct ItemsRemoteDataSource {
    
    //MARK: - Fetch Single Item
    
    func fetchItem(id : Int) async throws -> ItemsDetailDTO {
        
        guard let url = URL(
            
            string: APIEndpoints.item(id: id)
            
        ) else {
            throw NetworkError.invalidURL
        }
        
        return try await APIClient.shared.fetch(
            url: url,
            type: ItemsDetailDTO.self)
        
    }

    func fetchItems(limit: Int, offset: Int) async throws -> ItemsDTO {

        guard let url = URL(
            string: APIEndpoints.itemList(
                limit: APIConstants.defaultLimit, offset: offset
            )
        ) else {
            throw NetworkError.invalidURL
        }

        return try await APIClient.shared.fetch(
            url: url,
            type: ItemsDTO.self
        )
    }

    func fetchItemsDetails(
        url: String
    ) async throws -> ItemsDetailDTO {

        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }

        return try await APIClient.shared.fetch(
            url: url,
            type: ItemsDetailDTO.self
        )
    }
}
