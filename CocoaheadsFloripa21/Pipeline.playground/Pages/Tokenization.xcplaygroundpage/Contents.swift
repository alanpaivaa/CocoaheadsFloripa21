import NaturalLanguage
import PlaygroundSupport

let exampleOfWordTokenizer = example(of: "Word Tokenizer") {
  var corpus = "Apple Park is the Apple’s headquarters located in Cupertino."
  print("Raw: \(corpus)")

  let tokenizer = NLTokenizer(unit: .word)
  tokenizer.string = corpus
  tokenizer.setLanguage(.english)
  
  print("Enumerating...")
  tokenizer.enumerateTokens(in: corpus.fullRange, using: { (range, attributes) -> Bool in
    let token = corpus.substring(with: range)
    print(token)
    return true
  })
  
  let words = tokenizer.stringTokens(for: corpus)
  print("Words: \(words)")
}
//exampleOfWordTokenizer()

let exampleOfSentTokenizer = example(of: "Sent Tokenizer") {
  var corpus = "Apple Park is the Apple’s headquarters located in Cupertino. It is really fun there."
  print("Raw: \(corpus)")
  let tokenizer = NLTokenizer(unit: NLTokenUnit.sentence)
  tokenizer.string = corpus
  //tokenizer.setLanguage(.english)
  let sents = tokenizer.stringTokens(for: corpus)
    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
  print("Sents: \(sents)")
}
//exampleOfSentTokenizer()

let exampleOfParagraphTokenizer = example(of: "Paragraph Tokenizer") {
  var corpus = "Apple Park is the Apple’s headquarters located in Cupertino.\nIt is really fun there."
  print("Raw: \(corpus)")
  let tokenizer = NLTokenizer(unit: .paragraph)
  tokenizer.setLanguage(.english)
  tokenizer.string = corpus
  let tokens = tokenizer.stringTokens(for: corpus)
    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
  print("Paragraphs: \(tokens)")
}
//exampleOfParagraphTokenizer()

let exampleOfTokenizingStatistics = example(of: "Tokenizing Stats") {
  let corpus = corpora(named: "MobyDick")
  
  let wordTokenizer = NLTokenizer(unit: .word)
  wordTokenizer.string = corpus
  
  let sentTokenizer = NLTokenizer(unit: .sentence)
  sentTokenizer.string = corpus
  
  let words = wordTokenizer.stringTokens(for: corpus)
  print("Word count: \(words.count)")
  
  let sents = sentTokenizer.stringTokens(for: corpus)
  print("Sent count: \(sents.count)")
  
  let vocabulary = Set(words.map { $0.lowercased() })
  //  print("Vocabulary: \(vocabulary)")
  print("Vocabulary count:  \(vocabulary.count)")
  
  let averageWordsPerSentence = words.count / sents.count
  print("Average words per sentence: \(averageWordsPerSentence)")
  
  // Using raw corpus count would include punctuation
  let characterCount = words.map { $0.count }.reduce(0, +)
  let averageWordLength = characterCount / words.count
  print("Average word length: \(averageWordLength)")
  
  let averageWordInVocabulary = words.count / vocabulary.count
  print("Average number of times each vocabulary item appears: \(averageWordInVocabulary)")
}
exampleOfTokenizingStatistics()
