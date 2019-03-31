import Foundation
import NaturalLanguage

let exampleOfLexicalClasses = example(of: "Lexical Tagging") {
  let corpus = "Didn't you bring some candies to Tim Cook? This sentence makes no sense?!"

  let allowedSchemes: [NLTagScheme] = [.lexicalClass]
  let tagger = NLTagger(tagSchemes: allowedSchemes)
  tagger.string = corpus
  let options: NLTagger.Options = [.omitWhitespace, .omitPunctuation, .joinNames, .joinContractions]
  tagger.enumerateTags(in: corpus.fullRange, unit: .word, scheme: .lexicalClass, options: options) { (tag, range) -> Bool in
    if let tag = tag {
      print("\(corpus[range]): \(tag.rawValue)")
    } else {
      print("\(corpus[range]): No lemma")
    }
    return true
  }
}
//exampleOfLexicalClasses()

let exampleOfLemmatizing = example(of: "Lemmatizing") {
  let corpus = "Jon Snow was named the King in the North. He has two cool swords."

  let tagger = NLTagger(tagSchemes: [.lemma])
  tagger.string = corpus

  let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace]
  tagger.enumerateTags(in: corpus.fullRange, unit: .word, scheme: .lemma, options: options, using: { tag, range -> Bool in
    if let tag = tag {
      print("\(corpus[range]): \(tag.rawValue)")
    }
    return true
  })
}
//exampleOfLemmatizing()

let exampleOfNER = example(of: "Named Entity Recognition") {
  let corpus = "Apple Park is the Apple’s headquarters located in Cupertino."
  
  let allowedSchemes: [NLTagScheme] = [.nameType, .nameTypeOrLexicalClass]
  let tagger = NLTagger(tagSchemes: allowedSchemes)
  tagger.string = corpus

  let options: NLTagger.Options = [.omitWhitespace, .omitPunctuation, .joinContractions]
  tagger.string = corpus
  tagger.enumerateTags(in: corpus.fullRange, unit: .word, scheme: .nameType, options: options) { (tag, range) -> Bool in
    if let tag = tag {
      print("\(corpus[range]): \(tag.rawValue)")
    }
    return true
  }
}
//exampleOfNER()
