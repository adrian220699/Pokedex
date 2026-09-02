//
//  GetBerryUseCase.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 6/24/26.
//

final class GetBerryUseCase {
    
    private let repository: BerryRepository
    
    init(repository: BerryRepository) {
        self.repository = repository
    }
    
    func execute(id : Int) async throws -> Berry {
        
        return try await repository.getBerry(id: id)
    }
    
    
}
