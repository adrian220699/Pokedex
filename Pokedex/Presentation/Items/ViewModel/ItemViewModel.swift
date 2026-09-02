//
//  ItemViewModel.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/16/26.
//
@MainActor
final class ItemsViewModel {
    
    // MARK: - Use Cases
    
    private let getItemsUseCase: GetItemsUseCase
    
    //MARK: - Pagination
    
    private var offset = 0
    
    private let limit = 20
    
    private var isLoading = false
    
    private var totalItems = 120
    
    private var hasMorePages = true
    
    private var allItems : [Item] = []
    
    var canLoadMore: Bool {
        hasMorePages
    }
    
    //MARK: - State
    
    var state:
        ViewState<[Item]> = .idle

    //MARK: - Init
    
    init(getItemsUseCase: GetItemsUseCase) {
        self.getItemsUseCase = getItemsUseCase
    }
    
    // MARK: - Load Items
    
    func loadItems() async {
        
        guard !isLoading else {return}
        
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        // Reiniciar el estado de la paginación
        
        offset = 0
        
        allItems = []
        
        hasMorePages = true
        
        state = .loading
        
        do {
            
            let items = try await getItemsUseCase.execute(
                limit: limit,
                offset: offset)
            
            allItems = items
            
            state = .success(items)
            
        } catch {
            
            state = .error(error)
            
        }
                
    }
    
    //MARK: - Next Page

    func loadMoreItems () async {
        
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

            let newItems =
                try await getItemsUseCase.execute(
                    limit: limit,
                    offset: offset
                )

            if newItems.isEmpty {

                hasMorePages = false

                return
            }

            allItems.append(
                contentsOf: newItems
            )

            if allItems.count >= totalItems {

                hasMorePages = false

                print("END OF ITEMS")
            }

            state = .success(
                allItems
            )

        } catch {

            state = .error(error)
        }
    }
}
