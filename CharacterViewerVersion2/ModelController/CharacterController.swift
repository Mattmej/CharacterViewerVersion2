//
//  CharacterController.swift
//  CharacterViewerVersion2
//
//  Created by Matt Mejia on 1/16/19.
//  Copyright © 2019 Matt_Mejia. All rights reserved.
//

import Foundation

class CharacterController {
    static let url = URL(string: "https://api.duckduckgo.com/?q=looney+tunes+characters&format=json")
    
    static func getCharacters(completion: @escaping(Character?) -> Void) {
        
        guard let url = url else { return }
        
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: nil, body: nil) { (data, error) in
            
            // If we have an error
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = data,
                let responseDataString = String(data: data, encoding: .utf8)
                else { completion(nil); return }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any]
                else { completion(nil); return }
            
            print(jsonDictionary)
            
            var i = 0
            
            for i in index {
                guard var character = Character(dictionary: jsonDictionary, index: i)

            }
            
        }
    }
}
