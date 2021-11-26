//
//  Day1.swift
//  AOC
//
//  Created by Trey Carpenter on 11/25/21.
//

import Foundation

public class Day1: Day {
    
    public override func part1() -> String {
        let numbers = Input().numbers(name: "Day1Input.txt", year: "2018")

        let result = numbers.reduce(0, +)
        return "\(result)"
    }
    
    public override func part2() -> String {
        let numbers = Input().numbers(name: "Day1Input.txt", year: "2018")
        var count = 0
        var uniqueResult = Set<Int>()
        var answer = 0
        
        while answer == 0 {
            numbers.forEach { number in
                guard answer == 0 else { return }
                
                let newResult = count + number
                if uniqueResult.contains(newResult) {
                    answer = newResult
                }
                count = newResult
                uniqueResult.insert(count)
            }
        }
        return "\(answer)"
    }
}
