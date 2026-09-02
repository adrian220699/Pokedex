//
//  ItemsTableViewCell.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/20/26.
//

import UIKit

final class ItemsTableViewCell : UITableViewCell {
    
    static let identifier = "ItemsTableViewCell"
    
    //MARK: - UI Components
    
    private let itemImageView : UIImageView = {
        
        let imageView  = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    
    }()
    
    private let nameLabel : UILabel =  {
        
        let nameLabel = UILabel()
        
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
    
        return nameLabel
        
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
        
        contentView.addSubview(itemImageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            itemImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: UIConstants.defaultPadding
            ),
            
            itemImageView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            
            itemImageView.widthAnchor.constraint(equalToConstant: UIConstants.imageSizeItem),
            itemImageView.heightAnchor.constraint(equalToConstant: UIConstants.imageSizeItem),
            
            nameLabel.leadingAnchor.constraint(
                equalTo: itemImageView.trailingAnchor,
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
    
    func configure(with item : Item) {
        
        nameLabel.text = item.name
                        
        // URL final
        
        let imageUrl : String
        
        imageUrl = item.image
        
        // Descargar Imagen

        ImageLoader.shared.loadImage(
            from: imageUrl, source: ImageSource.item
        ) { [weak self] image in

            self?.itemImageView.image = image
        }

    }
}
