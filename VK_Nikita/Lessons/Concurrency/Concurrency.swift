//
//  L1.swift
//  VK_Nikita
//
//  Created by Никита Троян on 25.11.2021.
//

import Foundation
import UIKit

final class Concurrency: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //dataLeaks()
        //asyncCall()
        //thread.start()
        
    }
    
    let thread = Thread {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            print(Date(), Thread.current)
        }
        RunLoop.current.run()
    }
    
    
    func dataLeaks() {
        print("start test")
        autoreleasepool {
            for index in 0...UInt.max {
                let string = NSString(format: "test + %d", index)
                print(string)
            }
        }
        print("end test")
    }
    
    func asyncCall() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { _ in
            print(Date(),Thread.current)
        }
        
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            print("1", Thread.current)
            sleep(1)
        }
    }
    
}

