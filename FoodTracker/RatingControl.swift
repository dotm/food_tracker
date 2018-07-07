//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Yoshua Elmaryono on 07/07/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet { updateButtonSelectionStates() }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet { setupButtons() }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet { setupButtons() }
    }
}

extension RatingControl {
    private func setupButtons(){
        clearAllButtons()
        
        //load button images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        func createButton(_ index: Int){
            //create the button
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            addConstraints_toButton(button)
            addActions_toButton(button)
            addAccessibilityLabel_toButton(button, index: index)
            
            addButton(button)
        }
        for i in 0 ..< starCount {
            createButton(i)
        }
        
        updateButtonSelectionStates()
    }
    
    private func addButton(_ button: UIButton){
        //add the button to the stack
        addArrangedSubview(button)
        //add the button to the rating button array
        ratingButtons.append(button)
    }
    private func addConstraints_toButton(_ button: UIButton){
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
    }
    private func addActions_toButton(_ button: UIButton){
        button.addTarget(
            self,
            action: #selector(RatingControl.ratingButtonTapped(button:)),
            for: .touchUpInside
        )
    }
    private func addAccessibilityLabel_toButton(_ button: UIButton, index: Int){
        button.accessibilityLabel = "Set \(index + 1) star rating"
    }
    private func addAccessibilityHintAndValue_toButton(_ button: UIButton, index: Int){
        let star_isAlreadySelected = (rating == index + 1)
        button.accessibilityHint = star_isAlreadySelected ? "Tap to reset the rating to zero." : nil
        
        button.accessibilityValue = {
            switch(rating){
            case 0: return "No rating set."
            case 1: return "1 star set."
            default: return "\(rating) stars set."
            }
        }()
    }
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
            
            addAccessibilityHintAndValue_toButton(button, index: index)
        }
    }
    private func clearAllButtons(){
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
    }
    
    //MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton){
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
}
