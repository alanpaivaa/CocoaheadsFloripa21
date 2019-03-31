import Foundation
import NaturalLanguage

public extension String {
  public var fullRange: Range<String.Index> {
    return startIndex..<endIndex
  }
}

public extension Array where Element == Range<String.Index> {
  public func substrings(in string: String) -> [String] {
    return self.map { String(string[$0]) }
  }
}

public extension NLTokenizer {
  public func stringTokens(for text: String) -> [String] {
    return tokens(for: text.fullRange).substrings(in: text)
  }
}

public typealias ExecutionBlock = () -> Void

public func example(of header: String, closure: @escaping ExecutionBlock) -> ExecutionBlock {
  return {
    print("--------------- \(header) ---------------")
    closure()
  }
}

public func corpora(named name: String) -> String {
  let url = Bundle.main.url(forResource: name, withExtension: "txt")!
  return try! String(contentsOf: url)
}
