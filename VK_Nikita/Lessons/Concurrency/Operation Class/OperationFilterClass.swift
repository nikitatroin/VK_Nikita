//
//  OperationClass.swift
//  VK_Nikita
//
//  Created by Никита Троян on 05.12.2021.
//
import UIKit
//класc Operation выполняется в отдельной очереди
final class BlurImageOperation: Operation {
    //существует входящее и исходящее изображение
    var inputImage: UIImage
    var outputImage: UIImage?
    
    //переопределяем метод, вписываем нашу логику
    override func main() {
        // перевели изображение в CI формат
        let inputCIImage = CIImage(image: inputImage)
        // создаём фильтр
        let filter = CIFilter(name: "CIGaussianBlur", parameters: [kCIInputImageKey:inputCIImage!])
        // получаем CI изображение на выходе
        let outputCIImage = filter?.outputImage
        // создаем CI контекст
        let context = CIContext()
        // вынимаем изображение из контекста
        let cgiImage = context.createCGImage(outputCIImage!, from: outputCIImage!.extent)
        // устанавливаем его как свойство
        outputImage = UIImage(cgImage: cgiImage!)
    }
    
    init(image:UIImage){
        self.inputImage = image
        super.init()
    }
}
