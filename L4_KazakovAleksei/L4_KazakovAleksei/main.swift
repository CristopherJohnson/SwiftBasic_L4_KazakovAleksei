//
//  main.swift
//  L4_KazakovAleksei
//
//  Created by Алексей Казаков on 02/12/2018.
//  Copyright © 2018 Алексей Казаков. All rights reserved.
//

import Foundation

enum ChiksInCar { //наличие девушек в машине
    case Yes, No
}

enum CarBrand {
    case Mercedes
    case BMW
    case Mazda
    case Man
}

enum EngineStatus { //включен или выключен двигатель
    case on, off
}

enum WindowStatus {
    case opened, closed
}

enum HatchStatus { // люк открыт или закрыт. перечисление действительно только для спортивной машины
    case opened, closed
}

enum TrailerStatus { // статус прицепа. перечисление действительно только для грузовика
    case connected, disconnected
}

class Car {
    let brand: CarBrand
    let yearOfManufactory: Int
    var engineStatus: EngineStatus
    var windowStatus: WindowStatus{ // для удобства проверки воспользуюсь willset и оповещениями
        willSet {
            if newValue == .opened {
                print("Окна открываются")
            } else {
                print("Окна закрываются")
            }
        }
    }
    var chicks: ChiksInCar
    init(brand: CarBrand, yearOfManufactory: Int, engineStatus: EngineStatus, windowStatus: WindowStatus, chicks: ChiksInCar) {
        self.brand = brand
        self.yearOfManufactory = yearOfManufactory
        self.engineStatus = engineStatus
        self.windowStatus = windowStatus
        self.chicks = chicks
    }
    
    func getSomeChicks() { //добавляем девушек в машину. потом буду изменять эту функцию в наследниках
        self.chicks = .Yes
    }
    
    func windowAction (newStatus: WindowStatus){ // действия с окнами. не будет меняться в наследниках
        switch newStatus {
        case .opened:
            self.windowStatus = .opened
        case .closed:
            self.windowStatus = .closed
        }
    }
}

class SportCar: Car {
    var hatch: HatchStatus{ // так же для удобства отслеживания воспользуюсь willset
        willSet {
            if newValue == .opened {
                print("Люк открывается")
            } else {
                print("Люк закрывается")
            }
        }
    }
    init(brand: CarBrand, yearOfManufactory: Int, engineStatus: EngineStatus, windowStatus: WindowStatus, chicks: ChiksInCar, hatch: HatchStatus) {
        self.hatch = hatch
        super.init(brand: brand, yearOfManufactory: yearOfManufactory, engineStatus: engineStatus, windowStatus: windowStatus, chicks: chicks)
    }
    
    func hatchAction (newStatus: HatchStatus){ //действия с новой переменной люк в наследнике
        switch newStatus {
        case .opened:
            self.hatch = .opened
        case .closed:
            self.hatch = .closed
        }
    }
    
    override func getSomeChicks() { // немного модифицирую функцию
        super.getSomeChicks()
        print("К вам присоединились прекрасные дамы! Поздравляем!")
    }
    
}

class TrunkCar: Car{
    var trailer: TrailerStatus {
        willSet {
            if newValue == .connected {
                print("Прицеп сейчас присоединится")
            } else {
                print("Отсоединяем прицеп")
            }
        }
    }
    init(brand: CarBrand, yearOfManufactory: Int, engineStatus: EngineStatus, windowStatus: WindowStatus, chicks: ChiksInCar, trailer: TrailerStatus) {
        self.trailer = trailer
        super.init(brand: brand, yearOfManufactory: yearOfManufactory, engineStatus: engineStatus, windowStatus: windowStatus, chicks: chicks)
    }
    
    func trailerAction (newStatus: TrailerStatus){ // действия с новой переменной прицеп
        switch newStatus{
        case .connected:
            self.trailer = .connected
        case .disconnected:
            self.trailer = .disconnected
        }
    }
    
    override func getSomeChicks() { // делаю невозможным добавить девушек в грузовик
        print("Несмотря на неоспоримую крутость Вашего грузовика, ни одна девушка не решилась составить Вам компанию. Сочувствуем :(")
    }
}

var sportCar = SportCar(brand: .Mercedes, yearOfManufactory: 2018, engineStatus: .on, windowStatus: .closed, chicks: .No, hatch: .closed)
var trunk = TrunkCar(brand: .Man, yearOfManufactory: 1998, engineStatus: .off, windowStatus: .opened, chicks: .No, trailer: .disconnected)

sportCar.windowAction(newStatus: .opened)
sportCar.hatchAction(newStatus: .opened)
sportCar.getSomeChicks()
trunk.windowAction(newStatus: .closed)
trunk.trailerAction(newStatus: .connected)
trunk.getSomeChicks()

print("Легковая машина: бренд: \(sportCar.brand), год выпуска: \(sportCar.yearOfManufactory), статус двигателя \(sportCar.engineStatus), статус окон: \(sportCar.windowStatus), наличие девушек в машине: \(sportCar.chicks), состояние люка: \(sportCar.hatch)")

print("Грузовая машина: бренд: \(trunk.brand), год выпуска: \(trunk.yearOfManufactory), статус двигателя: \(trunk.engineStatus), статус окон: \(trunk.windowStatus), наличие девушек в машине: \(trunk.chicks), статус прицепа: \(trunk.trailer)")
