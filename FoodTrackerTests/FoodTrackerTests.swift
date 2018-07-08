//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Yoshua Elmaryono on 05/07/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    //MARK: Meal Class Tests
    func testMealInitializationSucceeds(){
        let zeroRatingMeal = Meal(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        let positiveRatingMeal = Meal(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    func testMealInitializationFails(){
        let emptyStringMeal = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        
        let negativeRatingMeal = Meal(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        let rating_exceedingMaximumRating = 100
        let tooHighRatingMeal = Meal(name: "Too High", photo: nil, rating: rating_exceedingMaximumRating)
        XCTAssertNil(tooHighRatingMeal)
    }
    
}
