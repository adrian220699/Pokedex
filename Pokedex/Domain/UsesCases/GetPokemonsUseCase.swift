//
//  GetPokemonsUseCase.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/12/26.
//

final class GetPokemonsUseCase {
    
    private let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func execute(limit: Int, offset: Int) async throws -> [Pokemon] {
        
        return try await repository.getPokemons(limit: limit, offset: offset)
    }
}
