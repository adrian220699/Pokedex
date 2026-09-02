//
//  PokemonRegionViewModel.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/18/26.
//

@MainActor
final class PokemonRegionViewModel {

    // MARK: - Use Cases

    private let getPokemonRegionsUseCase: GetRegionsUseCase

    // MARK: - State

    var state: ViewState<[Region]> = .idle

    // MARK: - Loading

    private var isLoading = false

    // MARK: - Init

    init(
        getPokemonRegionsUseCase: GetRegionsUseCase
    ) {
        self.getPokemonRegionsUseCase = getPokemonRegionsUseCase
    }

    // MARK: - Load Regions

    func loadRegions() async {

        guard !isLoading else { return }

        isLoading = true

        defer {
            isLoading = false
        }

        state = .loading

        do {

            let regions =
                try await getPokemonRegionsUseCase.execute(
                    ids: Array(1...10)
                )

            state = .success(regions)

        } catch {

            state = .error(error)
        }
    }
}
