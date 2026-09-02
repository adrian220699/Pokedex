//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/19/26.
//

import UIKit

final class PokemonTableViewCell : UITableViewCell {
    
    static let identifier = "PokemonTableViewCell"
    
    //MARK: - UI Components
    
    private let pokemonImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Setup UI
    
    private func setupUI() {
        
        contentView.addSubview(pokemonImageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            pokemonImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: UIConstants.defaultPadding
            ),
            
            pokemonImageView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            
            pokemonImageView.widthAnchor.constraint(equalToConstant: UIConstants.imageSizePokemon),
            pokemonImageView.heightAnchor.constraint(equalToConstant: UIConstants.imageSizePokemon),
            
            nameLabel.leadingAnchor.constraint(
                equalTo: pokemonImageView.trailingAnchor,
                constant: UIConstants.defaultPadding
            ),
            
            nameLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            
            nameLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -UIConstants.defaultPadding
            )
        ])
    }
    
    //MARK: - Configure
    
    func configure(with pokemon : Pokemon) {
        
        nameLabel.text = pokemon.name
        
        // Random Shiny Chance
        
        let randomNumber = Int.random(in: 1...21)
        
        // URL final
        
        let imageUrl : String
        
        if randomNumber == 7 {
            
            // Si existe shiny -> usar el shiny
            // Si no usar -> Normal
            
            imageUrl = pokemon.image.shiny ?? pokemon.image.normal
        
        } else {
            imageUrl = pokemon.image.normal
        }
        
        // Descargar Imagen
    
        ImageLoader.shared.loadImage(
            from: imageUrl, source: ImageSource.pokemon
        ) { [weak self] image in

            self?.pokemonImageView.image = image
        }

    
    }
}
