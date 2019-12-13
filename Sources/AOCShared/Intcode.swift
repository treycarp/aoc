//
//  Intcode.swift
//  AOC
//
//  Created by Trey Carpenter on 12/9/19.
//

import Foundation

enum Mode : Int {
    case positional
    case immediate
    case relative
    case unknown
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
    case relative = 9
    case halt = 99
    case unknown
}

class Intcode {
    
    var io: Int?
    var memory: [Int]
    var position: Int = 0
    private(set) var halted = false
    var relativeBase: Int = 0
    
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
        return Instruction(rawValue: Int(memory[position]) % 100) == .input ||
            nextInstructionIsWrite()
    }
    
    func nextInstructionIsWrite() -> Bool {
        Instruction(rawValue: Int(memory[position]) % 100) == .output
    }
    
    func runUntilNextIO() {
        while halted == false {
            if nextInstructionIsIO() {
                return
            }
            
            runComputer()
        }
    }
    
    func runUntilNextOutput() {
        while halted == false {
            if nextInstructionIsWrite() {
                return
            }
            
            runComputer()
        }
    }
    
    func awaitingIO() -> Bool {
        halted == false && Instruction(rawValue: Int(memory[position]) % 100) == .input
    }
    
    func runComputer() {
        let fullInstructions = Int(memory[position])
        let opcode = Instruction(rawValue: fullInstructions % 100)
        switch opcode {
        case .add:
            add(position: &position)
        case .multiply:
            multiply(position: &position)
        case .input:
            input(position: &position)
        case .output:
             output(position: &position)
        case .jumpIfTrue:
            jumpIfTrue(position: &position)
        case .jumpIfFalse:
            jumpIfFalse(position: &position)
        case .lessThan:
            lessThan(position: &position)
        case .equals:
            equals(position: &position)
        case .relative:
            relative(position: &position)
        case .halt:
            halt(position: &position)
        default:
            print("Invalid opcode: \(opcode!)")
        }
    }
    
    private func mode(_ argIndex: Int) -> Mode {
        let mask = pow(10.0, Double(argIndex + 2))
        return Mode(rawValue:(memory[position] / Int(mask)) % 10) ?? .unknown
    }
    
    private subscript(argIndex: Int) -> Int {
        get {
            let value = memory[position + argIndex + 1]
            switch mode(argIndex) {
            case .positional:
                return memory[value]
            case .immediate:
                return value
            case .relative:
                return memory[relativeBase + value]
            case .unknown:
                fatalError()
            }
        }
        
        set {
            let value = memory[position + argIndex + 1]
            switch mode(argIndex) {
            case .positional:
                memory[value] = newValue
            case .immediate:
                fatalError() // Can't be this ever.
            case .relative:
                memory[relativeBase + value] = newValue
            case .unknown:
                fatalError()
            }
        }
    }
    
    func add(position: inout Int) {
        
        self[2] = self[0] + self[1]
        position += 4
    }
    
    func multiply(position: inout Int) {
        
        self[2] = self[0] * self[1]
        position += 4
    }
    
    func input(position: inout Int) {
        
        self[0] = io!
        position += 2
    }
    
    func output(position: inout Int) {
        
        io = self[0]
        print("Output: \(io!)")
        position += 2
    }
    
    func jumpIfTrue(position: inout Int) {
        
        if self[0] != 0 {
            position = self[1]
        } else {
            position+=3
        }
    }
    
    func jumpIfFalse(position: inout Int) {

        if self[0] == 0 {
            position = self[1]
        } else {
            position+=3
        }
    }
    
    func lessThan(position: inout Int) {
        
        if self[0] < self[1] {
            self[2] = 1
        } else {
            self[2] = 0
        }
        
        position+=4
    }
    
    func equals(position: inout Int) {
        
        if self[0] == self[1] {
            self[2] = 1
        } else {
            self[2] = 0
        }
        
        position+=4
    }
    
    func relative(position: inout Int) {

        relativeBase+=self[0]
        position+=2
    }
    
    func halt(position: inout Int) {
        position = memory.count
        halted = true
    }
}
