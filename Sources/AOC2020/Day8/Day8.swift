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
        
        let ops: [Operation] = lines.compactMap {
            let strings = $0.split(separator: " ")
            return Operation(instruction: Instruction(rawValue: String(strings[0]))!, argument: Int(String(strings[1]))!)
        }
        
        var accumulator = 0
        var currentIndex = 0
        var completed = false
        var seen = Set<Int>()
        while !completed {
            guard !seen.contains(currentIndex) else {
                completed = true
                continue
            }
            switch ops[currentIndex].instruction {
            case .nop:
                seen.insert(currentIndex)
                currentIndex += 1
                continue
            case .acc:
                accumulator += ops[currentIndex].argument
                seen.insert(currentIndex)
                currentIndex += 1
            case .jmp:
                seen.insert(currentIndex)
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
        var answer = 0
        for (index, op) in ops.enumerated() {
            guard op.instruction == .jmp || op.instruction == .nop else {
                continue
            }
            let instruction = ops[index].instruction
            ops[index].instruction = ops[index].instruction == .jmp ? .nop : .jmp
            if let theAnswer = doOp(ops: ops) {
                answer = theAnswer
                break
            }
            ops[index].instruction = instruction
        }
        
        return "Accumulator: \(answer)"
    }
    
    private func doOp(ops: [Operation]) -> Int? {
        var accumulator = 0
        var currentIndex = 0
        var seen = Set<Int>()
        while currentIndex <= ops.count - 1 {
            guard !seen.contains(currentIndex) else {
                break
            }
        
            switch ops[currentIndex].instruction {
            case .nop:
                seen.insert(currentIndex)
                currentIndex += 1
            case .acc:
                accumulator += ops[currentIndex].argument
                seen.insert(currentIndex)
                currentIndex += 1
            case .jmp:
                seen.insert(currentIndex)
                currentIndex += ops[currentIndex].argument
            }
            
            if currentIndex == ops.count {
                return accumulator
            }
        }
        
        return nil
    }
}

struct Operation {
    var instruction: Instruction
    let argument: Int
}

enum Instruction: String {
    case nop
    case acc
    case jmp
}
