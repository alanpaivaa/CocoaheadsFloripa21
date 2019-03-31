//
//  StringExtension.swift
//  Utils
//
//  Created by Alan Jeferson on 3/31/19.
//  Copyright © 2019 Alan. All rights reserved.
//

import Foundation

public extension String {
  var fullRange: Range<String.Index> {
    return startIndex..<endIndex
  }
}
