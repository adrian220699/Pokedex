//
//  RegionPokemonListImpl.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/18/26.
//

import Foundation

final class RegionPokemonListImpl: RegionRepository {

    // MARK: - Dependencies

    private let remoteDataSource: RegionRemoteDataSource
    private let pokemonRemoteDataSource: PokemonRemoteDataSource

    init(
        remoteDataSource: RegionRemoteDataSource,
        pokemonRemoteDataSource: PokemonRemoteDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.pokemonRemoteDataSource = pokemonRemoteDataSource
    }

    // MARK: - Regions

    // Obtener varias regiones por IDs.

    func getRegions(ids: [Int]) async throws -> [Region] {

        // 1. Arreglo final que almacenará las entidades.

        var regions: [Region] = []

        // 2. Crear un TaskGroup.
        // Se utiliza porque el número de Child Tasks depende
        // de la cantidad de IDs recibidos.

        try await withThrowingTaskGroup(
            of: Region.self
        ) { group in

            // 3. Recorrer los IDs recibidos.
            // Por cada ID se crea una Child Task.

            for id in ids {

                // 4. Crear una Child Task.
                // Cada Child Task descarga una región
                // de forma concurrente e independiente.

                group.addTask {

                    // Obtener la región.

                    let dto =
                        try await self.remoteDataSource.fetchPokemonRegion(
                            id: id
                        )

                    // Convertir DTO -> Entity.
                    // Cada Child Task devuelve directamente
                    // una entidad Region.

                    return await dto.toDomain()
                }
            }

            // 5. Recibir los resultados conforme las Child Tasks
            // van terminando.
            // Solo la Task Principal modifica el arreglo final.

            for try await region in group {

                regions.append(region)
            }
        }

        // 6. Como TaskGroup devuelve resultados conforme terminan,
        // el orden puede variar.
        // Se ordena por ID para mantener un orden consistente.

        regions.sort { firstRegion, secondRegion in

            firstRegion.id < secondRegion.id
        }

        // 7. Retornar la lista final.

        return regions
    }

    // MARK: - Pokemon By Region

    // Obtener Pokémon pertenecientes a una región.

    func getPokemonsByRegion(
        range: ClosedRange<Int>,
        limit: Int,
        offset: Int
    ) async throws -> [Pokemon] {

        // 1. Obtener únicamente los IDs correspondientes
        // a la página solicitada.

        let ids =
            Array(range)
                .dropFirst(offset)
                .prefix(limit)

        // 2. Arreglo final que almacenará las entidades.

        var pokemons: [Pokemon] = []

        // 3. Crear un TaskGroup.
        // Se crea una Child Task por cada Pokémon.

        try await withThrowingTaskGroup(
            of: Pokemon.self
        ) { group in

            // 4. Recorrer los IDs.
            // Por cada ID se crea una Child Task.

            for id in ids {

                // 5. Crear una Child Task.
                // Cada Child Task descarga un Pokémon
                // de forma concurrente e independiente.

                group.addTask {

                    // Obtener el detalle del Pokémon.

                    let dto =
                        try await self.pokemonRemoteDataSource.fetchPokemon(
                            id: id
                        )

                    // Convertir DTO -> Entity.
                    // Cada Child Task devuelve directamente
                    // una entidad Pokemon.

                    return await dto.toListDomain()
                }
            }

            // 6. Recibir los resultados conforme las Child Tasks
            // van terminando.
            // Solo la Task Principal modifica el arreglo final.

            for try await pokemon in group {

                pokemons.append(pokemon)
            }
        }

        // 7. Como TaskGroup devuelve resultados conforme terminan,
        // el orden puede variar.
        // Se ordena por ID para mantener el orden de la Pokédex.

        pokemons.sort { firstPokemon, secondPokemon in

            firstPokemon.id < secondPokemon.id
        }

        // 8. Retornar la lista final.

        return pokemons
    }
}
