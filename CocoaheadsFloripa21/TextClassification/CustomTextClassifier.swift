//
//  CustomTextClassifier.swift
//  TextClassification
//
//  Created by Alan Jeferson on 3/31/19.
//  Copyright © 2019 Alan. All rights reserved.
//

import Foundation
import NaturalLanguage

class CustomTextClassifier {
  private let scheme = NLTagScheme("MovieReview")
  private let options: NLTagger.Options = [.omitPunctuation]

  private lazy var tagger: NLTagger = {
    let url = Bundle.main.url(forResource: "MovieReviewClassifier", withExtension: "mlmodelc")!
    let model = try! NLModel(contentsOf: url)
    let tagger = NLTagger(tagSchemes: [scheme])
    tagger.setModels([model], forTagScheme: scheme)
    return tagger
  }()
  
  func prediction(for text: String) -> String? {
    tagger.string = text
    tagger.setLanguage(.english, range: text.fullRange)
    return tagger.tags(in: text.fullRange,
                       unit: .document,
                       scheme: scheme,
                       options: options)
      .compactMap { tag, _ -> String? in
        return tag?.rawValue
      }
      .first
  }
}
