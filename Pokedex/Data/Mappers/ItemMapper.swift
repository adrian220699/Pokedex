//
//  ItemMapper.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/16/26.
//

extension ItemsDetailDTO {
    
    func toListDomain() -> Item {
        
        let imgItem = sprites?.itemSprite ?? ""
        
        
        return Item(
            
            id : id,
            name: name,
            description : "",
            image : imgItem,
            category: "",
            price: 0,
        )
    }
    
    func toDetailDomain() -> Item {
        
        // Tomar la description en español o en ingles
        
        let descriptionItem = flavorTextEntries?.first { entry in
                   entry.language.name == "es"
               }?.text ??
        flavorTextEntries?.first { entry in
                   entry.language.name == "en"
               }?.text ?? ""
        
        let imgItem = sprites?.itemSprite ?? ""
        
        let price = prices.first?.sellPrice ?? 0
        
        return Item(
            id: id,
            name: name,
            description: descriptionItem,
            image: imgItem,
            category: category.name,
            price: price
        )
        
    }
    
}
