//
//  Day8.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/8/20.
//

import Foundation

public class Day8: Day {
    public override func part1() -> String {
        let lines = Input().strings(name: "Day8Input.txt", year: "2020")
        
        var ops: [Operation] = lines.compactMap {
            let strings = $0.split(separator: " ")
            return Operation(instruction: Instruction(rawValue: String(strings[0]))!, argument: Int(String(strings[1]))!)
        }
        
        var accumulator = 0
        var currentIndex = 0
        var completed = false
        while !completed {
            guard !ops[currentIndex].visited else {
                completed = true
                continue
            }
            switch ops[currentIndex].instruction {
            case .nop:
                ops[currentIndex].visited = true
                currentIndex += 1
                continue
            case .acc:
                accumulator += ops[currentIndex].argument
                ops[currentIndex].visited = true
                currentIndex += 1
            case .jmp:
                ops[currentIndex].visited = true
                currentIndex += ops[currentIndex].argument
            }
        }
        
        return "Accumulator: \(accumulator)"
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day8Input.txt", year: "2020")
        
        var ops: [Operation] = lines.compactMap {
            let strings = $0.split(separator: " ")
            return Operation(instruction: Instruction(rawValue: String(strings[0]))!, argument: Int(String(strings[1]))!)
        }
        let originalOps = ops
        var answer = 0
        var foundAnswer = false
        var outerIndex = 0
        originalOps.forEach {
            guard !foundAnswer else { return }
            ops = originalOps
            guard $0.instruction == .jmp || $0.instruction == .nop else {
                outerIndex += 1
                return
            }
            ops[outerIndex].instruction = ops[outerIndex].instruction == .jmp ? .nop : .jmp
            var accumulator = 0
            var currentIndex = 0
            var infiniteLoop = false
            repeat {
                guard !ops[currentIndex].visited else {
                    infiniteLoop = true
                    break
                }
                
                if currentIndex == ops.count - 1 {
                    foundAnswer = true
                }
            
                switch ops[currentIndex].instruction {
                case .nop:
                    ops[currentIndex].visited = true
                    currentIndex += 1
                    continue
                case .acc:
                    accumulator += ops[currentIndex].argument
                    ops[currentIndex].visited = true
                    currentIndex += 1
                case .jmp:
                    ops[currentIndex].visited = true
                    currentIndex += ops[currentIndex].argument
                }
                
                if foundAnswer {
                    answer = accumulator
                }
    
            } while currentIndex <= ops.count - 1 && !infiniteLoop && !foundAnswer
            
            outerIndex += 1
        }
        
        return "Accumulator: \(answer)"
    }
}

struct Operation {
    var instruction: Instruction
    let argument: Int
    var visited: Bool = false
}

enum Instruction: String {
    case nop
    case acc
    case jmp
}
