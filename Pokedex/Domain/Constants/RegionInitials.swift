//
//  RegionInitials.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/20/26.
//

struct RegionInitials {
    static let initialsRegion: [String: [Int]] = [
        "kanto"  : [1, 4, 7],
        "johto"  : [152, 155, 158],
        "hoenn"  : [252, 255, 258],
        "sinnoh" : [387, 390, 393],
        "unova"  : [495, 498, 501],
        "kalos"  : [650, 653, 656],
        "alola"  : [722, 725, 728],
        "galar"  : [810, 813, 816],
        "hisui"  : [387, 155, 501],
        "paldea" : [906, 909, 912]
    ]

    static func ids(for region: String) -> [Int] {
        return initialsRegion[region.lowercased()] ?? []
    }

    static func randomID(for region: String) -> Int? {
        return ids(for: region).randomElement()
    }

    static func randomSpriteURL(for region: String) -> String? {
        guard let id = randomID(for: region) else { return nil }
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}
