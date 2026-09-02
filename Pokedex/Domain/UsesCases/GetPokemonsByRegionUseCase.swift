//
//  GetPokemonsByRegionUseCase.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 6/16/26.
//

final class GetPokemonsByRegionUseCase {
    
    private let repository : RegionRepository
    
    init (repository : RegionRepository) {
        
        self.repository = repository
    }
    
    
    func execute(range : ClosedRange<Int>, limit : Int, offset : Int)
    async throws -> [Pokemon] {
        
        try await repository.getPokemonsByRegion(range: range, limit: limit, offset: offset)
        
    }

    
}
