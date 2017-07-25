//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Leon Dai on 2017-07-24.
//  Copyright © 2017 Leon Dai. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MAKR: Properties
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        
        didSet{
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet{
            setupButtons()
        }
    }
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupButtons()
    }
    
    required init (coder: NSCoder){
        
        super.init(coder: coder)
        
        setupButtons()
    }
    
    //MARK: Button Action
    
    func ratingButtonTapped(button: UIButton) {
        
        guard let index = ratingButtons.index(of: button) else {
            
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate rating of selected button
        
        let selectedRating = index + 1
        
        if selectedRating == rating {
            
            rating = 0
        } else {
            
            rating = selectedRating
        }
    }
    
    //MARK: Private Methods
    
    private func setupButtons() {
        
        // Clear existing buttons
        
        for button in ratingButtons {
            
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        // Load Button Images
        
        let bundle = Bundle(for: type(of: self))
        
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)

        for _ in 0..<starCount {
        
            // Create button
            let button = UIButton()
            
            // Set button images (Buttons have 5 states)
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Setup button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
            // Add button to stack
            addArrangedSubview(button)
            
            // Add button to array
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        
        for (index, button) in ratingButtons.enumerated() {
            
            button.isSelected = index < rating
            
            // Set hint string for current star
            
            let hintString: String?
            
            if rating == index + 1 {
                
                hintString = "Tap to reset the rating to zero."
            } else {
                
                hintString = nil
            }
            
            // Calculate value string
            
            let valueString: String
            
            switch (rating){
                
            case 0:
                valueString = "No rating set."
                
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set"
            }
            
            // Assign string values
            
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }

}
