//
//  ItemsRepositoryImpl.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/16/26.
//

import Foundation

final class ItemsRepositoryImpl: ItemsRepository {
    
    private let remoteDataSource: ItemsRemoteDataSource
    private let cache: ItemCache
    
    
    init(remoteDataSource: ItemsRemoteDataSource, cache : ItemCache) {
        self.remoteDataSource = remoteDataSource
        self.cache = cache
        print("ItemsRepository creado")
    }
    
 
    func getItem(id: Int) async throws -> Item {

        // 1. Iniciar el flujo de obtención del Item.
        // Este mensaje nos permite saber cuántas veces
        // se invoca el Repository.

        print("getItem(id: \(id))")

        // 2. Revisar si el Item ya existe en el cache.
        // Si existe, no es necesario realizar una petición
        // a la API y se retorna inmediatamente.

        if let cachedItem = await cache.item(for: id) {

            print("Cache HIT -> \(cachedItem.name)")

            return cachedItem
        }

        print("Cache MISS -> \(id)")

        // 3. Obtener el detalle completo del Item.
        // En este caso solo es necesaria una petición,
        // por lo que no se utiliza `async let`.

        print("Iniciando petición al servidor")

        let dto =
            try await remoteDataSource.fetchItem(
                id: id
            )

        print("Petición finalizada.")

        // 4. Convertir el DTO a la entidad del dominio.
        // El Mapper transforma el modelo de la API
        // en una entidad utilizada por la aplicación.

        let item =
            dto.toDetailDomain()

        print("Mapper completado -> \(item.name)")

        // 5. Guardar el Item completo en el cache.
        // Así, futuras consultas evitarán realizar
        // nuevamente la petición a la API.

        await cache.save(item)

        print("Item guardado en cache -> \(item.name)")

        // 6. Retornar la entidad lista para la capa
        // de dominio.

        print("Retornando Item -> \(item.name)")

        return item
    }
    
    
    // MARK: - Item List

    func getItems(
        limit: Int,
        offset: Int
    ) async throws -> [Item] {

        // 1. Obtener la lista básica paginada.
        // Esta petición únicamente devuelve el nombre y la URL
        // de cada Item.

        let dto =
            try await remoteDataSource.fetchItems(
                limit: limit,
                offset: offset
            )

        // 2. Arreglo que almacenará las entidades finales.
        
        

        var itemsList: [Item] = []

        // 3. Crear un TaskGroup.
        // Se utiliza porque el número de Child Tasks depende
        // de la cantidad de Items recibidos por la API.

        try await withThrowingTaskGroup(
            of: Item.self
        ) { group in

            // 4. Recorrer la lista obtenida.
            // Por cada Item se crea una Child Task.

            for itemDTO in dto.results {

                // Extraer el ID desde la URL.
                // Si no es posible obtenerlo, se ignora el elemento.

                guard extractItemId(
                    from: itemDTO.url
                ) != nil
                else {
                    continue
                }

                // 5. Crear una Child Task.
                // Cada Child Task descarga un Item
                // de forma concurrente e independiente.

                group.addTask {

                    // Obtener el detalle del Item.

                    let itemDetailDTO =
                        try await self.remoteDataSource.fetchItemsDetails(
                            url: itemDTO.url
                        )

                    // Convertir DTO -> Entity.
                    // Cada Child Task devuelve directamente
                    // una entidad Item.

                    return await itemDetailDTO.toListDomain()
                }
            }

            // 6. Recibir los resultados conforme las Child Tasks
            // van terminando.
            // Solo la Task Principal modifica el arreglo final.

            for try await item in group {

                itemsList.append(item)
            }
        }

        // 7. Como TaskGroup devuelve resultados conforme terminan,
        // el orden puede variar.
        // Se ordena por ID para mantener el orden de los Items.

        itemsList.sort { firstItem, secondItem in

            firstItem.id < secondItem.id
        }

        // 8. Retornar la lista final.

        return itemsList
    }
    
    //MARK: - Helpers
    
    private func extractItemId(from url : String) -> Int? {
        
        let components = url.components(separatedBy: "/")
        
        for component in components.reversed() {
            
            if component.isEmpty { continue }
            
            if let id = Int(component) { return id}
        }
        
        return nil
        
    }
}
