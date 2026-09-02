//
//  RegionRepository.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/18/26.
//

protocol RegionRepository {
    func getRegions(ids: [Int]) async throws -> [Region]
    func getPokemonsByRegion(range: ClosedRange<Int>, limit: Int, offset: Int) async throws -> [Pokemon]
}
