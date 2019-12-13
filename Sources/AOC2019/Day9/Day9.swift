//
//  Day9.swift
//  AOC
//
//  Created by Trey Carpenter on 12/11/19.
//

import Foundation

public class Day9: Day {
    
    public override func part1() -> String {
        var memory: [Int] = []
        memory.reserveCapacity(Int(INT32_MAX))
        memory = Array(repeating: 0, count: Int(INT32_MAX))
        let input = Input().numbersCsv(name: "Day9Input.txt")
        for (index, element) in input.enumerated() {
            memory[index] = Int(element)
        }
        
        let intcode = Intcode(memory: memory)
        intcode.io = Int(1)
        return "Result Part 1: \(intcode.run())"
    }
    
    public override func part2() -> String {
        var memory: [Int] = []
        memory.reserveCapacity(Int(INT32_MAX))
        memory = Array(repeating: Int(0), count: Int(INT32_MAX))
        let input = Input().numbersCsv(name: "Day9Input.txt")
        for (index, element) in input.enumerated() {
            memory[index] = Int(element)
        }
        
        let intcode = Intcode(memory: memory)
        intcode.io = Int(2)
        return "Result Part 2: \(intcode.run())"
    }
}
