//
//  DependencyContainer.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/22/26.
//

import UIKit

final class DependencyContainer {
    
    // MARK: - Init

      init() {

          print("DependencyContainer creado")

      }
    
    //MARK: - Shared Dependencies
    
    private let pokemonCache = PokemonCache()
    private let itemCache = ItemCache()
    private let berryCache = BerryCache()
    
    //MARK: - Pokemon Module
    
    func makePokemonViewController() -> PokemonViewController {
        
        // DataSource
        
        let remoteDataSource = PokemonRemoteDataSource()
        
        // Repository
        
        let repository =
            PokemonRepositoryImpl(
                
                remoteDataSource: remoteDataSource,
                cache : pokemonCache
                
            )
        
        // Use Cases
        
        let getPokemonsUseCase =
            GetPokemonsUseCase(
                repository: repository
            )
        
        // ViewModel
        
        let viewModel =
            PokemonViewModel(
                getPokemonsUseCase: getPokemonsUseCase
            )
        
        // ViewController
        
        return PokemonViewController(
            viewModel: viewModel,
            dependencyContainer: self
        )
        
    }
    
    
    //MARK: - Pokemon Detail
    
    func makePokemonDetailViewController(pokemonId : Int) -> PokemonDetailViewController {
        
        // DataSource
        
        let remoteDataSource = PokemonRemoteDataSource()
        
        // Repository
        
        let repository = PokemonRepositoryImpl(remoteDataSource: remoteDataSource, cache: pokemonCache)
        
        // Uses Cases
        
       let useCase = GetPokemonUseCase(repository: repository )
        
        // View Model
        
        let viewModel = PokemonDetailViewModel(getPokemonUseCase: useCase)
        
        // ViewController
        
        return PokemonDetailViewController(pokemonId: pokemonId , viewModel : viewModel)
    }
    
    // MARK: - Berry Module

    func makeBerryViewController()
    -> BerriesViewController {

        // DataSource

        let remoteDataSource =
            BerryRemoteDataSource()

        // Repository

        let repository =
            BerryRepositoryImpl(
                remoteDataSource: remoteDataSource, cache: berryCache
            )

        // UseCases

        let getBerriesUseCase =
            GetBerriesUseCase(
                repository: repository
            )

     
        // ViewModel

        let viewModel =
            BerryViewModel(
                getBerriesUseCase: getBerriesUseCase
    
            )

        // ViewController

        return BerriesViewController(
            viewModel: viewModel, dependencyContainer: self
        )
    }
    
    //MARK: - Berry Detail
    
    func makeBerryDetailViewController(berryId : Int) -> BerryDetailViewController {
        
        // DataSource
        
        let remoteDataSource = BerryRemoteDataSource()
        
        // Repository
        
        let repository = BerryRepositoryImpl(remoteDataSource: remoteDataSource, cache: berryCache)
        
        // Uses Cases
        
       let useCase = GetBerryUseCase(repository: repository )
        
        // View Model
        
        let viewModel = BerryDetailViewModel(getBerryUseCase: useCase)
        
        // ViewController
        
        return BerryDetailViewController(berryId: berryId , viewModel : viewModel)
    }
    
    
    //MARK: - Item Module
    
    func makeItemViewController()
    -> ItemsViewController {

        // DataSource

        let remoteDataSource =
            ItemsRemoteDataSource()

        // Repository

        let repository =
            ItemsRepositoryImpl(
                remoteDataSource: remoteDataSource, cache: itemCache
            )

        // UseCases
        
        let getItemsUseCase =
            GetItemsUseCase(
                repository: repository
            )
        
        // ViewModel

        let viewModel =
            ItemsViewModel(
                getItemsUseCase: getItemsUseCase,
    
            )

        // ViewController

        return ItemsViewController(
            viewModel: viewModel, dependencyContainer: self
        )
    }
    
    //MARK: - Item Detail
    
    func makeItemDetailViewController(itemId : Int) -> ItemsDetailViewController {
        
        // DataSource
        
        let remoteDataSource = ItemsRemoteDataSource()
        
        // Repository
        
        let repository = ItemsRepositoryImpl(remoteDataSource: remoteDataSource, cache: itemCache)
        
        // Uses Cases
        
       let useCase = GetItemUseCase(repository: repository )
        
        // View Model
        
        let viewModel = ItemDetailViewModel(getItemUseCase: useCase)
        
        // ViewController
        
        return ItemsDetailViewController(itemId: itemId, viewModel : viewModel)
    }
    
    
    //MARK: - Region Module
    
    func makeRegionViewController()
    -> RegionsViewController {

        // DataSource

        let remoteDataSourceRegion =
            RegionRemoteDataSource()
        
        let remoteDataSourcePokemon = PokemonRemoteDataSource()

        // Repository

        let repository =
        RegionPokemonListImpl(remoteDataSource: remoteDataSourceRegion, pokemonRemoteDataSource: remoteDataSourcePokemon)

        // UseCases
        
        let getPokemonRegionsUseCase =
            GetRegionsUseCase(
                repository: repository
            )
        
        // ViewModel

        let viewModel =
            PokemonRegionViewModel(
                getPokemonRegionsUseCase: getPokemonRegionsUseCase,
    
            )

        // ViewController

        return RegionsViewController(
            viewModel: viewModel, dependencyContainer: self
        )
    }
    
    
    func makePokemonByRegionViewController(regionName: String, range: ClosedRange<Int>) -> PokemonByRegionViewController {
        
        // DataSource

        let remoteDataSource = RegionRemoteDataSource()
        
        let remoteDataSourcePokemon = PokemonRemoteDataSource()
        
        // Repository
        
        let repository = RegionPokemonListImpl(remoteDataSource: remoteDataSource, pokemonRemoteDataSource: remoteDataSourcePokemon)
        
        // Uses Cases
        
        let getPokemonByRegionUseCase = GetPokemonsByRegionUseCase(repository: repository)
        
        // ViewModel
        
        let viewModel  = PokemonByRegionViewModel(range: range, useCase: getPokemonByRegionUseCase)
        
        return PokemonByRegionViewController(viewModel: viewModel, dependencyContainer: self, regionName: regionName)
        
    }
}
