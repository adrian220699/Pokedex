//
//  BerryDetailViewModel.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 6/24/26.
//

import Foundation

final class BerryDetailViewModel {
    
    //MARK: - UseCase
    
    private let getBerryUseCase : GetBerryUseCase
    
    //MARK: - State
    
    var state: ViewState <Berry> = .idle
    
    //MARK: - Init
    
    init(getBerryUseCase: GetBerryUseCase) {
        self.getBerryUseCase = getBerryUseCase
    }
    
    //MARK: - Load Berry
    
    func loadBerry(id : Int) async {
        state = .loading
        
        do {
            
            let berry = try await getBerryUseCase.execute(id: id)
            state = .success(berry)
            
        } catch {
            
            state = .error(error)
        }
        
    }
}
