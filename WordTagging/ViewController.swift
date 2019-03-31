//
//  ViewController.swift
//  WordTagging
//
//  Created by Alan Jeferson on 3/31/19.
//  Copyright © 2019 Alan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  
  private var words: [(title: String, tokens: [String])] = []
  private let tagger = CustomNameTagger()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.reloadData()
  }
  
  @IBAction func didTouchPlusButton(_ sender: Any) {
    let alert = UIAlertController(title: "New sentence",
                                  message: "Type the sentence bellow",
                                  preferredStyle: .alert)
    alert.addTextField(configurationHandler: nil)
    let okAction = UIAlertAction(title: "Ok", style: .default) { [unowned self] _ in
      guard let sent = alert.textFields?.first?.text,
        !sent.isEmpty else { return }
      self.tag(sent: sent)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    alert.addAction(okAction)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }
  
  func tag(sent: String) {
    let tags = tagger.tag(sent: sent)
    let maleTokens = tags.filter { $0.1 == "MALE" }.map { $0.0 }
    let femaleTokens = tags.filter { $0.1 == "FEMALE" }.map { $0.0 }
    words = [
      (title: "Female", tokens: femaleTokens),
      (title: "Male", tokens: maleTokens)
    ]
    tableView.reloadData()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return words.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return words[section].tokens.count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return words[section].title
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
    cell.textLabel?.text = words[indexPath.section].tokens[indexPath.row]
    return cell
  }
}

