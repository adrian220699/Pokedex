//
//  ItemPrice.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 9/4/26.
//

struct ItemPrice : Decodable {
    
    let sellPrice: Int
    
    enum CodingKeys: String, CodingKey {
        
        
        case sellPrice = "sell_price"
    }
}
