//
//  SpriteItemsDTO.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/16/26.
//

struct SpriteItemsDTO : Decodable {
    
    let itemSprite : String?
    
    enum CodingKeys: String, CodingKey {
        case itemSprite = "default"
    }
    
}
