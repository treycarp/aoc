//
//  Intcode.swift
//  AOC
//
//  Created by Trey Carpenter on 12/9/19.
//

import Foundation

enum Mode {
    case positional
    case immediate
}

enum Instruction: Int {
    case add = 1
    case multiply = 2
    case input = 3
    case output = 4
    case jumpIfTrue = 5
    case jumpIfFalse = 6
    case lessThan = 7
    case equals = 8
    case halt = 99
    case unknown
}

class Intcode {
    
    var io: Int?
    var memory: [Int]
    var position: Int = 0
    private(set) var halted = false
    
    init(memory: [Int]) {
        self.memory = memory
    }
    
    @discardableResult
    func run() -> Int {
        while halted == false {
            runComputer()
        }
        return io ?? 0
    }
    
    func nextInstructionIsIO() -> Bool {
        return Instruction(rawValue: memory[position] % 100) == .input ||
            Instruction(rawValue: memory[position] % 100) == .output
    }
    
    func runUntilNextIO() {
        while halted == false {
            if nextInstructionIsIO() {
                return
            }
            
            runComputer()
        }
    }
    
    func awaitingIO() -> Bool {
        halted == false && Instruction(rawValue: memory[position] % 100) == .input
    }
    
    func runComputer() {
        let fullInstructions = memory[position]
        let opcode = Instruction(rawValue: fullInstructions % 100)
        switch opcode {
        case .add:
            add(position: &position, mem: &memory)
        case .multiply:
            multiply(position: &position, mem: &memory)
        case .input:
            input(position: &position, mem: &memory)
        case .output:
             output(position: &position, mem: &memory)
        case .jumpIfTrue:
            jumpIfTrue(position: &position, mem: &memory)
        case .jumpIfFalse:
            jumpIfFalse(position: &position, mem: &memory)
        case .lessThan:
            lessThan(position: &position, mem: &memory)
        case .equals:
            equals(position: &position, mem: &memory)
        case .halt:
            halt(position: &position, mem: memory)
        default:
            print("Invalid opcode: \(opcode!)")
        }
    }
    
    func determineValues(position: Int, mem: [Int], arguments: Int) -> [Int] {
        var op = mem[position]
        op /= 100
        var modes: Array<Mode> = op.digits.compactMap { $0 == 1 ? .immediate : .positional }
        while modes.count < arguments { modes.insert(.positional, at: 0) }
        return modes.reversed().enumerated().map { (index, mode) -> Int in
            let value = mem[position + index + 1]
            if mode == .positional {
                return mem[value]
            } else {
                return value
            }
        }
    }
    
    func add(position: inout Int, mem: inout [Int]) {
        let params = determineValues(position: position, mem: mem, arguments: 3)
        let num1 = params[0]
        let num2 = params[1]
        let store = mem[position+3]
        
        mem[store] = num1 + num2
        position += 4
    }
    
    func multiply(position: inout Int, mem: inout [Int]) {
        let params = determineValues(position: position, mem: mem, arguments: 3)
        let num1 = params[0]
        let num2 = params[1]
        let store = mem[position+3]
        
        mem[store] = num1 * num2
        position += 4
    }
    
    func input(position: inout Int, mem: inout [Int]) {
        mem[mem[position+1]] = io!
        position += 2
    }
    
    func output(position: inout Int, mem: inout [Int]) {
        io = mem[mem[position+1]]
        print(mem[mem[position+1]])
        position += 2
    }
    
    func jumpIfTrue(position: inout Int, mem: inout [Int]) {
        let params = determineValues(position: position, mem: mem, arguments: 2)
        let num1 = params[0]
        let num2 = params[1]
        if num1 != 0 {
            position = num2
        } else {
           position+=3
        }
    }
    
    func jumpIfFalse(position: inout Int, mem: inout [Int]) {
        let params = determineValues(position: position, mem: mem, arguments: 2)
        let num1 = params[0]
        let num2 = params[1]
        if num1 == 0 {
            position = num2
        } else {
           position+=3
        }
    }
    
    func lessThan(position: inout Int, mem: inout [Int]) {
        let params = determineValues(position: position, mem: mem, arguments: 3)
        let num1 = params[0]
        let num2 = params[1]
        let store = mem[position+3]
        
        if num1 < num2 {
            mem[store] = 1
        } else {
            mem[store] = 0
        }
        
        position+=4
    }
    
    func equals(position: inout Int, mem: inout [Int]) {
        let params = determineValues(position: position, mem: mem, arguments: 3)
        let num1 = params[0]
        let num2 = params[1]
        let store = mem[position+3]
        
        if num1 == num2 {
            mem[store] = 1
        } else {
            mem[store] = 0
        }
        
        position+=4
    }
    
    func halt(position: inout Int, mem: [Int]) {
        position = mem.count
        halted = true
    }
}
