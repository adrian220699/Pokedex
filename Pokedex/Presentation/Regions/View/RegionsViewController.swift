//
//  RegionsViewController.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/18/26.
//

import UIKit

final class RegionsViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: PokemonRegionViewModel

    private let tableView = UITableView()
    
    private let dependencyContainer : DependencyContainer

   //MARK: - UI State Data
    
    private var regions: [Region] = []

    // MARK: - Init

    init(viewModel: PokemonRegionViewModel,dependencyContainer : DependencyContainer) {

        self.viewModel = viewModel
        self.dependencyContainer = dependencyContainer

        super.init(
            nibName: nil,
            bundle: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor =
            .systemBackground

        title = "Regions"

        setupTableView()

        loadRegions()
    }

    // MARK: - Setup TableView

    private func setupTableView() {

        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints =
            false

        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(
                equalTo:
                    view.safeAreaLayoutGuide.topAnchor
            ),

            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])

        tableView.dataSource = self

        tableView.delegate = self

        tableView.register(
            RegionTableViewCell.self,
            forCellReuseIdentifier:
                RegionTableViewCell.identifier
        )

        tableView.rowHeight = UIConstants.defaultRowHeight
    }

    // MARK: - Load Regions

    private func loadRegions() {

        Task {

            // LOADING STATE

            viewModel.state = .loading

            render()

            // FETCH DATA

            await viewModel.loadRegions()

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

            print("Loading Regions")

        case .success(let regions):
            
            print("Success Regions")


            self.regions = regions

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
        
        let retryAction =
        UIAlertAction(
            title: AppStrings.retry,
            style: .default
        ) { [weak self] _ in
            
            self?.loadRegions()
        }
        
        let cancelAction =
        UIAlertAction(
            title: AppStrings.cancel,
            style: .cancel
            
            )
        
        alert.addAction(retryAction)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
}

// MARK: - UITableViewDataSource

extension RegionsViewController:
    UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return regions.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard let cell =
            tableView.dequeueReusableCell(
                withIdentifier:
                    RegionTableViewCell.identifier,
                for: indexPath
            ) as? RegionTableViewCell
        else {

            return UITableViewCell()
        }

        let region = regions[indexPath.row]

        cell.configure(with: region)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension RegionsViewController:
    UITableViewDelegate {

}

//MARK: - Pokemon Region List

extension RegionsViewController  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let region =
        regions[indexPath.row]
        
        guard let range = RegionPokemonRange.range(for: region.name)
        
        else {
            return
        }
        
        
        let vc = dependencyContainer.makePokemonByRegionViewController(regionName: region.name, range: range)
        
        navigationController?.pushViewController(vc, animated: true)
   
        
        
    }
}
    
