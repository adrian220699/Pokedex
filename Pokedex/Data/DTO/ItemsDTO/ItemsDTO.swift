//
//  ItemDTO.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/16/26.
//

struct ItemsDTO : Decodable {
    
    let count : Int
    let next : String?
    let results : [ItemsListDTO]
    
}
