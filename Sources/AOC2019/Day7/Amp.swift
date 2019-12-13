//
//  Amp.swift
//  AOC
//
//  Created by Trey Carpenter on 12/10/19.
//

import Foundation

class Amp {
    
    let phase: Int
    var inputs: [Int]
    private let intcode: Intcode
    var finished: Bool { intcode.halted }
    
    init(phase: Int, memory: [Int]) {
        self.phase = phase
        self.inputs = [phase]
        self.intcode = Intcode(memory: memory)
    }
    
    func run(io: Int, feedbackMode: Bool = false) -> Int {
        if feedbackMode {
            return runInFeedbackMode(io: io)
        } else {
            return runInNonFeedbackMode(io: io)
        }
    }
    
    func runInFeedbackMode(io: Int) -> Int {
        var halted = false
        inputs.append(Int(io))
        while !halted {
            intcode.runUntilNextIO()
            if intcode.halted {
                halted = true
            } else if intcode.awaitingIO() {
                halted = inputs.count == 0
                intcode.io = Int(inputs.removeFirst())
                if !halted {
                    intcode.runComputer()
                    intcode.io = nil
                }
            } else {
                intcode.runComputer()
                halted = true
            }
        }
        return intcode.io ?? 0
    }
    
    func runInNonFeedbackMode(io: Int) -> Int {
        intcode.runUntilNextIO()
        intcode.io = Int(inputs.first!)
        intcode.runComputer()
        intcode.io = io
        return intcode.run()
    }
}
