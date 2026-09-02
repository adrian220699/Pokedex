//
//  APIEndpoints.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/22/26.
//

import Foundation

enum APIEndpoints {

    static let baseURL = "https://pokeapi.co/api/v2"

    // MARK: - Pokemon

    static func pokemon(id: Int) -> String {
        "\(baseURL)/pokemon/\(id)"
    }

    static func pokemonList(limit: Int, offset: Int) -> String {
        "\(baseURL)/pokemon?limit=\(limit)&offset=\(offset)"
    }

    // MARK: - Pokemon Species

    static func pokemonSpecies(id: Int) -> String {
        "\(baseURL)/pokemon-species/\(id)/"
    }

    // MARK: - Pokemon Encounters

    static func pokemonEncounters(id: Int) -> String {
        "\(baseURL)/pokemon/\(id)/encounters"
    }

    // MARK: - Characteristic

    static func characteristic(id: Int) -> String {
        "\(baseURL)/characteristic/\(id)/"
    }

    // MARK: - Berries

    static func berry(id: Int) -> String {
        return "\(baseURL)/berry/\(id)"
    }
    
    static func berryList(limit: Int, offset: Int) -> String {
        "\(baseURL)/berry?limit=\(limit)&offset=\(offset)"
    }

    // MARK: - Items

    static func item(id: Int) -> String {
        return "\(baseURL)/item/\(id)"
    }

    static func itemList(limit: Int,offset: Int) -> String {
        return "\(baseURL)/item?limit=\(limit)&offset=\(offset)"
    }
    
    // MARK: - Regions

    static func region(id: Int) -> String {
        return "\(baseURL)/region/\(id)"
    }
}
