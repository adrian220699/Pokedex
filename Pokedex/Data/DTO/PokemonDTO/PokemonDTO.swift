//
//  PokemonDTO.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/12/26.
//


struct PokemonDTO : Decodable {
    
    let id : Int
    let name : String
    let types : [PokemonTypeDTO]
    let sprites: SpriteDTO
    let moves : [MoveDTO]

    
}
