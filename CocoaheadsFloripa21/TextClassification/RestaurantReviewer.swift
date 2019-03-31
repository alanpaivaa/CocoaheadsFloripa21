//
//  RestaurantReviewer.swift
//  CocoaheadsFloripa21
//
//  Created by Alan Jeferson on 3/31/19.
//  Copyright © 2019 Alan. All rights reserved.
//

import Foundation
import CoreML

class RestaurantReviewer {
  func main() {
    let classifier = RestaurantReviewClassifier()
    let reviews = [
      "I guess I'll never come back here...",
      "The view from where I was sit was just amazing",
      "The waiter was very friendly and kind",
      "The fish was rotten :/",
    ]
    reviews.forEach { review in
      do {
        let prediction = try classifier.prediction(text: review).label
        print("\(review): \(prediction)")
      } catch {
       print(error)
      }
    }
  }
}
