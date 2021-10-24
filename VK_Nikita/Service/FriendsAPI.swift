//
//  FriendsAPI.swift
//  VK_Nikita
//
//  Created by Никита Троян on 23.10.2021.
//

import UIKit
import Alamofire

final class FriendsApi {
    
    // MARK: - Base URL Config
    let baseUrl = "https://api.vk.com/method"
    let version = "5.81"
    
    // MARK: - Get friends method
    func getFriends(completion: @escaping([User])->()) {
        
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
            URLQueryItem(name: "fields", value: "nickname"),
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
    
    // MARK: - Get groups method
    func getGroups(completion: @escaping([User])->()) {
        
        let token = Session.shared.token
        let userId = Session.shared.userId
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/groups.get"
        components.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "filter", value: ""),
            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "v", value: version),
            URLQueryItem(name: "fields", value: ""),
            URLQueryItem(name: "extended", value: "1"),
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

    // MARK: - Alamofire get groups method
    func getGruopsAlamofire (completion: @escaping([User])->()) {
        let token = Session.shared.token
        let userId = Session.shared.userId
        let method = "/groups.get"
        let parameters: Parameters = [
            "user_id": userId,
            "filter": "",
            "fields": "",
            "count": "3",
            "access_token": token,
            "v": version,
            "extended":"1",
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            guard let json = try? JSONSerialization.jsonObject(with: response.data!, options: []) else { return }
            print(json)
        }
        
    }
    
    // MARK: - Get groups searching method
    func getGroupsSeatch(completion: @escaping([User])->()) {
        
        let token = Session.shared.token
        let userId = Session.shared.userId
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/groups.search"
        components.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "q", value: "Music"),
            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "v", value: version),
            URLQueryItem(name: "offset", value: "3"),
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
