//
//  GetItemUseCase.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 6/24/26.
//

final class GetItemUseCase {
    
    private let repository: ItemsRepository
    
    init(repository: ItemsRepository) {
        self.repository = repository
    }
    
    func execute(id : Int) async throws -> Item {
        
        return try await repository.getItem(id: id)
    }
    
    
}
