//
//  GetItemsUseCase.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/16/26.
//



final class GetItemsUseCase {
    
    private let repository: ItemsRepository
    
    init(repository: ItemsRepository) {
        self.repository = repository
    }
    
    func execute(limit: Int, offset: Int) async throws -> [Item] {
        return try await repository.getItems(limit: limit, offset: offset)
    }
}
