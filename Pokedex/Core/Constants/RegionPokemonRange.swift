//
//  RegionPokemonRange.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 6/16/26.
//

import Foundation

enum RegionPokemonRange {
    
    // Retorna el rango de la pokedex por region y los pokemon por regionx

    static func range(for regionName: String) -> ClosedRange<Int>? {

        switch regionName.lowercased() {
            
        case "kanto":
            return 1...151
            
        case "johto":
            return 152...251
            
        case "hoenn":
            return 252...386
            
        case "sinnoh":
            return 387...494
            
        case "unova":
            return 495...649
            
        case "kalos":
            return 650...721
            
        case "alola":
            return 722...809
            
        case "galar":
            return 810...905
            
        case "hisui":
            return 387...493

        case "paldea":
            return 906...1025

        default:
            return nil
            
        }
    }
}

