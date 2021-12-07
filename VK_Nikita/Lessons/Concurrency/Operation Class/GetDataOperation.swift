//
//  GetDataOperation.swift
//  VK_Nikita
//
//  Created by Никита Троян on 06.12.2021.
//
import Alamofire
import UIKit

final class GetDataOperation: AsyncOperation {
    var data: Data?
    //забиваем запрос в сеть, который будет возвращать нам данные
    private var request: DataRequest
    //переопределили метод main, логика его такова, выполнив запрос, сохраняем данные в свойстве, ставим операцию как выполненную
    //не забываем, что запрос у AF всегда идут в main потоке, а нам нужна операция глобальной очереди
    init(request:DataRequest) {
        self.request = request
    }
    
    override func main() {
        request.responseData(queue:DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
    
    override func cancel() {
        request.cancel()
        super.cancel()
        super.state = .finished
    }
    
}
