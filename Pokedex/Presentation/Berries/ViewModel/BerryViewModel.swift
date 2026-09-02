//
//  BerryViewModel.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/15/26.
//

@MainActor
final class BerryViewModel {
    
    // MARK: - Use Cases

    private let getBerriesUseCase : GetBerriesUseCase
    
    // MARK: - State
    
    var state:
        ViewState<[Berry]> = .idle
    
    
    // MARK: - Pagination

    private var offset = 0

    private let limit = 20

    private var isLoading = false

    private var totalBerries = 60

    private var hasMorePages = true

    var canLoadMore: Bool {
        hasMorePages
    }
    
    private var allBerries: [Berry] = []

    
    //MARK: - Init
    
    init (getBerriesUseCase : GetBerriesUseCase) {
        
        self.getBerriesUseCase = getBerriesUseCase
    }
    
    // MARK: - Load Berries 
    
    func loadBerries() async {

        guard !isLoading else { return }

        isLoading = true

        defer {
            isLoading = false
        }

        // Reiniciar el estado de la paginación.

        offset = 0

        hasMorePages = true

        allBerries = []

        state = .loading

        do {

            let berries =
                try await getBerriesUseCase.execute(
                    limit: limit,
                    offset: offset
                )

            allBerries = berries

            state = .success(berries)

        } catch {

            state = .error(error)
        }
    }
    
    //MARK: - Next Page
    
    func loadMoreBerries() async {

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

            let newBerries =
                try await getBerriesUseCase.execute(
                    limit: limit,
                    offset: offset
                )

            if newBerries.isEmpty {

                hasMorePages = false
                
                return
            }

            allBerries.append(
                contentsOf: newBerries
            )

            if allBerries.count >= totalBerries {

                hasMorePages = false

                print("END OF BERRIES")
            }

            state = .success(
                allBerries
            )

        } catch {

            state = .error(error)
        }

    }
    
}
