//
//  ReloadNews.swift
//  VK_Nikita
//
//  Created by Никита Троян on 07.12.2021.
//

import Foundation

class RelodNews: Operation {
    private var controller: NewsVC
    
    init(controller: NewsVC){
        self.controller = controller
    }
    
    override func main() {
        guard let dataController = dependencies.first as? OperationParseData else {return}
        self.controller.operationResponse = dataController.outputData
        self.controller.collectionView.reloadData()
    }
}
