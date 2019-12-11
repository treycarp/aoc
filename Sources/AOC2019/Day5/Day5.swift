//
//  Day5.swift
//  AOC
//
//  Created by Trey Carpenter on 12/9/19.
//

import Foundation

public class Day5: Day {

    public override func part1() -> String {
        let numbers = Input().numbersCsv(name: "Day5Input.txt")
        let result = runIntcode(input: 1, in: numbers)
        return "Part 1 result: \(result)"
    }
    
    public override func part2() -> String {
        let numbers = Input().numbersCsv(name: "Day5Input.txt")
        let result = runIntcode(input: 5, in: numbers)
        return "Part 2 result: \(result)"
    }
    
    func runIntcode(input: Int, in memory:[Int]) -> Int {
        let mem = memory
        let intcode = Intcode(memory: mem)
        intcode.io = input
        return intcode.run()
    }
}
