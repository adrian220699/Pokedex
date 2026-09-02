//
//  ItemsDetailViewController.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 6/24/26.
//

import UIKit

final class ItemsDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: ItemDetailViewModel
    private let itemId: Int
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    // UI Components
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let categoryLabel = UILabel()
    private let priceLabel = UILabel()
    
    // MARK: - Init
    init(itemId: Int,
         viewModel: ItemDetailViewModel) {
        
        self.itemId = itemId
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadItem()
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
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        categoryLabel.font = .systemFont(ofSize: 16)
        categoryLabel.numberOfLines = 0
        priceLabel.font = .systemFont(ofSize: 16)
        
        [imageView, nameLabel, descriptionLabel, categoryLabel,priceLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func loadItem() {
        Task {
            await viewModel.loadItem(id: itemId) // ID ejemplo
            render()
        }
    }
    
    private func render() {
        switch viewModel.state {
        case .idle: break
        case .loading: print("Loading Item detail...")
        case .success(let item):
            nameLabel.text = item.name
            descriptionLabel.text = item.description
            categoryLabel.text = item.category
            priceLabel.text = "\(item.price)"
            
            ImageLoader.shared.loadImage(from: item.image, source: ImageSource.item) {
                
                [weak self] image in
                
                self?.imageView.image = image
            }
        case .error(let error):
            print("Error: \(error)")
        }
    }
}

