//: [Previous](@previous)

import Foundation

// chain of responsibility design pattern

// basically, you check the first handler if it can handle this event, if it can not then pass it to next handler..so on.

// each handler should know who is their succesor.

// let's try to design ATMMoney dispenser module

// out ATM has 100Rs, 500Rs, 2000Rs notes

protocol ATMMoneyDespensable {
    var successor: ATMMoneyDespensable? { get }

    func handle(for amount: Int)
    func setSuccesor(next chain: ATMMoneyDespensable)

}

class TwoKMoneyHandler: ATMMoneyDespensable {
  
    private(set) var successor: ATMMoneyDespensable? = nil
    
    init() {}
    
    func handle(for amount: Int) {
        if amount >= 2000 {
            print("Withdrawn 2000 Rs")
            let remainder = amount % 2000
            self.successor?.handle(for: remainder)
        } else {
            self.successor?.handle(for: amount)
        }
    }
    
    func setSuccesor(next chain: ATMMoneyDespensable) {
        self.successor = chain
    }

}

class FiveHMoneyHandler: ATMMoneyDespensable {
  
    private(set) var successor: ATMMoneyDespensable? = nil
    
    init() {}
    
    func handle(for amount: Int) {
        if amount >= 500 {
            print("Withdrawn 500 Rs")
            let remainder = amount % 500
            self.successor?.handle(for: remainder)
        } else {
            self.successor?.handle(for: amount)
        }
    }
    
    func setSuccesor(next chain: ATMMoneyDespensable) {
        self.successor = chain
    }

}

class OneHMoneyHandler: ATMMoneyDespensable {
  
    private(set) var successor: ATMMoneyDespensable? = nil
    
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
    
    func setSuccesor(next chain: ATMMoneyDespensable) {
        self.successor = chain
    }

}

let chain1 = TwoKMoneyHandler()
let chain2 = FiveHMoneyHandler()
let chain3 = OneHMoneyHandler()
chain1.setSuccesor(next: chain2)
chain2.setSuccesor(next: chain3)

chain1.handle(for: 2650)

//: [Next](@next)
