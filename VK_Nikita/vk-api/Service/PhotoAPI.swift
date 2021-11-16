//
//  PhotoApi.swift
//  VK_Nikita
//
//  Created by Никита Троян on 24.10.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

final class PhotoApi {
    
    // MARK: - Base URL Config
    let baseUrl = "https://api.vk.com/method"
    let version = "5.81"
    
    // MARK: - Get photos method
    func getPhotos(for id:String, completion: @escaping([FriendPhotos])->()) {
        
        let token = "79a63ab679a63ab679a63ab62979dff2bd779a679a63ab618d70f6ae9fa52022545adae"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/photos.get"
        components.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "owner_id", value: id),
            URLQueryItem(name: "extended", value: "0"),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "offset", value: "1"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "photo_sizes", value: "0"),
            URLQueryItem(name: "v", value: version)
            
        ]
        
        guard let myURL = components.url else { return }
        
        var request = URLRequest(url: myURL)
        request.method = .get
        
        session.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error as Any)
            }
            
            guard let data = data else { return }
            
            do {
                let items = try JSON(data)["response"]["items"].rawData()
                let friends =  try JSONDecoder().decode([FriendPhotos].self, from: items)
                DispatchQueue.main.async {
                    completion(friends)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
