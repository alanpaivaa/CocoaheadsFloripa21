import Foundation
import CreateML

public extension MLClassifierMetrics {
  public var accuracy: Double {
    return (1.0 - classificationError)
  }
}
