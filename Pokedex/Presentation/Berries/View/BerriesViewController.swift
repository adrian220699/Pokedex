//
//  BerriesViewController.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/18/26.
//
import UIKit

final class BerriesViewController : UIViewController {
    
    //MARK: - Properties
    
    private let viewModel : BerryViewModel
    private let tableView = UITableView()
    private let dependencyContainer : DependencyContainer

    
    //MARK: - UI State Data

    private var berries: [Berry] = []

    
    //MARK: - Init
    
    init(viewModel: BerryViewModel, dependencyContainer: DependencyContainer) {
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
        title = "Berries"
        
        setupTableView()
        loadBerries()
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
            BerriesTableViewCell.self,
            forCellReuseIdentifier: BerriesTableViewCell.identifier
            
        )
        
        tableView.rowHeight = UIConstants.defaultRowHeight
        
    }
    
    
    //MARK: - Load Berries
    
    private func loadBerries() {
        Task {
       
            // LOADING STATE

            viewModel.state = .loading

            render()

            // FETCH DATA

            await viewModel.loadBerries()

            // SUCCESS / ERROR

            render()
            
            }
        }
    
    private func render() {
        
        switch viewModel.state {

        case .idle:
            print("Idle")


            break

        case .loading:

            print("Loading Berries")

        case .success(let berries):
            
            print("Succes Berries")


            self.berries = berries

            tableView.reloadData()

        case .error(let error):

            showError(message:
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
            
                self?.loadBerries()
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

extension BerriesViewController : UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return berries.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BerriesTableViewCell.identifier,
            for: indexPath
        ) as? BerriesTableViewCell else {

            return UITableViewCell()
        }

        let berry = berries[indexPath.row]

        cell.configure(with: berry)

        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension BerriesViewController : UITableViewDelegate {
    
}

//MARK: - Load More Berries

extension BerriesViewController {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard viewModel.canLoadMore else {
            return
        }
        
        let lastIndex = berries.count - 5
        
        if indexPath.row == lastIndex {
            
            Task {
                await viewModel.loadMoreBerries()
                
                render()
            }
            
        }
    }
    
}

//MARK: - BerryDetailViewController

extension BerriesViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let berry = berries[indexPath.row]
        
        let detailVC =
        dependencyContainer.makeBerryDetailViewController(berryId: berry.id)
            
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


