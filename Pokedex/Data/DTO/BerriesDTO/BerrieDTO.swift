//
//  BerrieDTO.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/15/26.
//

struct BerryDTO: Decodable { 
    let firmness: FirmnessDTO
    let flavors: [BerryFlavorDTO]
    let growthTime: Int?
    let id: Int
    let item: ItemDTO
    let maxHarvest: Int?
    let name: String
    let naturalGiftPower: Int?
    let naturalGiftType: NaturalGiftTypeDTO?
    let size: Int?
    let smoothness: Int?
    let soilDryness: Int?
    
    enum CodingKeys: String, CodingKey {
        case firmness
        case flavors
        case growthTime = "growth_time"
        case id
        case item
        case maxHarvest = "max_harvest"
        case name
        case naturalGiftPower = "natural_gift_power"
        case naturalGiftType = "natural_gift_type"
        case size
        case smoothness
        case soilDryness = "soil_dryness"
    }
}
