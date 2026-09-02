//
//  SpriteDTO.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/12/26.
//

struct SpriteDTO: Decodable {

    let frontDefault: String?
    let frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}
