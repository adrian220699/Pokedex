//
//  Untitled.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/15/26.
//

struct BerrySpriteDTO: Decodable {
    
    let defaultFront: String?  // nombre seguro en Swift
    
    enum CodingKeys: String, CodingKey {
        case defaultFront = "default"
    }
}
