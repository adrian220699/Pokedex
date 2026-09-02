//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 6/15/26.
//

import UIKit

final class PokemonDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: PokemonDetailViewModel
    private let pokemonId: Int
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    // UI Components
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let typesLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let moveLabel = UILabel()
    private let locationLabel = UILabel()
    
    // MARK: - Init
    init(pokemonId: Int,
         viewModel: PokemonDetailViewModel) {
        
        self.pokemonId = pokemonId
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadPokemon()
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
        typesLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        moveLabel.font = .systemFont(ofSize: 16)
        moveLabel.numberOfLines = 0
        locationLabel.font = .systemFont(ofSize: 16)
        locationLabel.numberOfLines = 0
        
        [imageView, nameLabel, typesLabel, descriptionLabel, moveLabel,locationLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func loadPokemon() {
        Task {
            await viewModel.loadPokemon(id: pokemonId) // ID ejemplo
            render()
        }
    }
    
    private func render() {
        switch viewModel.state {
        case .idle: break
        case .loading: print("Loading Pokémon detail...")
        case .success(let pokemon):
            nameLabel.text = pokemon.name
            typesLabel.text = "Tipos: " + pokemon.types.joined(separator: ", ")
            descriptionLabel.text = pokemon.description
            moveLabel.text = viewModel.randomMoves(from: pokemon)
            locationLabel.text =  viewModel.randomLocations(from: pokemon)
            
            ImageLoader.shared.loadImage(from: pokemon.image.normal, source: ImageSource.pokemon) {
                
                [weak self] image in
                
                self?.imageView.image = image
            }
        case .error(let error):
            print("Error: \(error)")
        }
    }
}
