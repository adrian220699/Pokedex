//
//  ItemCache.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 7/7/26.
//

import Foundation

actor ItemCache {

    // MARK: - Init

      init() {

          print("Item Cache creado")

      }
    
    // MARK: - Storage

    private var items: [Int: Item] = [:]

    // MARK: - Get Item

    func item(for id: Int) -> Item? {

        // Revisar si el Item existe dentro del Dictionary.

        if let item = items[id] {

            print("Cache contiene -> \(item.name)")

            return item
        }

        print("Cache vacío para id -> \(id)")

        return nil
    }

    // MARK: - Save Item

    func save(_ item: Item) {

        // Guardar o reemplazar el Item utilizando
        // su ID como llave del Dictionary.

        print("Guardando en cache -> \(item.name)")

        items[item.id] = item
    }
}
