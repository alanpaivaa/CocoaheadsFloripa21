import Foundation
import CreateML

public extension MLWordTaggerMetrics {
  public var accuracy: Double {
    return (1.0 - taggingError)
  }
}
