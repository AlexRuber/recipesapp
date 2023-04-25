//
//  RADessertCollectionViewCell.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/20/23.
//

import UIKit

/// Single cell for a Dessert Item
class RADessertCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellIdentifier = "RADessertCollectionViewCell"
    
    private let dessertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dessertNameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let getRecipeSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("unsupported")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(dessertImageView)
        contentView.addSubview(dessertNameTitleLabel)
        contentView.addSubview(getRecipeSubtitleLabel)
        

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupLayer()
    }
    
    private func setupLayer() {
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
    }

    private func layoutUI() {
        // Add constraints
        
        // Recipe Label
        NSLayoutConstraint.activate([
            getRecipeSubtitleLabel.heightAnchor.constraint(equalToConstant: 30),
            getRecipeSubtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            getRecipeSubtitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            getRecipeSubtitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
        ])
        
        // Dessert Name Title Label
        NSLayoutConstraint.activate([
            dessertNameTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            dessertNameTitleLabel.bottomAnchor.constraint(equalTo: getRecipeSubtitleLabel.topAnchor, constant: -5),
            dessertNameTitleLabel.leftAnchor.constraint(equalTo: getRecipeSubtitleLabel.leftAnchor),
            dessertNameTitleLabel.rightAnchor.constraint(equalTo: getRecipeSubtitleLabel.rightAnchor)
        ])
        
        // Dessert Image
        NSLayoutConstraint.activate([
            dessertImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            dessertImageView.bottomAnchor.constraint(equalTo: dessertNameTitleLabel.topAnchor, constant: -5),
            dessertImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            dessertImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dessertImageView.image = nil
        dessertNameTitleLabel.text = nil
        getRecipeSubtitleLabel.text = nil
    }
    
    public func configure(with viewModel: RADessertCollectionViewCellViewModel) {
        dessertNameTitleLabel.text = viewModel.dessertName
        getRecipeSubtitleLabel.text = "View Recipe"

        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                // We want to add it on the main thread
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.dessertImageView.image = image
                }
                
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
        
    }
}
