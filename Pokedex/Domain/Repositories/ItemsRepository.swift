//
//  ItemsRepository.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/16/26.
//


protocol ItemsRepository {
    
    func getItems(limit: Int, offset: Int) async throws -> [Item]
    func getItem(id : Int) async throws -> Item
}
