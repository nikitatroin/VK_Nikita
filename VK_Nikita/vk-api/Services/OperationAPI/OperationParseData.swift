//
//  OperationParseData.swift
//  VK_Nikita
//
//  Created by Никита Троян on 07.12.2021.
//

import Foundation

class OperationParseData: Operation {
    var outputData:[Items] = []
    
    override func main() {
        guard let operationGetNews = dependencies.first as? GetNewsOperation,
                let data = operationGetNews.data else {return}
        
        let newsFedd = try? JSONDecoder().decode(NewsFedd.self, from: data)
        let item = newsFedd?.response.items
        print(item as Any)
        outputData = item!
    }
}
