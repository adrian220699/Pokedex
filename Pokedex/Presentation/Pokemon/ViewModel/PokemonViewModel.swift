//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/12/26.
//
@MainActor
final class PokemonViewModel {
    
    // MARK: - UseCases
    
    private let getPokemonsUseCase: GetPokemonsUseCase
    
    // MARK: - State
    
    var state : ViewState<[Pokemon]> = .idle
    
    // MARK: - Pagination

    private var offset = 0

    private let limit = 20

    private var isLoading = false

    private var totalPokemons = 1000

    private var hasMorePages = true

    var canLoadMore: Bool {
        hasMorePages
    }

    private var allPokemons: [Pokemon] = []
    
    // MARK: - Init
    
    init(
        getPokemonsUseCase: GetPokemonsUseCase
    ) {
        
        self.getPokemonsUseCase = getPokemonsUseCase
    }
    

    // MARK: - First Load

    func loadPokemons() async {
        
        guard !isLoading else {return}
        
        isLoading = true
            
        defer {
            isLoading = false
        }
        
        // Reiniciar el estado de la paginación.

        offset = 0
    
        hasMorePages = true
        
        allPokemons = []
        
        state = .loading
                
        do {
        
            let pokemons = try await getPokemonsUseCase.execute(
                limit: limit,
                offset: offset
            )
            
            allPokemons = pokemons
            
            state = .success(pokemons)

        } catch {
                
            state = .error(error)

        }
                
    }
    
    //MARK: - Next Page
    
    func loadMorePokemons() async {

        guard hasMorePages else {
            
            print("NO MORE PAGES")
          
            return

        }

        guard !isLoading else { return }

        isLoading = true
        
        defer {
            
            isLoading = false
        }

        offset += limit

        do {

            let newPokemons =
                try await getPokemonsUseCase.execute(
                    limit: limit,
                    offset: offset
                )

            if newPokemons.isEmpty {

                hasMorePages = false

                return
            }

            allPokemons.append(
                contentsOf: newPokemons
            )

            if allPokemons.count >= totalPokemons {

                hasMorePages = false

                print("END OF POKEDEX")
            }

            state = .success(
                allPokemons
            )

        } catch {

            state = .error(error)
        }

    }
}
