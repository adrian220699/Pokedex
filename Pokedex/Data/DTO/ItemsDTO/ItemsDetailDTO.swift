//
//  ItemsDetailDTO.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/16/26.
//

struct ItemsDetailDTO : Decodable {
    
    let category : CategoryNameDTO
    let prices : [ItemPrice]
    let flavorTextEntries : [FlavorDescriptionDTO]?
    let name : String
    let sprites : SpriteItemsDTO?
    let id : Int
    
    enum CodingKeys: String, CodingKey {
        case category
        case prices
        case flavorTextEntries = "flavor_text_entries"
        case name
        case sprites
        case id
    }
    
}
