//
//  BerryCache.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 7/7/26.
//

import Foundation

actor BerryCache {

    // MARK: - Init

      init() {

          print("BerryCache creado")

      }
    
    // MARK: - Storage

    private var berries: [Int: Berry] = [:]

    // MARK: - Get Berry

    func berry(for id: Int) -> Berry? {

        // Revisar si el Berry existe dentro del Dictionary.

        if let berry = berries[id] {

            print("Cache contiene -> \(berry.name)")

            return berry
        }

        print("Cache vacío para id -> \(id)")

        return nil
    }

    // MARK: - Save Berry

    func save(_ berry: Berry) {

        // Guardar o reemplazar el Pokémon utilizando
        // su ID como llave del Dictionary.

        print("Guardando en cache -> \(berry.name)")

        berries[berry.id] = berry
    }
}
