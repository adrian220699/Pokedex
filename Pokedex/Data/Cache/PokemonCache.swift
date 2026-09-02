//
//  PokemonCache.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 7/5/26.
//

import Foundation

actor PokemonCache {

    // MARK: - Init

      init() {

          print("PokemonCache creado")

      }
    
    // MARK: - Storage

    private var pokemons: [Int: Pokemon] = [:]

    // MARK: - Get Pokemon

    func pokemon(for id: Int) -> Pokemon? {

        // Revisar si el Pokémon existe dentro del Dictionary.

        if let pokemon = pokemons[id] {

            print("Cache contiene -> \(pokemon.name)")

            return pokemon
        }

        print("Cache vacío para id -> \(id)")

        return nil
    }

    // MARK: - Save Pokemon

    func save(_ pokemon: Pokemon) {

        // Guardar o reemplazar el Pokémon utilizando
        // su ID como llave del Dictionary.

        print("Guardando en cache -> \(pokemon.name)")

        pokemons[pokemon.id] = pokemon
    }
}
