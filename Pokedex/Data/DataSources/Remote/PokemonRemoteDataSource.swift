//
//  PokemonRemoteDataSource.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/12/26.
//

import Foundation

final class PokemonRemoteDataSource {

    // MARK: - Fetch Single Pokemon

    func fetchPokemon(
        id: Int
    ) async throws -> PokemonDTO {

        guard let url = URL(
            string: APIEndpoints.pokemon(id: id)
        ) else {
            throw NetworkError.invalidURL
        }

        return try await APIClient.shared.fetch(
            url: url,
            type: PokemonDTO.self
        )
    }

    // MARK: - Fetch Pokemon List

    func fetchPokemons(limit: Int, offset: Int) async throws -> PokemonListDTO {

        guard let url = URL(
            string: APIEndpoints.pokemonList(limit: APIConstants.defaultLimit , offset: offset)
        ) else {
            throw NetworkError.invalidURL
        }

        return try await APIClient.shared.fetch(
            url: url,
            type: PokemonListDTO.self
        )
    }

    // MARK: - Fetch Pokemon Species

    func fetchPokemonSpecies(
        id: Int
    ) async throws -> PokemonSpeciesDTO {

        guard let url = URL(
            string: APIEndpoints.pokemonSpecies(id: id)
        ) else {
            throw NetworkError.invalidURL
        }

        return try await APIClient.shared.fetch(
            url: url,
            type: PokemonSpeciesDTO.self
        )
    }

    // MARK: - Fetch Pokemon Encounters

    func fetchPokemonEncounters(
        id: Int
    ) async throws -> [PokemonEncounterDTO] {

        guard let url = URL(
            string: APIEndpoints.pokemonEncounters(id: id)
        ) else {
            throw NetworkError.invalidURL
        }

        return try await APIClient.shared.fetch(
            url: url,
            type: [PokemonEncounterDTO].self
        )
    }

    // MARK: - Fetch Characteristic

    func fetchCharacteristic(
        id: Int
    ) async throws -> CharacteristicDTO {

        guard let url = URL(
            string: APIEndpoints.characteristic(id: id)
        ) else {
            throw NetworkError.invalidURL
        }

        return try await APIClient.shared.fetch(
            url: url,
            type: CharacteristicDTO.self
        )
    }
}
