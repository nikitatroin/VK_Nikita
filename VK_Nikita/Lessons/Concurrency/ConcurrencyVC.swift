//
//  L1.swift
//  VK_Nikita
//
//  Created by Никита Троян on 25.11.2021.
//
import UIKit

final class ConcurrencyVC: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    
    private var loadedImages: [UIImage] = []
    
    
    private let imageURLs: [String] =
    ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
     "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg",
     "http://bestkora.com/IosDeveloper/wp-content/uploads/2016/12/Screen-Shot-2017-01-17-at-9.33.52-PM.png",
     "https://www.nawpic.com/media/2020/galaxy-background-nawpic-4.jpg"]
    
    private let url =  "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg"
    
    let dispatchGroup = DispatchGroup()
    
    private var image: UIImageView = {
        var image = UIImageView()
        image.frame = CGRect(x: 120, y: 200, width: 200, height: 200)
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        asyncGroup()
        //fetchImage3()
        //self.view.addSubview(image)
        //fetchImage2()
        //fecthImage1()
        //dataLeaks()
        //asyncCall()
        //thread.start()
        
    }
    
    func asyncGroup() {
        let group = DispatchGroup()
        //группа с асинхронными операциями
        for i in 0...3 {
            //вручную повышаем счётчик 
            group.enter()
            asyncLoadImage(imageURL: imageURLs[i],
                           runQueue: DispatchQueue.global(),
                           completionQueue: DispatchQueue.main) { image, error in
                guard let image = image else { return }
                self.loadedImages.append(image)
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            for i in 0..<1 {
                self.image1.image = self.loadedImages[i]
            }
            for i in 1..<2 {
                self.image2.image = self.loadedImages[i]
            }
            for i in 2..<3 {
                self.image3.image = self.loadedImages[i]
            }
            for i in 3..<4 {
                self.image4.image = self.loadedImages[i]
            }
        }
    }
    
    

    private func fetchImage3() {
        //формирование групп из синхронных операций
        for i in 0...1 {
            DispatchQueue.global(qos:.userInitiated).async(group: dispatchGroup) {
                let url = URL(string: self.imageURLs[i])
                let data = try? Data(contentsOf: url!)
                self.loadedImages.append(UIImage(data: data!)!)
            }
        }
        
        for i in 2...3 {
            DispatchQueue.global(qos: .userInitiated).async(group: dispatchGroup) {
                let url = URL(string: self.imageURLs[i])
                let data = try? Data(contentsOf: url!)
                self.loadedImages.append(UIImage(data: data!)!)
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            for i in 0..<1 {
                self.image1.image = self.loadedImages[i]
            }
            for i in 1..<2 {
                self.image2.image = self.loadedImages[i]
            }
            for i in 2..<3 {
                self.image3.image = self.loadedImages[i]
            }
            for i in 3..<4 {
                self.image4.image = self.loadedImages[i]
            }
        }
    }
    
    private func fecthImage1() {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            let url = URL(string: self.url)
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            } else {
                return
            }
        }
    }
    
    private func fetchImage2() {
        asyncLoadImage(imageURL: self.url, runQueue: DispatchQueue.global(qos: .background), completionQueue: DispatchQueue.main) { image, error in
            guard let image = image else { return }
            self.image.image = image
        }
    }
    
    private func asyncLoadImage(imageURL: String,
                                runQueue: DispatchQueue,
                                completionQueue:DispatchQueue,
                                completion: @escaping (UIImage?, Error?) ->() ) {
        runQueue.async {
            do {
                let url = URL(string: imageURL)
                let data = try Data(contentsOf: url!)
                completionQueue.async {
                    completion(UIImage(data: data), nil)
                }
            } catch {
                completion(nil, error)
            }
        }
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

