//
//  BerryDetailViewController.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 6/24/26.
//

import UIKit

final class BerryDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: BerryDetailViewModel
    private let berryId: Int
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    // UI Components
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let flavorLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let categoryLabel = UILabel()
    
    // MARK: - Init
    init(berryId: Int,
         viewModel: BerryDetailViewModel) {
        
        self.berryId = berryId
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadBerry()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        flavorLabel.font = .systemFont(ofSize: 18)
        flavorLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        categoryLabel.font = .systemFont(ofSize: 18)
        categoryLabel.numberOfLines = 0
        
        
        [imageView, nameLabel, flavorLabel, descriptionLabel, categoryLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func loadBerry() {
        Task {
            await viewModel.loadBerry(id: berryId) // ID ejemplo
            render()
        }
    }
    
    private func render() {
        switch viewModel.state {
        case .idle: break
        case .loading: print("Loading Berry Detail...")
        case .success(let berry):
            nameLabel.text = berry.name
            flavorLabel.text = "Sabores: " + berry.flavor.joined(separator: ", ")
            descriptionLabel.text = berry.description
            categoryLabel.text = berry.category
            
            ImageLoader.shared.loadImage(from: berry.image, source: ImageSource.berry) {
                
                [weak self] image in
                
                self?.imageView.image = image
            }
        case .error(let error):
            print("Error: \(error)")
        }
    }
}
