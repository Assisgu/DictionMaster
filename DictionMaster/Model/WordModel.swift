//
//  WordModel.swift
//  DictionMaster
//
//  Created by Gustavo Assis on 05/02/24.
//

import Foundation

// MARK: - WordElement
struct WordElement: Codable {
    let word: String
    let phonetic: String?
    let phonetics: [Phonetic]
    let meanings: [Meaning]
}

// MARK: - Meaning
struct Meaning: Codable {
    let partOfSpeech: String?
    let definitions: [Definition]?
}

// MARK: - Definition
struct Definition: Codable {
    let definition: String?
    let example: String?
}

// MARK: - Phonetic
struct Phonetic: Codable {
    let audio: String?
    let text: String?
}

//MARK: - List Formatted
struct PartOfSpeechData {
    let partOfSpeech: String
    let deifinitions: [Definition]
}

