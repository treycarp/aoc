//
//  Day1.swift
//  AOC
//
//  Created by Trey Carpenter on 12/9/19.
//

import Foundation

public class Day1 : Day {
    
    public override func part1() -> String {
        let numbers = Input().numbers(name: "Day1Input.txt", year: "2019")
        var sum = 0
        
        numbers.forEach {
            sum += calculate(number: $0)
        }
        
        return String(sum)
    }
    
    public override func part2() -> String {
        let numbers = Input().numbers(name: "Day1Input.txt", year: "2019")
        var sum = 0
        
        numbers.forEach {
            sum += compoundingCalculate(total: 0, amountToCalc: $0)
        }
        
        return String(sum)
    }
    
    func compoundingCalculate(total: Int, amountToCalc: Int) -> Int {
        var totalAmount = total
        if amountToCalc > 0 && calculate(number: amountToCalc) > 0 {
            totalAmount += calculate(number: amountToCalc)
            return compoundingCalculate(total: totalAmount, amountToCalc: calculate(number: amountToCalc))
        }
        
        return total
    }
    
    func calculate(number: Int) -> Int {
        number / 3 - 2
    }
}
