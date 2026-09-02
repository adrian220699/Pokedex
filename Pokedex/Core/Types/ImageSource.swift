//
//  ImageSource.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 7/7/26.
//

enum ImageSource {

    case pokemon
    case berry
    case item
    case region

    var description: String {

        switch self {

        case .pokemon:
            return "Pokemon"

        case .berry:
            return "Berry"

        case .item:
            return "Item"

        case .region:
            return "Region"

        }
    }
}
