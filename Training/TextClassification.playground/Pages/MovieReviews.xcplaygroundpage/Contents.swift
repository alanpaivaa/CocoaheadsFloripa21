import Foundation
import CreateML

let trainingSetURL = URL(fileURLWithPath: "/Users/alanjeferson/Desktop/movie_reviews/train")
let params = MLTextClassifier.ModelParameters(algorithm: .maxEnt(revision: 1),
                                              language: .english)
let model = try MLTextClassifier(trainingData: .labeledDirectories(at: trainingSetURL))

let testSetURL = URL(fileURLWithPath: "/Users/alanjeferson/Desktop/movie_reviews/test")
let testMetrics = model.evaluation(on: .labeledDirectories(at: testSetURL))
print("Test Metrics:")
print("Accuracy: \(testMetrics.accuracy)")
print("Precision and Recall:")
print(testMetrics.precisionRecall)
print("Confusion Matrix:")
print(testMetrics.confusion)


let modelOutputURL = URL(fileURLWithPath: "/Users/alanjeferson/Desktop/nlf/MovieReviewClassifier.mlmodel")
let metadata = MLModelMetadata(author: "Alan Jeferson",
                               shortDescription: "Movie Reviws Classifier for Cocoaheads",
                               version: "1.0")
try model.write(to: modelOutputURL)
