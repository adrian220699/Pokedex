//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/12/26.
//

import UIKit

final class PokemonViewController : UIViewController {
    
    //MARK: - Properties
    
    private let viewModel : PokemonViewModel
    private let tableView = UITableView()
    private let dependencyContainer : DependencyContainer
    
    //MARK: - UI State Data
    
    private var pokemons: [Pokemon] = []

    
    //MARK: - Init
    
    init(viewModel: PokemonViewModel, dependencyContainer: DependencyContainer) {
        
        self.viewModel = viewModel
        self.dependencyContainer = dependencyContainer
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Pokemon"
        setupTableView()
        loadPokemons()
       
    }
    
    
    //MARK: - Setup TableView
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(
            PokemonTableViewCell.self,
            forCellReuseIdentifier: PokemonTableViewCell.identifier
            
        )
        
        tableView.rowHeight = UIConstants.defaultRowHeight 
        
    }
    
    //MARK: - Load Pokemons
    
    private func loadPokemons() {
    
        Task {

            // LOADING STATE

            viewModel.state = .loading

            render()

            // FETCH DATA

            await viewModel.loadPokemons()

            // SUCCESS / ERROR

            render()
        }
        
    }
    
    // MARK: - Render State
    
    private func render() {

        switch viewModel.state {

        case .idle:
            print("Idle")


            break

        case .loading:

            print("Loading Pokemons")

        case .success(let pokemons):
            
            print("Success Pokemon")


            self.pokemons = pokemons

            tableView.reloadData()

        case .error(let error):

            showError(
                message:
                    error.localizedDescription
            )
        }
    }

    //MARK: - Show Error
    
    private func showError(
        message: String
    ) {
         let alert =
            UIAlertController(
                title: AppStrings.errorTitle,
            message: message,
            preferredStyle: .alert
            )
        
        // Retry
        
        let retryAction =
            UIAlertAction(
                title: AppStrings.retry,
                style: .default
            ) { [weak self] _ in

                self?.loadPokemons()
            }
        
        // Cancel
        
        let cancelAction =
            UIAlertAction(
                title: AppStrings.cancel,
                style: .cancel
            )
        
        alert.addAction(retryAction)
        
        alert.addAction(cancelAction)
        
        present(
            
            alert,
            animated: true
            
        )
    }
}

extension PokemonViewController : UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return pokemons.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PokemonTableViewCell.identifier,
            for: indexPath
        ) as? PokemonTableViewCell else {

            return UITableViewCell()
        }

        let pokemon = pokemons[indexPath.row]

        cell.configure(with: pokemon)

        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension PokemonViewController : UITableViewDelegate {
    
}


//MARK: - Load More Pokemon

extension PokemonViewController {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard viewModel.canLoadMore else {
            return
        }
        
        let lastIndex = pokemons.count - 5
        
        if indexPath.row == lastIndex {
            
            Task {
                await viewModel.loadMorePokemons()
                
                render()
            }
            
        }
    }
    
}

//MARK: - PokemonDetailViewController

extension PokemonViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pokemon = pokemons[indexPath.row]
        
        
        let detailVC =
        dependencyContainer.makePokemonDetailViewController(pokemonId: pokemon.id)
            
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
