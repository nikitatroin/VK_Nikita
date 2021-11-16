//
//  AuthVC.swift
//  VK_Nikita
//
//  Created by Никита Троян on 20.10.2021.
//

import UIKit
//импортируем библиотеку для работы с WebView
import WebKit
import Alamofire

//класс conform WKNavigationDelegate
class AuthVC: UIViewController, WKNavigationDelegate {
    //drag and drop webView, так как мы подписаны на WKNavigationDelegate, то мы прописываем, что мы его делегат
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // чтобы каждый раз не запрашивать token, можем при загрузки view проверять сохранён ли у нас текущий token (и не протух ли он), проверяем userId и сразу заходим в приложение
        // Session.shared.expDate.compare(Date()) == .orderedDescending
        // проверка на валидатность tokena, мы получаем ответ в миллисекундах, их нужно перевести в дату(то есть сегодняшняя дата + 1 день), до которой есть доступ к серверу, сохранить это значение и сравнить наступила ли эта да или нет, если да, сбрасываем дату, ставим новый token и ставим новую дату.
        
        
        if !Session.shared.token.isEmpty, !Session.shared.userId.isEmpty {
            let vc = R.Storyboard.Tabbar.instantiateInitialViewController()
            if let vc = vc as? TabBarViewController {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
        
        
        loadWebView()
    }
    //разобрали запрос на компоненты, протокол, хост, путь и параметры, чтобы получить token с правом доступа к пользовательским данным
    private func loadWebView() {
        var urlComponents1 = URLComponents()
        urlComponents1.scheme = "https"
        urlComponents1.host = "oauth.vk.com"
        urlComponents1.path = "/authorize"
        urlComponents1.queryItems = [
            URLQueryItem(name: "client_id", value: "7981067"),// id созданного приложение через VK
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"), // права приложения, к каким папкам он будет иметь доступ
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.81"),
            URLQueryItem(name: "revoke", value: "1")// полезная фича для деббага
        ]
        
        let request = URLRequest(url: urlComponents1.url!)
        
        self.webView.load(request)
    }
    
    //реализуем метод, который перехватывает ответы от сервера
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        // проверяем получили ли мы url от сервера, url будет такого вида:
        /* https://oauth.vk.com/blank.html#access_token=7fed1fae493c4221e08596b48012882394a45ac2ed401853788d05edfdbac8c22f60889b45bfe1aa0d412&expires_in=86400&user_id=535765437
         */
        //следует запомнить, что фрагмент url всегда идёт после #
        //затем на нужен разделить оставшуюся строку на ключ-значение
        //ключи: access_token, expires_in, user_id
        
        
        //проверяем полученный url от перехода, если в нём содерживаться url, которую нам нужно обработать, то останавливаем переход
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            // если url нету, то осуществляем переход
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")// получаем фрагмент, разбиваем по символу
            .map{$0.components(separatedBy: "=")} // ещё раз разбиваем по символу (появляется вложенный массив строк)
            .reduce([String:String]()) { result, param in //result - желанный словарь, param это массив во вложенном массиве, внутри каждого массива обращаемся к чётному и не чётному элементу, первый это ключ, второй будет значение
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        //проверяем url на наличие токена
        guard let token = params["access_token"], let userId = params["user_id"], let expDate = params["expires_in"] else {return}
        print(token)
        print(userId)
        print(expDate)
        
        //совершаем переход на tableView
        //performSegue(withIdentifier: "showFriendSegua", sender: nil)
        let vc = R.Storyboard.Tabbar.instantiateInitialViewController()
        if let vc = vc as? TabBarViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
        //закинули в session полученные от сервера данные
        Session.shared.token = token
        Session.shared.userId = userId
//        Session.shared.expDate = Date(timeIntervalSince1970: TimeInterval(Double(expDate) ?? 0))
        
        //если url получен
        decisionHandler(.cancel)
    }
    
}



