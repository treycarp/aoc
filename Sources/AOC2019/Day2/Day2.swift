//
//  Day2.swift
//  AOC
//
//  Created by Trey Carpenter on 12/9/19.
//

import Foundation

public class Day2: Day {
    
    public override func part1() -> String {
        let numbers = Input().numbersCsv(name: "Day2Input.txt", year: "2019")
        return String(runIntcode(for: 12, verb: 2, in: numbers))
    }
    
    public override func part2() -> String {
        let numbers = Input().numbersCsv(name: "Day2Input.txt", year: "2019")
        for noun in 0...100 {
            for verb in 0...100 {
                let result = runIntcode(for: noun, verb: verb, in: numbers)
                if result == 19690720 {
                    return String("Noun: \(noun)\nVerb: \(verb)\nResult: \(100 * noun + verb)")
                }
            }
        }
        return ""
    }
    
    func runIntcode(for noun: Int, verb: Int, in memory:[Int]) -> Int {
        var mem = memory.map { Int($0) }
        mem[1] = Int(noun)
        mem[2] = Int(verb)
        let intcode = Intcode(memory: mem)
        intcode.run()
        return intcode.memory[0]
    }
}
