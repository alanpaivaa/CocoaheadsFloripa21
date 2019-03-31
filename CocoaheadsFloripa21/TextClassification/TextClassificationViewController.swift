//
//  TextClassificationViewController.swift
//  CocoaheadsFloripa21
//
//  Created by Alan Jeferson on 3/31/19.
//  Copyright © 2019 Alan. All rights reserved.
//

import UIKit

class TextClassificationViewController: UIViewController {
  @IBOutlet weak var inputTextView: UITextView!
  @IBOutlet weak var resultLabel: UILabel!
  
  private let classifier = CustomTextClassifier()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func didTouchClassifyButton(_ sender: Any) {
    guard let text = inputTextView.text,
      !text.isEmpty,
      let predictedClass = classifier.prediction(for: text) else {
        return
    }
    
    resultLabel.text = predictedClass
  }
}
