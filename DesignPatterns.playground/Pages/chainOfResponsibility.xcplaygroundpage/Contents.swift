//: [Previous](@previous)

import Foundation

// chain of responsibility design pattern

// basically, you check the first handler if it can handle this event, if it can not then pass it to next handler..so on.

// each handler should know who is their succesor.

// let's try to design ATMMoney dispenser module

// out ATM has 100Rs, 500Rs, 2000Rs notes

// this protocol should be imlemented by class, since we have a muttaing behaviour inside extension.
protocol ATMMoneyDespensable: AnyObject {

    var successor: ATMMoneyDespensable? { get set }

    func handle(for amount: Int)
    func setSuccesor(next chain: ATMMoneyDespensable)


}

extension ATMMoneyDespensable {
    
    func setSuccesor(next chain: ATMMoneyDespensable) {
        self.successor = chain
    }
    
    func handle(for amount: Int) {
        self.successor?.handle(for: amount)
    }
    
}

class TwoKMoneyHandler: ATMMoneyDespensable {
 
    var successor: ATMMoneyDespensable? = nil
    
    init() {
        // let's set the successor here
        successor = FiveHMoneyHandler()
    }
    
    func handle(for amount: Int) {
        if amount >= 2000 {
            print("Withdrawn 2000 Rs")
            let remainder = amount % 2000
            self.successor?.handle(for: remainder)
        } else {
            self.successor?.handle(for: amount)
        }
    }

}

class FiveHMoneyHandler: ATMMoneyDespensable {
  
    var successor: ATMMoneyDespensable? = nil
    
    init() {
        successor = OneHMoneyHandler()
    }
    
    func handle(for amount: Int) {
        if amount >= 500 {
            print("Withdrawn 500 Rs")
            let remainder = amount % 500
            self.successor?.handle(for: remainder)
        } else {
            self.successor?.handle(for: amount)
        }
    }

}

class OneHMoneyHandler: ATMMoneyDespensable {
  
    var successor: ATMMoneyDespensable? = nil
    
    init() {}
    
    func handle(for amount: Int) {
        if amount >= 100 {
            print("Withdrawn 100 Rs")
            let remainder = amount % 100
            if remainder > 0 {
                print("Could not withdraw this amount -- \(remainder).")
            }
            self.successor?.handle(for: remainder)
        } else {
            print("Could not withdraw this amount -- \(amount).")
        }
    }

}

class ATM {

    var handler: ATMMoneyDespensable
    
    init(with handler: ATMMoneyDespensable) {
        // client is only aware of one handler
        self.handler = handler
    }
    
    func withdraw(_ amount: Int) {
        handler.handle(for: amount)
    }

}

let atm = ATM(with: TwoKMoneyHandler())
atm.withdraw(2560)

//: [Next](@next)
