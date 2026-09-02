//
//  BerryListDTO.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/15/26.
//

struct BerryListDTO : Decodable {
    
    let count : Int
    let next : String?
    let previous : String?
    let results : [BerryResultsDTO]
    
    
}
