//
//  NetworkController.swift
//  CharacterViewerVersion2
//
//  Created by Matt Mejia on 1/16/19.
//  Copyright © 2019 Matt_Mejia. All rights reserved.
//

// Makes a network call and gives back the response.

import Foundation
class NetworkController {
    
    // MARK: Properties
    
    enum HTTPMethod: String {
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case Patch = "PATCH"
        case Delete = "DELETE"
    }
    
    // We are creating this function.
    // urlParameters -> defaults to nil here.
    // Same with completion and body.
    // Completion = allows us to work with the response to this function.
    // Once the response comes back, it calls "completion."
    static func performRequest(for url: URL,
                               httpMethod: HTTPMethod,
                               
                               // Here, nil is a default value for the parameter
        // It will be set as nil if we do not choose to set it as anything else.
        urlParameters: [String : String]? = nil,
        body: Data? = nil,
        completion: ((Data?, Error?) -> Void)? = nil) {
        
        
        // Build our entire URL
        
        // "self" = NetworkController class
        let requestURL = self.url(byAdding: urlParameters, to: url)
        
        // This has more properties than a url.
        // Contains info on how to make the network call.
        // In our case, this includes the URL, HTTP method, HTTP body.
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        
        // Create and "resume" (a.k.a. run) the task
        // URLSession = framework by Apple to make network requests.
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // By calling the completion here, we can work with the data we get back.
            // We want to pass the data and the error outside of this function.
            // Forward these two variables to whatever called NetworkController.performRequest.
            completion?(data, error)
        }
        
        // We have created a dataTask object, but we haven't started it yet.
        // dataTask is created in a "paused" state.
        // Here, we are starting the dataTask.
        dataTask.resume()
        
    }
    
    static func url(byAdding parameters: [String : String]?,
                    to url: URL) -> URL {
        
        // Parts of a url?
        // Hidden to us.
        // If you have a long url (e.g. "mywebsite.com/.../.../..."), the base url is just "mywebsite.com"
        // Be careful about resolvingAgainstBaseURL. Sometimes returns wrong thing.
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        // flatMap: take collection of items in a dictionary or array and do something with them.
        // In our case, it takes each key-val pair from dictionary and turns it into a url query item.
        // URLQueryItem takes url parameters and assigns the name of the key-value pairs
        components?.queryItems = parameters?.flatMap({ URLQueryItem(name: $0.0, value: $0.1) })
        
        guard let url = components?.url else {
            fatalError("URL optional is nil")
        }
        return url
    }
}
