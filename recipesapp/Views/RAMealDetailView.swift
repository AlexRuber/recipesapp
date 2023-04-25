//
//  RAMealDetailView.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/23/23.
//

import UIKit

final class RAMealDetailView: UIView {
    
    // MARK: - Properties
    
    var item = [RAMealDetailsModel]()
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
    public weak var delegate: RAMealDetailsViewViewModelDelegate?
        
    private let mealTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let mealRecipeLabel: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemBackground
        textView.textColor = .black
        textView.font = UIFont(name: "AvenirNext-Medium", size: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        textView.isEditable = false
        return textView
    }()
    
    private let mealIngredientsLabel: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemBackground
        textView.textColor = .black
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        textView.font = UIFont(name: "AvenirNext-Medium", size: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        return textView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubview(spinner)
        addSubview(mealImageView)
        addSubview(mealTitleLabel)
        addSubview(mealRecipeLabel)
        addSubview(mealIngredientsLabel)
    }
    
    public func configure(with viewModel: RAMealDetailViewViewModel) {
        viewModel.delegate = self
        viewModel.fetchMealDetails()
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.mealImageView.image = UIImage(data: data)
                }
            case .failure(let failure):
                break
            }
        }
    }
    
    
    private func layoutUI() {
        // Spinner
        NSLayoutConstraint.activate(
            [spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
             spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
        
        // Image view
        NSLayoutConstraint.activate(
            [mealImageView.topAnchor.constraint(equalTo: self.topAnchor),
             mealImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             mealImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             mealImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3)])
        
        // Meal Title Label
        NSLayoutConstraint.activate(
            [mealTitleLabel.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: 10),
             mealTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
             mealTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
             mealTitleLabel.heightAnchor.constraint(equalToConstant: 30)])
        
        // Ingredients Label
        NSLayoutConstraint.activate(
            [mealIngredientsLabel.topAnchor.constraint(equalTo: mealTitleLabel.bottomAnchor, constant: 10),
             mealIngredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
             mealIngredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
             mealIngredientsLabel.heightAnchor.constraint(equalToConstant: 150)])
        
        // Recipe Label
        NSLayoutConstraint.activate(
            [mealRecipeLabel.topAnchor.constraint(equalTo: mealIngredientsLabel.bottomAnchor, constant: 10),
             mealRecipeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
             mealRecipeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
             mealRecipeLabel.heightAnchor.constraint(equalToConstant: 150),
             mealRecipeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)])
    }
    
}
extension RAMealDetailView: RAMealDetailsViewViewModelDelegate {
    func didLoadMealDetails(meal: RAMealsDetailsAPIResponse) {
        addMealInfo(meal: meal)
    }
    
    func addMealInfo(meal: RAMealsDetailsAPIResponse) {
        self.item                   = meal.meals
        self.mealTitleLabel.text  = self.item.first?.strMeal
        
        self.mealRecipeLabel.text =
             """
             Instructions
             \(self.item.first?.strInstructions ?? "")
             """
        
        var getIngredients =
                """
                Ingredients
                \(self.item.first?.strIngredient1 ?? "") \(self.item.first?.strMeasure1 ?? ""), \
                \(self.item.first?.strIngredient2 ?? "") \(self.item.first?.strMeasure2 ?? ""), \
                \(self.item.first?.strIngredient3 ?? "") \(self.item.first?.strMeasure3 ?? ""), \
                \(self.item.first?.strIngredient4 ?? "") \(self.item.first?.strMeasure4 ?? ""), \
                \(self.item.first?.strIngredient5 ?? "") \(self.item.first?.strMeasure5 ?? ""), \
                \(self.item.first?.strIngredient6 ?? "") \(self.item.first?.strMeasure6 ?? ""), \
                \(self.item.first?.strIngredient7 ?? "") \(self.item.first?.strMeasure7 ?? ""), \
                \(self.item.first?.strIngredient8 ?? "") \(self.item.first?.strMeasure8 ?? ""), \
                \(self.item.first?.strIngredient9 ?? "") \(self.item.first?.strMeasure9 ?? ""), \
                \(self.item.first?.strIngredient10 ?? "") \(self.item.first?.strMeasure10 ?? ""), \
                \(self.item.first?.strIngredient11 ?? "") \(self.item.first?.strMeasure11 ?? ""), \
                \(self.item.first?.strIngredient12 ?? "") \(self.item.first?.strMeasure12 ?? ""), \
                \(self.item.first?.strIngredient13 ?? "") \(self.item.first?.strMeasure13 ?? ""), \
                \(self.item.first?.strIngredient14 ?? "") \(self.item.first?.strMeasure14 ?? ""), \
                \(self.item.first?.strIngredient15 ?? "") \(self.item.first?.strMeasure15 ?? ""), \
                \(self.item.first?.strIngredient16 ?? "") \(self.item.first?.strMeasure16 ?? ""), \
                \(self.item.first?.strIngredient17 ?? "") \(self.item.first?.strMeasure17 ?? ""), \
                \(self.item.first?.strIngredient18 ?? "") \(self.item.first?.strMeasure18 ?? ""), \
                \(self.item.first?.strIngredient19 ?? "") \(self.item.first?.strMeasure19 ?? ""), \
                \(self.item.first?.strIngredient20 ?? "") \(self.item.first?.strMeasure20 ?? "")
                """.replacingOccurrences(of: " ,", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        if getIngredients.last == "," {
            _ = getIngredients.popLast()
        }
        self.mealIngredientsLabel.text = getIngredients + "."
        self.mealImageView.isHidden = false
        self.mealTitleLabel.isHidden = false
        self.mealRecipeLabel.isHidden = false
        self.mealIngredientsLabel.isHidden = false
    }
    
    
}
