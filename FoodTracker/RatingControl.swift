//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Yoshua Elmaryono on 07/07/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {
    
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
    
}

extension RatingControl {
    private func setupButtons(){
        for _ in 0..<5 { createButton() }
    }
    
    private func createButton(){
        //create the button
        let button = UIButton()
        button.backgroundColor = UIColor.red
        
        //add constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        //setup button action
        button.addTarget(
            self,
            action: #selector(RatingControl.ratingButtonTapped(button:)),
            for: .touchUpInside
        )
        
        //add the button to the stack
        addArrangedSubview(button)
        //add the button to the rating button array
        ratingButtons.append(button)
    }
    
    //MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton){
        print("button pressed")
    }
}
