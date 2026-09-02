
//
//  final class PokemonByRegionViewModel { .swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 6/16/26.
//

import Foundation

final class PokemonByRegionViewModel {

    // MARK: - UseCase

    private let useCase: GetPokemonsByRegionUseCase

    // MARK: - Region

    private let range: ClosedRange<Int>

    // MARK: - State

    var state: ViewState<[Pokemon]> = .idle

    // MARK: - Pagination

    private var offset = 0

    private let limit = 20

    private var isLoading = false

    private var hasMorePages = true

    private var allPokemons: [Pokemon] = []

    // MARK: - Public

    var canLoadMore: Bool {
        hasMorePages
    }

    // MARK: - Init

    init(
        range: ClosedRange<Int>,
        useCase: GetPokemonsByRegionUseCase
    ) {

        self.range = range
        self.useCase = useCase
    }

    // MARK: - First Load

    func loadPokemons() async {

        guard !isLoading else { return }

        isLoading = true

        offset = 0

        hasMorePages = true

        allPokemons = []

        state = .loading

        do {

            let pokemons =
                try await useCase.execute(
                    range: range,
                    limit: limit,
                    offset: offset
                )

            allPokemons = pokemons

            if pokemons.count < limit {

                hasMorePages = false
            }

            state = .success(allPokemons)

        } catch {

            state = .error(error)
        }

        isLoading = false
    }

    // MARK: - Pagination

    func loadMorePokemons() async {

        guard hasMorePages else {

            print("🏁 NO MORE PAGES")

            return
        }

        guard !isLoading else { return }

        isLoading = true

        offset += limit

        do {

            let newPokemons =
                try await useCase.execute(
                    range: range,
                    limit: limit,
                    offset: offset
                )

            if newPokemons.isEmpty {

                hasMorePages = false

                print("🏁 END OF POKEDEX")

                isLoading = false

                return
            }

            allPokemons.append(
                contentsOf: newPokemons
            )

            // Última página

            if newPokemons.count < limit {

                hasMorePages = false

                print("🏁 LAST PAGE")
            }

            state = .success(
                allPokemons
            )

        } catch {

            state = .error(error)
        }

        isLoading = false
    }
}
