//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/12/26.
//

protocol PokemonRepository {
    func getPokemons(limit: Int, offset: Int) async throws -> [Pokemon]
    func getPokemon(id : Int) async throws -> Pokemon


}
