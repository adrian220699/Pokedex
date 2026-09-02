//
//  GetPokemonUseCase.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 6/15/26.
//

final class GetPokemonUseCase {
    
    private let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func execute(id : Int) async throws -> Pokemon {
        
        return try await repository.getPokemon(id: id)
    }
    
    
}
