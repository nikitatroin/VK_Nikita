//
//  TestTasksViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 21.11.2021.
//

import UIKit

// MARK: - task8
protocol MyProtocol {
    //если метод прописан в протоколе, то класc обязан его выполнить, значит будет вызваться функция класса
    func sayHello()
    //если же реализация функции прописана написана в extension, то когда мы определяем тип экземпляра как протокол и приравниваем его к классу, то подтягивается функция из extension, а не из класса, потому что у неё преоритет выше
}

extension MyProtocol {
    func sayHello() {
        print("Hello protocol!") // если реализовали логику метода в extension, то будет вызваться метод отсюда
    }
}

// суть задачки поменять диспетчерезацию
func task8() {
    
    class MyClass:MyProtocol {
        func sayHello() {
            print("Hello class!")
        }
    }
    
    let inst1 = MyClass()
    let inst2: MyProtocol = MyClass()
    
    
    inst1.sayHello() // так как класс реализует протокол, то сразу понятно, что это witness-table-dispath
    inst2.sayHello() // так как мы реализовали функцию через extension к протоколу, то будет direct dispath
    (inst2 as! MyClass).sayHello() // здесь мы жёстко присавиваем класс, поэтому
    
    //чтобы выполнить метод Hello Class, нужно поменять диспетчерезацию
    
}

// MARK: - task9
func task9() {
    class RootClass: MyProtocol {
        func sayHello() {
            print("Hello root class!")
        }
    }
    class CustomClass: RootClass {
        override func sayHello() {
            print("Hello custom class!")
        }
    }
    let inst = CustomClass() // custom
    let inst2: RootClass = CustomClass() // custom
    let inst3: MyProtocol = CustomClass() // custom
    
    inst.sayHello() // везде выведеться custom, потому что в протоколе реализована функция + в custom классе есть override, override по приоретету выше, чем другие методы
    inst2.sayHello() //
    inst3.sayHello() //
}

// MARK: - task10
protocol Printable: AnyObject {
    func print()
}

extension Printable {
    func print() {
        Swift.print("Protocol")
    }
}

func task10() {
    
    class A:Printable {} // extension - нету конкурентов
    
    class B: A {
        func print() { // extension > func
            Swift.print("I am 'B'")
        }
    }
                        
    class C: Printable { // witness > direct
        func print() {
            Swift.print("I am 'C'")
        }
    }
    
    let arr: [Printable] = [A(),B(),C()]
    
    arr.forEach{$0.print()} //1) Protocol 2) Protocol 3) I am 'C'
}

class TestTasksViewController: UIViewController {
 // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        task10()
    }
    // Decimal type need use in financial app
    func task1() {
        
        let a: Double = 1.000001 // Дробный тип = ( 1 + 1/100000 ) - 1/100000
        let b: Double = 0.000001
        let c = a - b
        print(c)
        
        
        let a1: Decimal = 1.000001 // Десятичный тип
        let b1: Decimal = 0.000001
        let c1 = a1 - b1
        
        print(c1)
        
    }
    
    func task2() {
        
        let val: Double = 1.0
        let a: Double = 1.000001
        let b: Double = 0.000001
        
        let arr: [Double] = [2.0, 3.0, 1, 4.0, 8.99, 1.00 * 1, a - b]
        var countOfVal: Int = 0
        
        for i in 0..<arr.count { // 7 раз, не доходя до 7-го, итого 6 раз
            if arr[i] == val { //
                countOfVal += 1
            }
        }
        
        print(countOfVal)
        
    }
    //High order function
    func task3() {
        struct Planet {
            var name:String
            var distanceFromSun: Double
        }
        
        let planets = [
            Planet(name: "Mercury", distanceFromSun: 0.387),
            Planet(name: "Venus", distanceFromSun: 0.722),
            Planet(name: "Earth", distanceFromSun: 1.0),
            Planet(name: "Mars", distanceFromSun: 1.52),
            Planet(name: "Jupiter", distanceFromSun: 5.20),
            Planet(name: "Saturn", distanceFromSun: 9.58),
            Planet(name: "Uranus", distanceFromSun: 19.2),
            Planet(name: "Neptune", distanceFromSun: 30.1),
        ]
        
        let result1 = planets.map{$0.name}
        let result2 = planets.reduce(0) { $0 + $1.distanceFromSun}
        
        print(result1)
        print(result2)
        
    }
    //Initializers task
    func task4() {
        final class Container {
            
            var arr: [Int] = [] {
                didSet {
                    print("Did set \(arr)") //при инициализации не вызывается
                }
            }
            
            init (arr:[Int]) {
                print("init")
                self.arr = arr
            }
            
            deinit {
                print("deinit")//после того как объект стал nil, нижнее строки не вызываются
                arr = [4]
            }
            
            func update() {
                arr.append(3)
            }
        }
        
        var container: Container? = Container(arr: [4])
        container?.arr = [2]
        container?.update()
        container = nil
    }
    
    func task5() {
        // Запомни классы и функции/closure это ссылочный тип, reference type
        // Все остальные элементы это тип значения, в том числе массивы, value type
        var foo = [420]
        let bar = foo
        foo[0] = 228
        debugPrint(bar[0])
    }
    
    func task6() {
        //ex1
        struct Tutorial {
            var dif: Int = 1
        }
        let tutorial1 = Tutorial()
        var tutorual2 = tutorial1
        tutorual2.dif = 2
        //ex2
        let arr1 = [1,2,3,4,5]
        var arr2 = arr1
        arr2.append(6)
        _ = arr1.count
    }
    
    func task7() {
        //ex1
        struct Calculator {
            var a: Int
            var b: Int
            var sum: Int {
                a + b
            }
        }
        var calculator = Calculator(a: 2, b: 3)
        let closure = {
            print("The calculator sum is \(calculator.sum)")
        }
        calculator.b = 20
        closure()
        
    }
}
