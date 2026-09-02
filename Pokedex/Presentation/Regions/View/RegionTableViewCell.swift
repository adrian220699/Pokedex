//
//  RegionTableViewCell.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/21/26.
//

import UIKit

final class RegionTableViewCell : UITableViewCell {
    
    static let identifier = "RegionTableViewCell"
    
    //MARK: - UI Components
    
    private let randomRegionImageView: UIImageView = {
        
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
        
        contentView.addSubview(randomRegionImageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            randomRegionImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: UIConstants.defaultPadding
            ),
            
            randomRegionImageView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            
            randomRegionImageView.widthAnchor.constraint(equalToConstant: UIConstants.imageSizePokemon),
            randomRegionImageView.heightAnchor.constraint(equalToConstant: UIConstants.imageSizePokemon),
            
            nameLabel.leadingAnchor.constraint(
                equalTo: randomRegionImageView.trailingAnchor,
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
    
    func configure(with region : Region) {
        
        nameLabel.text = region.name.capitalized
        
        // URL final
     
        let imageUrl = region.sprite ?? ""
        
        // Descargar Imagen
        
        ImageLoader.shared.loadImage(
            from: imageUrl, source: ImageSource.region
        ) { [weak self] image in

            self?.randomRegionImageView.image = image
        }


    }
}


