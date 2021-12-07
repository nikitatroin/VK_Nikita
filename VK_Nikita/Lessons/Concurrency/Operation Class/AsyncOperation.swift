//
//  GetDataOperation.swift
//  VK_Nikita
//
//  Created by Никита Троян on 06.12.2021.
//
import Alamofire
import UIKit

class AsyncOperation: Operation {
    
    //вручную описываем три состояния операции
    enum State:String {
    case ready, executing, finished
        fileprivate var keyPath: String {
            "is" + rawValue.capitalized
        }
    }
    
    //Добавили слушателелей для нашего свойства, они будут отправлять KVO уведомления, что свойство собирается изменяться и что свойство уже изменилось
     var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    
    //ставим влажок, чтобы наша задача выполнялась асинхронно
    override var isAsynchronous: Bool {
        true
    }
    
    //проверяем оба состояние, как у родительского класса, так и у нашего, чтобы оба они были .ready, учитываем их
    // pending, ready, executing, finished, canceled
    override var isReady: Bool {
        super.isReady && state == .ready
    }
    
    //также проверяем остальные состояние
    override var isExecuting: Bool {
        state == .executing
    }
    
    override var isFinished: Bool {
        state == .finished
    }
    //теперь мы можем вручную управлять состояниями операции, пока мы не напишем состояние .finished свойству state, операция не завершится
    

    
    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }
    
    //при вызове метода, сначала отменяется запрос в сеть, вызываем отмену у родительского класса, и переводим наш state положение завершенного
    override func cancel() {
        super.cancel()
        state = .finished
    }
}



