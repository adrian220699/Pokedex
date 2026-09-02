//
//  GetBerriesUseCase.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/15/26.
//

final class GetBerriesUseCase {
    
    private let repository : BerryRepository
    
    init(repository: BerryRepository) {
        self.repository = repository
    }
    
    func execute (limit: Int, offset: Int) async throws -> [Berry] {
        
        return try await repository.getBerries(limit: limit, offset: offset)
    }
    
}
