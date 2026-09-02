//
//  PokemonListDTO.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/12/26.
//


struct PokemonListDTO : Decodable {
    
    let count : Int
    let next  : String?
    let previous : String?
    let results : [PokemonResultDTO]
}
