//
//  NewsAPI.swift
//  VK_Nikita
//
//  Created by Никита Троян on 23.11.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

final class NewsApi {
    // MARK: - Base URL Config
    let baseUrl = "https://api.vk.com/method"
    let version = "5.81"
    
    // MARK: - Get groups method
    func getNews(completion: @escaping ([NewsItem]?)->() ) {
        
        let token = Session.shared.token
        let userId = Session.shared.userId
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/newsfeed.get"
        components.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "userId", value: userId),
            URLQueryItem(name: "filters", value: "post, wall_photo, audio, video"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "v", value: version),
            URLQueryItem(name: "max_photos", value: "10"),
        ]
        
        guard let myURL = components.url else { return }
        
        var request = URLRequest(url: myURL)
        request.method = .get
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error as Any)
            }
            guard let data = data else { return }
            debugPrint(data.prettyJSON as Any)
            
            do {
                let newsResponse = try JSONDecoder().decode(NewsModel.self, from: data)
                let news = newsResponse.response.items
                completion(news)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
