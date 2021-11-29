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
    func getNews(completion: @escaping (Result<[Item]?, NSError>)->() ) {
        
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
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "1"),
            URLQueryItem(name: "v", value: version),
            URLQueryItem(name: "max_photos", value: "1"),
        ]
        
        guard let myURL = components.url else { return }
        
        var request = URLRequest(url: myURL)
        request.method = .get
        //debugPrint(myURL as Any)
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error as Any)
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode >= 300 {
                print(response)
            }
                
            guard let data = data else { return }
            debugPrint(data.prettyJSON as Any)
            
            do {
                let newsResponse = try JSONDecoder().decode(News.self, from: data)
                let items = newsResponse.response?.items
                completion(.success(items))
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    //универсальный метод
    func fetchData<T: Decodable>(url: String, responseClass: T.Type , completion:@escaping (Result<T?, NSError>) -> Void) {
            AF.request(url, method: .get, parameters: [:], headers: [:]).responseJSON { (response) in
                guard let statusCode = response.response?.statusCode else { return }
                if statusCode == 200 { // Success
                    guard let jsonResponse = try? response.result.get() else { return }
                    guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else { return }
                    guard let responseObj = try? JSONDecoder().decode(T.self, from: theJSONData) else { return }
                    completion(.success(responseObj))
                }
            }
        }
}
