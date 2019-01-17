//
//  Character.swift
//  CharacterViewerVersion2
//
//  Created by Matt Mejia on 1/16/19.
//  Copyright © 2019 Matt_Mejia. All rights reserved.
//

import Foundation

struct Character {
    let characterName, characterDescription: String
    
//    init?(characterName: String, characterDescription: String) {
//        self.characterName = characterName
//        self.characterDescription = characterDescription
//    }
    
    // Initializes the struct with a dictionary if possible.
    init?(dictionary: [String: Any], index: Int) {
        guard let relatedTopics = dictionary["RelatedTopics"] as? [[String: Any]], let characterText = relatedTopics[index]["Text"] as? String
            else { return nil }
        
//        var characterText = relatedTopics[index]
        
        var textToEdit = characterText.index(of: "-") ?? characterText.endIndex
        self.characterName = String(characterText[..<textToEdit])
        self.characterDescription = String(characterText[textToEdit...])
    }
}
