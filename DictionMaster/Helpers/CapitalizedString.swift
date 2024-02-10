//
//  CapitalizedString.swift
//  DictionMaster
//
//  Created by Gustavo Assis on 09/02/24.
//

import Foundation

extension String {
    var capitalizedSentence: String {
         // 1
         let firstLetter = self.prefix(1).capitalized
         // 2
         let remainingLetters = self.dropFirst().lowercased()
         // 3
         return firstLetter + remainingLetters
     }
}
