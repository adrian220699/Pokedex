//
//  GetRegionsUseCase.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/21/26.
//

final class GetRegionsUseCase {
    
    private let repository: RegionRepository

    init(repository: RegionRepository) {
        self.repository = repository
    }

    func execute(ids: [Int]) async throws -> [Region] {
        return try await repository.getRegions(ids: ids)
    }
}
