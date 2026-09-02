//
//  PokemonTypeDTO.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/12/26.
//


struct PokemonTypeDTO : Decodable {
    
    let slot: Int
    let type : TypeInfoDTO
}
