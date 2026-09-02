//
//  CharacteristicDTO.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/13/26.
//

struct CharacteristicDTO : Decodable {
    
    let descriptions : [DescriptionDTO]
    let gene_modulo : Int
    let highest_stat : HighestStatDTO
    let id : Int
    let possible_values : [Int]
}
