//
//  BerryRepository.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/15/26.
//

import Foundation

final class BerryRepositoryImpl : BerryRepository {
    
    private let remoteDataSource : BerryRemoteDataSource
    private let cache: BerryCache

    
    init(remoteDataSource: BerryRemoteDataSource, cache: BerryCache) {
        self.remoteDataSource = remoteDataSource
        self.cache = cache
        print("BerryRepository creado")

    }
    // MARK: - Single Berry

    func getBerry(id: Int) async throws -> Berry {

        // 1. Iniciar el flujo de obtención del Berry.
        // Este mensaje nos permite saber cuántas veces
        // se invoca el Repository.

        print("getBerry(id: \(id))")

        // 2. Revisar si el Berry ya existe en el cache.
        // Si existe, no es necesario realizar peticiones
        // a la API y se retorna inmediatamente.

        if let cachedBerry = await cache.berry(for: id) {

            print("Cache HIT -> \(cachedBerry.name)")

            return cachedBerry
        }

        print("Cache MISS -> \(id)")

        // 3. Obtener toda la información necesaria del Berry.
        // En este caso son necesarias dos peticiones
        // secuenciales:
        // - Obtener el Berry.
        // - Obtener el detalle del Item asociado.
        //
        // No se utiliza `async let` porque la segunda petición
        // depende del resultado de la primera.

        print("Iniciando peticiones al servidor...")

        let berryDTO =
            try await remoteDataSource.fetchBerry(
                id: id
            )

        let itemDetailDTO =
            try await remoteDataSource.fetchItemDetail(
                urlString: berryDTO.item.url
            )

        print("Todas las peticiones finalizaron.")

        // 4. Convertir los DTO a la entidad del dominio.
        // El Mapper transforma los modelos obtenidos de la API
        // en una entidad utilizada por la aplicación.

        let berry =
            berryDTO.toDetailDomain(
                itemDetail: itemDetailDTO
            )

        print("Mapper completado -> \(berry.name)")

        // 5. Guardar el Berry completo en el cache.
        // Así, futuras consultas evitarán realizar
        // nuevamente las peticiones a la API.

        await cache.save(berry)

        print("Berry guardado en cache -> \(berry.name)")

        // 6. Retornar la entidad lista para la capa
        // de dominio.

        print("Retornando Berry -> \(berry.name)")

        return berry
    }
    
    // MARK: - Berry List

    func getBerries(
        limit: Int,
        offset: Int
    ) async throws -> [Berry] {

        // 1. Obtener la lista básica paginada.
        // Esta petición únicamente devuelve el nombre y la URL
        // de cada Berry.

        let dto =
            try await remoteDataSource.fetchBerries(
                limit: limit,
                offset: offset
            )

        // 2. Arreglo que almacenará las entidades finales.

        var berriesList: [Berry] = []

        // 3. Crear un TaskGroup.
        // Se utiliza porque el número de Child Tasks depende
        // de la cantidad de Berries recibidas por la API.

        try await withThrowingTaskGroup(
            of: Berry.self
        ) { group in

            // 4. Recorrer la lista obtenida.
            // Por cada Berry se crea una Child Task.

            for berryDTO in dto.results {

                // Extraer el ID desde la URL.
                // Si no es posible obtenerlo, se ignora el elemento.

                guard let id =
                    extractBerryId(
                        from: berryDTO.url
                    )
                else {
                    continue
                }

                // 5. Crear una Child Task.
                // Cada Child Task descarga una Berry
                // de forma concurrente e independiente.

                group.addTask {

                    // Obtener el detalle de la Berry.

                    let berryDetailDTO =
                        try await self.remoteDataSource.fetchBerry(
                            id: id
                        )

                    // Obtener el Item asociado.
                    // Se utiliza para recuperar la imagen de la Berry.

                    let itemDetailDTO =
                        try await self.remoteDataSource.fetchItemDetail(
                            urlString: berryDetailDTO.item.url
                        )

                    // Convertir DTO -> Entity.
                    // Cada Child Task devuelve directamente
                    // una entidad Berry.

                    return await berryDetailDTO.toListDomain(
                        itemDetail: itemDetailDTO
                    )
                }
            }

            // 6. Recibir los resultados conforme las Child Tasks
            // van terminando.
            // Solo la Task Principal modifica el arreglo final.

            for try await berry in group {

                berriesList.append(berry)
            }
        }

        // 7. Como TaskGroup devuelve resultados conforme terminan,
        // el orden puede variar.
        // Se ordena por ID para mantener el orden de las Berries.

        berriesList.sort { firstBerry, secondBerry in

            firstBerry.id < secondBerry.id
        }

        // 8. Retornar la lista final.

        return berriesList
    }
    
    private func extractBerryId(from url : String) -> Int? {
        
        // Separar URL usando /
        
        let separatedURL =
        url.components(separatedBy: "/")
        
        // Recorrer elementos al revés

        for component in separatedURL.reversed() {
            
            // Ignorar Strings Vacios
            
            if component.isEmpty {
                
                continue
            }
            
            // Intentar convertir a INT
            
            if let berryId = Int(component) {
                
            // Retornar ID
                
                return berryId
                
                
            }
        }
        
        // Si no lo encuentra
        
        return nil
    }
}

