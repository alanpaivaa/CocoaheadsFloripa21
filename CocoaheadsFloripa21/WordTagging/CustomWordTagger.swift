//
//  CustomWordTagger.swift
//  WordTagging
//
//  Created by Alan Jeferson on 3/31/19.
//  Copyright © 2019 Alan. All rights reserved.
//

import Foundation
import NaturalLanguage

class CustomWordTagger {
  private let scheme = NLTagScheme("Name")
  private let options: NLTagger.Options = [.omitWhitespace, .omitPunctuation]
  
  lazy var tagger: NLTagger = {
    let url = Bundle.main.url(forResource: "NameTagger", withExtension: "mlmodelc")!
    let model = try! NLModel(contentsOf: url)
    let tagger = NLTagger(tagSchemes: [self.scheme])
    tagger.setModels([model], forTagScheme: scheme)
    return tagger
  }()
  
  func tag(sent: String) -> [(String, String)] {
    tagger.string = sent.lowercased()
    return tagger.tags(in: sent.fullRange,
                       unit: .word,
                       scheme: scheme,
                       options: options)
      .compactMap { tag, range -> (String, String)? in
        guard let tag = tag else { return nil }
        let subString = sent[range]
        let token = String(subString)
        return (token, tag.rawValue)
    }
  }
}
