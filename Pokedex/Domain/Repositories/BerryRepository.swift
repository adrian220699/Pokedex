//
//  BerryRepository.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/15/26.
//

protocol BerryRepository {
    func getBerries(limit: Int, offset: Int) async throws -> [Berry]
    func getBerry(id : Int) async throws -> Berry

}
