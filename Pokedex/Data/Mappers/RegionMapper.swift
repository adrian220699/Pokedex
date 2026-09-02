//
//  RegionMapper.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/18/26.
//

extension RegionDTO {
        
    
    //MARK: - Region List
    
    func toDomain() -> Region {
        
        let regionName = name
        let randomSprite = RegionInitials.randomSpriteURL(for: regionName)

        return Region(
            id: id,
            name: regionName,
            sprite: randomSprite,
            pokemon: []
        )
    }
}
