//
//  ItemDetailDTO.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/15/26.
//

struct ItemDetailDTO : Decodable {
    
    let name : String
    let sprites : BerrySpriteDTO?
    let flavorTextEntries : [BerryLanguageDTO]?
    let category : CategoryDTO
    
    enum CodingKeys: String, CodingKey {
        case name
        case sprites
        case flavorTextEntries = "flavor_text_entries"
        case category
    }
    
}
