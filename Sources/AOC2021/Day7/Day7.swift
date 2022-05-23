//
//  Day7.swift
//  AOC2021
//
//  Created by Trey Carpenter on 12/7/21.
//

import Foundation

public class Day7: Day {
    public override func part1() -> String {
        let crabXPos = Input().numbersCsv(name: "Day7Input.txt", year: "2021")
        
        let median = Int(crabXPos.median()!)
        let totalFuel = crabXPos.map { abs($0 - median) }.reduce(0, +)
        return "\(totalFuel)"
    }
    
    public override func part2() -> String {
        let crabXPos = Input().numbersCsv(name: "Day7Input.txt", year: "2021")
        
        let average = Int(crabXPos.reduce(0, +) / crabXPos.count)
        let totalFuel = crabXPos.map { abs($0 - average)*(abs($0 - average) + 1)/2 }.reduce(0, +)
        
        return "\(totalFuel)"
    }
}

extension Array where Element == Int {
    func median() -> Double? {
        guard count > 0  else { return nil }

        let sortedArray = self.sorted()
        if count % 2 != 0 {
            return Double(sortedArray[count/2])
        } else {
            return Double(sortedArray[count/2] + sortedArray[count/2 - 1]) / 2.0
        }
    }
}
