import Foundation
import CreateML

// Loading dataset
let inputPath = "/Users/alanjeferson/projects/CocoaheadsFloripa21/Training/NameTagger.playground/Resources/NamesLess.json"
let inputURL = URL(fileURLWithPath: inputPath)
let dataset = try MLDataTable(contentsOf: inputURL)

// Select only the relevant columns
//let relevantColumns = ["label", "text"]
//print(dataset[relevantColumns])

// Remove additional columns if they don't really contribute to your training
//dataset.removeColumn(named: "someColumn")

// Splitting into training/test sets
let splitRation = 0.8
let (trainingSet, testSet) = dataset.randomSplit(by: 0.8, seed: 7)

// Crating the model
let model  = try MLWordTagger(trainingData: dataset,
                              tokenColumn: "tokens",
                              labelColumn: "labels")

// How well the model performed on training set
let trainingAccuracy = model.trainingMetrics.accuracy * 100

// How well the model performed on validation set
let validationAccuracy = model.validationMetrics.accuracy * 100

// How well the model performed on test set (unseen data)
let testMetrics = model.evaluation(on: testSet)
let testAccuracy = testMetrics.accuracy * 100

print("Test Metrics:")
print("Accuracy: \(testAccuracy)")
print("Precision and Recall:")
print(testMetrics.precisionRecall)
print("Confusion Matrix:")
print(testMetrics.confusion.description)

//// Model's description
print(model.description)

// Evaluating male name
let names = ["Mark", "Jessica", "Chuck", "Julia"]
names.forEach { name in
  print("\(name): \(try! model.prediction(from: name))")
  print("\(name.lowercased()): \(try! model.prediction(from: name))")
}

// If the model isn't good enough you should consider:
// Add more relevant training data
// Change the hyperparameters or the actual algorithm

// Otherwise, persist the CoreML model file
let metadata = MLModelMetadata(author: "Alan Jeferson",
                               shortDescription: "Names for Cocoaheads",
                               version: "1.0")
let outputPath = "/Users/alanjeferson/Desktop/nlf/NameTagger.mlmodel"
let outputURL = URL(fileURLWithPath: outputPath)
try model.write(to: outputURL, metadata: metadata)
