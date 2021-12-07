//
//  OperationGetNews.swift
//  VK_Nikita
//
//  Created by Никита Троян on 07.12.2021.
//

import Foundation
import Alamofire
import SwiftyJSON


class GetNewsOperation: AsyncOperation {
    var data: Data?
    var request = AFRequest()
    
    override func main() {
        DispatchQueue.global().async{
            AF.request(self.request.url!, method: .get, parameters: self.request.parameters).responseJSON { response in
                guard let data = response.data else {return}
                debugPrint(data.prettyJSON as Any)
                self.data = data
            }
        }
    }
    
    init(parameters:Parameters,url: String) {
        self.request.parameters = parameters
        self.request.url = url
        super.init()
    }
}
