//
//  APIReques.swift
//  PhotosObjectDetection
//
//  Created by Rodrigo  Candido on 26/4/21.
//

import Foundation

/// Implement this protocol to automate and make expandable any REQUEST model
protocol APIRequest {
    associatedtype Response: Codable
    var http: HTTPMethod                { get }
    var path: String                    { get }
    var parameters: [String: String]    { get }
}

//
extension APIRequest{
    
    var baseURL: URL {
        get{
            guard let baseURL = URL(string: APIPath.main.path) else { fatalError("URL not valid") }
            return baseURL
        }
        //
        set{}
    }
    
    func baseRequest() -> URLRequest {
        
        let url = baseURL.appendingPathComponent(path)
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("Not able to create components")
        }
        
        if !parameters.isEmpty{
            components.queryItems = parameters.map{ (key, value) in
                URLQueryItem(name: key, value: value)
            }
        }
        
    
        var request = URLRequest(url: url)
        request.httpMethod = http.method
        return request
    }
}
