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
    var rating = 0
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
        for _ in 0 ..< starCount { createButton() }
    }
    
    private func createButton(){
        //create the button
        let button = UIButton()
        button.backgroundColor = UIColor.red
        
        //add constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        
        //setup button action
        button.addTarget(
            self,
            action: #selector(RatingControl.ratingButtonTapped(button:)),
            for: .touchUpInside
        )
        
        addButton(button)
    }
    
    private func addButton(_ button: UIButton){
        //add the button to the stack
        addArrangedSubview(button)
        //add the button to the rating button array
        ratingButtons.append(button)
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
        print("button pressed")
    }
}
