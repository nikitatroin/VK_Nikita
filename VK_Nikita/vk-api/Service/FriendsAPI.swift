//
//  FriendsAPI.swift
//  VK_Nikita
//
//  Created by Никита Троян on 23.10.2021.
//

import UIKit
import Alamofire
import SwiftyJSON


final class FriendsApi {
    
    // MARK: - Base URL Config
    let baseUrl = "https://api.vk.com/method"
    let version = "5.81"
    
    // MARK: - Get friends method use Codable + SwiftyJSON
    func getFriends4URLSession(completion: @escaping([Friend4])->()) {
        
        let token = Session.shared.token
        let userId = Session.shared.userId
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/friends.get"
        components.queryItems = [
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "photo_50, photo_100"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: version),
        ]
        
        guard let myURL = components.url else { return }
        
        var request = URLRequest(url: myURL)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print(error.debugDescription as Any)
            }
            
            guard let data = data else { return }

            
            do {
                //смешанный способ, создаём цепочку с помощью SwiftyJSON, добираемся до нужного нам объекта, получаем его rawData
                let items = try JSON(data)["response"]["items"].rawData()
                // затем, чтобы работать с ним, используем Decoder, type - наша структура (важно заметить в виде массива, получаем Dat'у из SwiftyJSON)
                let friends =  try JSONDecoder().decode([Friend4].self, from: items)
                DispatchQueue.main.async {
                    completion(friends)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
/*
    // MARK: - Get friends method use Codable
    func getFriends3URLSession(completion: @escaping([Friend3])->()) {
        
        let token = Session.shared.token
        let userId = Session.shared.userId
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/friends.get"
        components.queryItems = [
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "photo_50, photo_100"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: version),
            URLQueryItem(name: "lang", value: "3"),
        ]
        
        guard let myURL = components.url else { return }
        
        var request = URLRequest(url: myURL)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print(error.debugDescription as Any)
            }
            
            guard let data = data else { return }
            print(data.prettyJSON as Any)
            
            do {
                let items =  try JSONDecoder().decode(FriendJSON.self, from: data)
                let friends = items.response.items
                
                DispatchQueue.main.async {
                    completion(friends)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    // MARK: - Get friends method use AF and SwiftyJSON
    func getFriends2URLSession(completion: @escaping([Friend2])->()) {
        
        let token = Session.shared.token
        let userId = Session.shared.userId
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/friends.get"
        components.queryItems = [
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "photo_50, photo_100"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: version),
        ]
        
        guard let myURL = components.url else { return }
        
        var request = URLRequest(url: myURL)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print(error.debugDescription as Any)
            }
            
            guard let data = data else { return }
            print(data.prettyJSON as Any)
            
            do {
               // синтаксис SwiftyJSON, создаём объект, который принимает бинарник, обращаемся к нужным нам ключам, оборачиваем всё в массив
                guard let items = JSON(data)["response"]["items"].array else { return }
                // проходимся по массиву, чтобы заполнить нашу переменную
                let friends = items.map { Friend2(json: $0) }
                
                DispatchQueue.main.async {
                    completion(friends)
                }
            }
        }.resume()
        
    }
    
    // MARK: - Get friends method use AF and JSON Serialization
    func getFriendsAlamofire(completion: @escaping([Friend1])->()) {
        
        let token = Session.shared.token
        let userId = Session.shared.userId
        
        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "order": "name",
            "fields": "photo_50, photo_100",
            "count": 10,
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            guard let data = response.data else { return }
            
            debugPrint(response.data?.prettyJSON as Any)
            
            do {
                
                let jsonContainer: Any =  try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                let object = jsonContainer as! [String: Any]
                
                let response = object["response"] as! [String: Any]
                
                let items = response["items"] as! [Any]
                
                let friends = items.map { Friend1(item: $0 as! [String: Any]) }
                completion(friends)
                
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - Get friends method use URLSession and JSON Serialization
    func getFriendsURLSession(completion: @escaping([Friend1])->()) {
        
        let token = Session.shared.token
        let userId = Session.shared.userId
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/friends.get"
        components.queryItems = [
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "photo_50, photo_100"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: version),
        ]
        
        guard let myURL = components.url else { return }
        
        var request = URLRequest(url: myURL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error as Any)
            }
            // проверяем бинарник который к нам пришёл, вытаскиваем его из опционала
            guard let data = data else { return }
            // отлавливаем ошибки при получение JSON
            // try? если json нету, то возвращает nil и мы не узнаем, что за ошибка была, если мы пишем try и кладём метож в do - catch, то мы можем обработать ошибку
            do {
                let jsonContainer: Any = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers])
                print(data.prettyJSON as Any)
                // принудительно typeCasting наш объект
                let object = jsonContainer as! [String: Any]
                // далее тоже самое с
                let response = object["response"] as! [String: Any]
                
                let items = response["items"] as! [Any]
                //контейнер для друзей
                var friends: [Friend1] = []
                
                for item in items {
                    //создали экземпляр нашего объекта
                    //интересное место, мы создали экземпляр структуры, он создаётся через init, в item хранится вся инфа про друга, item это объект, который имеет тип [String:Any], где String это id, name etc, и значение это либо String, либо Image (в нашем случае), в item может существовать и больше ключей и значений, но мы во время init вытаскиваем только те, которые нужны нам для нашей структуры.
                    let friend = Friend1(item: item as! [String:Any])
                    friends.append(friend)
                    DispatchQueue.main.async {
                        completion(friends)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
*/

