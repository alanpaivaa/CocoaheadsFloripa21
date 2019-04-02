//
//  BrownTagging.swift
//  CocoaheadsFloripa21
//
//  Created by Alan Jeferson on 4/1/19.
//  Copyright © 2019 Alan. All rights reserved.
//

import Foundation
import CoreML
import NaturalLanguage

class BrownTagging {
  func main() {
    let rawTagger = BrownTagger()
    let sent = "My name is Jon Snow and I am the king in the North!"
    do {
      /**
       PP$ - 3rd. singular nominative pronoun
       NN - singular or mass noun
       BEZ - is
       NP - proper noun or part of name phrase
       CC - coordinating conjunction
       PPSS - other nominative personal pronoun (I, we, they, you)
       BEM - am
       AT - article (a, the, no)
       IN - preposition
       JJ - adjective
       -TL - word occurring in title (hyphenated after regular tag)
       "PP$", "NN", "BEZ", "NP", "CC", "PPSS", "BEM", "AT", "NN", "IN", "AT", "JJ-TL"
       More tags: http://www.helsinki.fi/varieng/CoRD/corpora/BROWN/tags.html
       */
      let labels = try rawTagger.prediction(text: sent).labels
      print(labels)

      let model = try NLModel(mlModel: rawTagger.model)

      let scheme = NLTagScheme("Brown")
      let tagger = NLTagger(tagSchemes: [scheme])
      tagger.setModels([model], forTagScheme: scheme)

      tagger.string = sent
      let options: NLTagger.Options = [.omitWhitespace, .omitPunctuation]
      tagger.enumerateTags(in: sent.fullRange,
                           unit: .word,
                           scheme: scheme,
                           options: options) { tag, range -> Bool in
                            if let tag = tag {
                              print("\(sent[range]): \(tag.rawValue)")
                            }
                            return true
      }
    } catch {
      print(error)
    }
  }
}
