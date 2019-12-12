//
//  Day7.swift
//  AOC
//
//  Created by Trey Carpenter on 12/10/19.
//

import Foundation

public class Day7: Day {
    
    public override func part1() -> String {
        let memory = Input().numbersCsv(name: "Day7Input.txt")
        var maxOutput = 0
        let phaseSequences = [0,1,2,3,4].permutations
        phaseSequences.forEach {
            var io: Int = 0
            $0.forEach {
                let amp = Amp(phase: $0, memory: memory)
                io = amp.run(io: io)
            }
            maxOutput = max(maxOutput, Int(io))
        }

        return "Part 1 result: \(maxOutput)"
    }
    
    public override func part2() -> String {
        let memory = Input().numbersCsv(name: "Day7Input.txt")
        
        var maxOutput = 0
        let phaseSequences = [5,6,7,8,9].permutations
        phaseSequences.forEach {
            maxOutput = max(maxOutput, runInFeedbackMode($0, memory: memory))
        }
        
        return "Part 2 result: \(maxOutput)"
    }
    
    func runInFeedbackMode(_ phases: [Int], memory: [Int]) -> Int {
        let a = Amp(phase: phases[0], memory: memory)
        let b = Amp(phase: phases[1], memory: memory)
        let c = Amp(phase: phases[2], memory: memory)
        let d = Amp(phase: phases[3], memory: memory)
        let e = Amp(phase: phases[4], memory: memory)

        var lastOutput:Int = 0
        while !e.finished {
            let aOutput = a.run(io: lastOutput, feedbackMode: true)
            let bOutput = b.run(io: aOutput, feedbackMode: true)
            let cOutput = c.run(io: bOutput, feedbackMode: true)
            let dOutput = d.run(io: cOutput, feedbackMode: true)
            lastOutput = e.run(io: dOutput, feedbackMode: true)
        }
        
        return Int(lastOutput)
    }
}
