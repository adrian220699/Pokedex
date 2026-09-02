//
//  ItemsDetailDTO.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/16/26.
//

struct ItemsDetailDTO : Decodable {
    
    let category : CategoryNameDTO
    let cost : Int
    let flavorTextEntries : [FlavorDescriptionDTO]?
    let name : String
    let sprites : SpriteItemsDTO?
    let id : Int
    
    enum CodingKeys: String, CodingKey {
        case category
        case cost
        case flavorTextEntries = "flavor_text_entries"
        case name
        case sprites
        case id
    }
    
}
