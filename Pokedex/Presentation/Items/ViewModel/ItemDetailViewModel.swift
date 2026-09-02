//
//  ItemDetailViewModel.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 6/24/26.
//

import Foundation

final class ItemDetailViewModel {
    
    //MARK: - UseCase
    
    private let getItemUseCase : GetItemUseCase
    
    //MARK: - State
    
    var state: ViewState <Item> = .idle
    
    //MARK: - Init
    
    init(getItemUseCase: GetItemUseCase) {
        self.getItemUseCase = getItemUseCase
    }
    
    //MARK: - Load Item
    
    func loadItem(id : Int) async {
        state = .loading
        
        do {
            
            let item = try await getItemUseCase.execute(id: id)
            state = .success(item)
            
        } catch {
            
            state = .error(error)
        }
        
    }
}
