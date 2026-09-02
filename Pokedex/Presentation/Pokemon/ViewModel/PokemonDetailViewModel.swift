//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 6/15/26.
//

import Foundation

final class PokemonDetailViewModel {
    
    //MARK: - UseCase
    
    private let getPokemonUseCase : GetPokemonUseCase
    
    //MARK: - State
    
    var state: ViewState <Pokemon> = .idle
    
    //MARK: - Init
    
    init(getPokemonUseCase: GetPokemonUseCase) {
        self.getPokemonUseCase = getPokemonUseCase
    }
    
    //MARK: - Load Pokémon
    
    func loadPokemon(id : Int) async {
        state = .loading
        
        do {
            
            let pokemon = try await getPokemonUseCase.execute(id: id)
            state = .success(pokemon)
            
        } catch {
            
            state = .error(error)
        }
        
    }
    
    //MARK: - Random Moves
    
    func randomMoves(from pokemon: Pokemon) -> String {
        
        let moves = Array( pokemon.move.shuffled().prefix(4))
        
        
        return moves.joined(
            separator: "\n"
        )
        
        
    }
    
    func randomLocations(from pokemon : Pokemon) -> String {
        
        let location = Array (pokemon.location.shuffled().prefix(2))
        
        return location.joined(
            separator: "\n"
            
        )
    }
    
}
