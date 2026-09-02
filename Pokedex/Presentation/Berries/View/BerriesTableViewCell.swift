//
//  BerriesTableViewCell.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/20/26.
//

import UIKit

final class BerriesTableViewCell : UITableViewCell {
    
    static let identifier = "BerriesTableViewCell"
    
    //MARK: - UI Components
    
    private let berryImageView: UIImageView = {
        
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
        
        contentView.addSubview(berryImageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            berryImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: UIConstants.defaultPadding
            ),
            
            berryImageView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            
            berryImageView.widthAnchor.constraint(equalToConstant: UIConstants.imageSizeItem),
            berryImageView.heightAnchor.constraint(equalToConstant: UIConstants.imageSizeItem),
            
            nameLabel.leadingAnchor.constraint(
                equalTo: berryImageView.trailingAnchor,
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
    
    func configure(with berry : Berry) {
        
        nameLabel.text = berry.name
                        
        // URL final
        
        let imageUrl : String
        
        imageUrl = berry.image
        
        // Descargar Imagen
  
        ImageLoader.shared.loadImage(
            from: imageUrl,
            source: ImageSource.berry
        ) { [weak self] image in

            self?.berryImageView.image = image
        }

  
    }
}
