//
//  PhotoApi.swift
//  VK_Nikita
//
//  Created by Никита Троян on 24.10.2021.
//

import UIKit
import Alamofire

final class PhotoApi {
    
    // MARK: - Base URL Config
    let baseUrl = "https://api.vk.com/method"
    let version = "5.81"
    
    // MARK: - Get photos method
    func getPhotos(completion: @escaping([User])->()) {
        
        let token = Session.shared.token
        let userId = Session.shared.userId
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/photos.getAll"
        components.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "offset", value: "1"),
            URLQueryItem(name: "count", value: "1"),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "no_service_albums", value: "1"),
            URLQueryItem(name: "need_hidden", value: "1"),
            URLQueryItem(name: "skip_hidden", value: "1"),
            URLQueryItem(name: "v", value: version)
            
        ]
        
        guard let myURL = components.url else { return }
        
        var request = URLRequest(url: myURL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error as Any)
            }
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
}
