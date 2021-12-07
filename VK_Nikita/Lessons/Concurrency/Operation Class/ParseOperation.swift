//
//  ParseOperation.swift
//  VK_Nikita
//
//  Created by Никита Троян on 06.12.2021.
//

import UIKit
import SwiftyJSON

final class ParseOperation: Operation {
    //здесь будем хранить распарсенные данные
    var outputData: [Post] = []
    
    // здесь основная логика
    override func main() {
        //проверяем зависимость от класса, который выполняет запрос
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              //полученные данные от предыдущей операции кладём в новую переменую
              let data = getDataOperation.data else { return }
        //с помощью swiftyJSON проходимся по полученным данным и вынимаем нужные строки
        let json = try! JSON(data:data)
        let posts: [Post] = json.compactMap {
            let id = $0.1["id"].intValue
            let title = $0.1["title"].stringValue
            let body = $0.1["body"].stringValue
            return Post(id: id, title: title, body: body)
        }
        self.outputData = posts
    }
}
