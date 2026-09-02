//
//  BerryMapper.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/15/26.
//

extension BerryDTO {
    
    
    func toListDomain(itemDetail : ItemDetailDTO) -> Berry {
        
        // Sprite de la berry
        
        let imgBerry = itemDetail.sprites?.defaultFront ?? ""
        
        let berry = Berry (
            
            id : id,
            name: name,
            flavor: [],
            image: imgBerry,
            description: "",
            category: ""
        )
        
        return berry
        
        
        
    }
    
    func toDetailDomain(itemDetail : ItemDetailDTO) -> Berry {
        
        let flavorName = flavors.filter { FlavorDTO in
            
            FlavorDTO.potency > 0
        }
        
            .map { FlavorDTO in
                FlavorDTO.flavor.name
            }
        
        // Sprite de la berry
        
        let imgBerry = itemDetail.sprites?.defaultFront ?? ""
        
        // Description
        
        let descriptionBerry = itemDetail.flavorTextEntries?.first { entry in
            
            entry.language.name == "es"
            
        }?.text ?? ""
        
        let categoryBerry = itemDetail.category.name

    
        let berry = Berry (
            
            id : id,
            name: name,
            flavor: flavorName,
            image: imgBerry,
            description: descriptionBerry,
            category: categoryBerry
        )
        
        return berry
    }
}
