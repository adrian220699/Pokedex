//
//  ItemsViewController.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/18/26.
//

import UIKit

final class ItemsViewController : UIViewController {
    
    //MARK: - Properties
    
    private let viewModel : ItemsViewModel
    private let tableView = UITableView()
    private let dependencyContainer : DependencyContainer

    
    //MARK: - UI State Data
    
    private var items : [Item] = []
    
    //MARK: - Init
    
    init(viewModel: ItemsViewModel, dependencyContainer: DependencyContainer) {
        self.viewModel = viewModel
        self.dependencyContainer = dependencyContainer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Items"
        
        setupTableView()
        loadItems()
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
            ItemsTableViewCell.self,
            forCellReuseIdentifier: ItemsTableViewCell.identifier
            
        )
        
        tableView.rowHeight = UIConstants.defaultRowHeight
        
    }
    
    
    //MARK: - Load Berries
    
    private func loadItems() {
        Task {
           
            // Loading State
            
            viewModel.state = .loading
            
            render()
            
            
            // Fetch Data
            
            await viewModel.loadItems()
            
            // Succes Error
            
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

            print("Loading Items")

        case .success(let items):
            
            print("Success Items")


            self.items = items

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
                
                self?.loadItems()
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

extension ItemsViewController : UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return items.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemsTableViewCell.identifier,
            for: indexPath
        ) as? ItemsTableViewCell else {

            return UITableViewCell()
        }

        let item = items[indexPath.row]

        cell.configure(with: item)

        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension ItemsViewController : UITableViewDelegate {
    
}

//MARK: - Load More Items

extension ItemsViewController {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard viewModel.canLoadMore else {
            return
        }
        
        let lastIndex = items.count - 5
        
        if indexPath.row == lastIndex {
            
            Task {
                await viewModel.loadMoreItems()
                
                render()
            }
            
        }
    }
    
}

//MARK: - ItemDetailViewController

extension ItemsViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
                
        let detailVC =
        dependencyContainer.makeItemDetailViewController(itemId: item.id)
            
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


