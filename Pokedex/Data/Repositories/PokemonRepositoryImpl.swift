//
//  PokemonRepositoryImpl.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/12/26.
//
import Foundation

final class PokemonRepositoryImpl: PokemonRepository {

    // MARK: - Dependencies

    private let remoteDataSource: PokemonRemoteDataSource
    private let cache: PokemonCache

    init(
        remoteDataSource: PokemonRemoteDataSource,
        cache: PokemonCache
    ) {
        print("PokemonRepository creado")
        self.remoteDataSource = remoteDataSource
        self.cache = cache
    }

    // MARK: - Single Pokemon

    func getPokemon(id: Int) async throws -> Pokemon {

        // 1. Iniciar el flujo de obtención del Pokémon.
        // Este mensaje nos permite saber cuántas veces
        // se invoca el Repository.

        print("getPokemon(id: \(id))")

        // 2. Revisar si el Pokémon ya existe en el cache.
        // Si existe, no es necesario realizar peticiones a la API.

        if let cachedPokemon = await cache.pokemon(for: id) {

            print("Cache HIT -> \(cachedPokemon.name)")

            return cachedPokemon
        }

        print("Cache MISS -> \(id)")

        // 3. Iniciar las peticiones de forma concurrente.
        // Cada "async let" crea una Child Task que comienza
        // a ejecutarse inmediatamente.

        print("Iniciando peticiones concurrentes")

        async let pokemonTask =
            remoteDataSource.fetchPokemon(id: id)

        async let speciesTask =
            remoteDataSource.fetchPokemonSpecies(id: id)

        async let encountersTask =
            remoteDataSource.fetchPokemonEncounters(id: id)

        // 4. Esperar los resultados.
        // Si alguna Child Task aún no termina, la Task principal
        // se suspenderá hasta recibir todos los datos necesarios.

        let pokemonDTO = try await pokemonTask
        let speciesDTO = try await speciesTask
        let encountersDTO = try await encountersTask

        print("Todas las peticiones finalizaron.")

        // 5. Convertir los DTO a la entidad del dominio.
        // El Mapper solo se ejecuta cuando toda la información
        // necesaria ya fue obtenida.

        let pokemon =
            pokemonDTO.toDetailDomain(
                species: speciesDTO,
                encounters: encountersDTO
            )

        print("Mapper completado -> \(pokemon.name)")

        // 6. Guardar el Pokémon completo en el cache.
        // Así, futuras consultas evitarán realizar networking.

        await cache.save(pokemon)

        print("Pokémon guardado en cache -> \(pokemon.name)")

        // 7. Retornar la entidad lista para la capa de dominio.

        print("Retornando Pokémon -> \(pokemon.name)")

        return pokemon
    }
    
    // MARK: - Pokemon List

    func getPokemons(
        limit: Int,
        offset: Int
    ) async throws -> [Pokemon] {

        // 1. Obtener la lista básica paginada.
        // Esta petición únicamente devuelve el nombre y la URL
        // de cada Pokémon.

        let dto =
            try await remoteDataSource.fetchPokemons(
                limit: limit,
                offset: offset
            )

        // 2. Arreglo que almacenará las entidades finales.

        var pokemonList: [Pokemon] = []

        // 3. Crear un TaskGroup.
        // Se utiliza porque el número de Child Tasks depende
        // de la cantidad de Pokémon recibidos por la API.

        try await withThrowingTaskGroup(
            of: Pokemon.self
        ) { group in

            // 4. Recorrer la lista obtenida.
            // Por cada Pokémon se crea una Child Task.

            for pokemonDTO in dto.results {

                // Extraer el ID desde la URL.

                guard let id =
                    extractPokemonId(
                        from: pokemonDTO.url
                    )
                else {
                    continue
                }

                // 5. Crear una Child Task.
                // Cada una descarga un Pokémon de forma
                // concurrente e independiente.

                group.addTask {

                    // Obtener el detalle del Pokémon.

                    let pokemonDetailDTO =
                        try await self.remoteDataSource.fetchPokemon(
                            id: id
                        )

                    // Convertir DTO -> Entity.
                    // Cada Child Task devuelve directamente
                    // una entidad Pokemon.

                    return await pokemonDetailDTO.toListDomain()
                }
            }

            // 6. Recibir los resultados conforme las Child Tasks
            // van terminando.
            // Únicamente la Task principal modifica el arreglo.

            for try await pokemon in group {

                pokemonList.append(pokemon)
            }
        }

        // 7. TaskGroup devuelve resultados conforme terminan,
        // por lo que el orden puede variar.
        // Se ordena por ID para mantener el orden de la Pokédex.

        pokemonList.sort { firstPokemon, secondPokemon in

            firstPokemon.id < secondPokemon.id
        }

        // 8. Retornar la lista final.

        return pokemonList
    }

    // MARK: - Helpers

    private func extractPokemonId(from url: String) -> Int? {

        // 1. Separar la URL utilizando "/".

        let separatedURL =
            url.components(separatedBy: "/")

        // 2. Recorrer los componentes desde el final.

        for component in separatedURL.reversed() {

            // 3. Ignorar componentes vacíos.

            if component.isEmpty {
                continue
            }

            // 4. Intentar convertir el componente a Int.

            if let pokemonId = Int(component) {

                // 5. Retornar el ID encontrado.

                return pokemonId
            }
        }

        // 6. No se encontró un ID válido.

        return nil
    }
}
