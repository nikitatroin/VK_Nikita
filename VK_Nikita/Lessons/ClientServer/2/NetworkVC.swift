//
//  NetworkVC.swift
//  VK_Nikita
//
//  Created by Никита Троян on 19.10.2021.
//

import UIKit
import Alamofire
/*
class NetworkVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sendGetRequest()
        
        //sendGetRequestURLDefaultConfig()
        
        //sendGetRequestURLComponents()
        
        //sendPostRequestURLComponents()
        
        //sendGetRequestAlamofire()
        
        //sendPostRequestAlamofire()
        
    }

    
    private func sendPostRequestAlamofire() {
        
        guard let url = URL(string: "http://jsonplaceholder.typicode.com/posts") else { return }
        
        let parameters: Parameters = [
            "title":"foo",
            "body":"bar",
            "userId":"1",
        ]
        
        Session.custom.request(url, method: .post,parameters: parameters).responseJSON {response in
            print(response.value as Any)
        }
        
    }
    
    private func sendGetRequestAlamofire() {
        
        guard let url = URL(string: "http://samples.openweathermap.org/data/2.5/forecast") else { return }
        
        //написали запрос через AF, вручную добавили параметры
        let parameters:Parameters = [
            "q":"Moscow,DE",
            "appid":"b1b15e88fa797225412429c1c50c122a1"
        ]
        
        //обратились к sessionManager, вызвали свой кастомный профиль, добавили в request url и параметры
        Session.custom.request(url, parameters: parameters).responseJSON {response in
            print(response.value as Any)
        }
    }
    
    private func sendPostRequestURLComponents () {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "http"
        urlComponents.host = "jsonplaceholder.typicode.com"
        urlComponents.path = "/posts"
        urlComponents.queryItems = [
            URLQueryItem(name: "title", value: "foo"),
            URLQueryItem(name: "body", value: "bar"),
            URLQueryItem(name: "userId", value: "1")
        ]
        
        guard let url = urlComponents.url else { return }
        
        // создаём запрос
        var request = URLRequest(url: url)
        //указываем метод
        request.httpMethod = "POST"
        
        let task = session.dataTask(with: request) { data, response, error in
            let json = try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
            print(json as Any)
        }
        task.resume()
    }
    
    
    //самый правильный способ составления запроса, разбивая URL на разные компоненты
    private func sendGetRequestURLComponents() {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var components = URLComponents()
        
        //"http://
        //samples.openweathermap.org
        //data/2.5/forecast?
        //q=München,DE
        //&appid=b1b15e88fa797225412429c1c50c122a1"
        
        // протокол
        components.scheme = "http"
        // хост
        components.host = "samples.openweathermap.org"
        // путь где лежит нужная нам информация
        components.path = "data/2.5/forecast"
        // параметры
        components.queryItems = [
            URLQueryItem(name: "q", value: "München,DE"),
            URLQueryItem(name: "appid", value: "b1b15e88fa797225412429c1c50c122a1")
        ]
        
        guard let url = components.url else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
            
            print(json as Any)
        }
        
        task.resume()
        
    }
    
    
    //более правильный способ
    private func sendGetRequestURLDefaultConfig() {
        // создаём собственную конфигурацию, данная конфигурация позволяет нам:
        //use disk-based cache, stores credentials in keychain, stores cookies
        // хранить кэш, хранить ключ - пользователь, хранить кукис с сервера
        let configuration = URLSessionConfiguration.default
        // создаём собственную сессию
        let session = URLSession(configuration: configuration)
        // создаём URL из строки
        guard let url = URL(string: "http://samples.openweathermap.org/data/2.5/forecast?q=Moscow,DE&appid=b1b15e88fa797225412429c1c50c122a1") else { return }
        // создаём задачу для запуска получения
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) else {return}
            print(json)
        }
        // запускаем задачу
        task.resume()
    }
    
    //неправильный способ, но для начала сойдёт
    private func sendGetRequest() {
        //создаём URL из строки
        guard let url = URL(string: "http://samples.openweathermap.org/data/2.5/forecast?q=Moscow,DE&appid=b1b15e88fa797225412429c1c50c122a1") else { return }
        
        //создаём сессию
        let session = URLSession.shared //singleton
        
        //создаём task, GET запрос с сервера, который получает информацию
        let task = session.dataTask(with: url) { data, response, error in
            //в замыкании при преобразуем полученные данные от сервера с json
            guard let data = data else {
                return
            }
            // try? используется для обработки ошибок
            let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            //выводим в консоль json
            print(json as Any)
        }
        //запускаем задачу
        task.resume()
    }
    
    
    
}
// Добавляем AF класс Session для хранения своего менеджера
extension Session {
    static let custom: Session = {
        // конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        // добавляем http headers из уже предустановленных в AF
        configuration.httpAdditionalHeaders = Session.default.sessionConfiguration.httpAdditionalHeaders
        // установили конифигурации
        let sessionManager = Session(configuration: configuration)
        // вернули значение
        return sessionManager
    }()
    
 }
 */
