//
//  ReloadTableController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 06.12.2021.
//

import UIKit

final class ReloadTableController: Operation {
    var tableController: ConcurrencyTVC
    
    init(controller: ConcurrencyTVC) {
        self.tableController = controller
    }
    
    override func main() {
        guard let parseData = dependencies.first as? ParseOperation else { return }
        tableController.posts = parseData.outputData
        tableController.tableView.reloadData()
    }
}
