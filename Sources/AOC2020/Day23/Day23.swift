//
//  Day23.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/23/20.
//

import Foundation

public class Day23: Day {
    public override func part1() -> String {
        var input: [Int?] = "467528193".map { Int(String($0))! }
        let currentIndex: Int = 0
        let moves = 100
        
        for move in 1...moves {
            let cupsToMove = [input[(currentIndex + 1) % input.count], input[(currentIndex + 2) % input.count], input[(currentIndex + 3) % input.count]]
            
            print("-- move \(move) --\ncups: \(input.filter {$0 != nil} as! [Int] )\npickup: \(cupsToMove.filter {$0 != nil} as! [Int] )\ncurrent cup: \(input[currentIndex]!)")
            
            for (index, int) in input.enumerated() {
                if cupsToMove.contains(int) {
                    input[index] = nil
                }
            }
            
            var destinationIndex: Int? = nil
            var destinationValue = input[currentIndex]
            while destinationIndex == nil {
                let maxNumber = input.reduce(0) { max($0, $1 ?? 0) }
                destinationValue = destinationValue! - 1 < 1 ? maxNumber : destinationValue! - 1
                destinationIndex = input.firstIndex(of: destinationValue)
            }
            print("destination: \(input[destinationIndex!]!)")
            input.insert(contentsOf: cupsToMove, at: destinationIndex! + 1)
            input = input.filter { $0 != nil }
            input.append(input.remove(at: 0))
        }
        
        while input.first! != 1 {
            input.append(input.remove(at: 0))
        }
        let filtered = input.compactMap { String($0!) }.joined().dropFirst()
        return "Answer: \(filtered)"
    }
    
    public override func part2() -> String {
        var input: [Int] = "467528193".map { Int(String($0))! }
        
        var ints: [Int: Int] = [:]
        
        for int in (input.count + 1) ... 1_000_000 {
            input.append(int)
        }
        
        for (index, int) in input.enumerated() {
            if index == input.count - 1 {
                // loop back around
                ints[int] = input[0]
            } else {
                ints[int] = input[index + 1]
            }
        }
        
        let moves = 10_000_000
        
        let currentIndex: Int = 0
        for move in 1...moves {
            
            let a = ints[currentIndex]
            let b = ints[a!]
            let c = ints[b!]
            
            
//            let cupsToMoveIndexs = [(currentIndex + 1) % input.count, (currentIndex + 2) % input.count, (currentIndex + 3) % input.count]
//            let cupsToMove = [input[(currentIndex + 1) % input.count], input[(currentIndex + 2) % input.count], input[(currentIndex + 3) % input.count]]
//
//            for index in cupsToMoveIndexs {
//                input[index] = nil
//            }
//
//            var destinationIndex: Int? = nil
//            var destinationValue = input[currentIndex]
//            while destinationIndex == nil {
//                destinationValue = destinationValue! - 1 < 1 ? input.reduce(0) { max($0, $1 ?? 0) } : destinationValue! - 1
//                destinationIndex = input.firstIndex(of: destinationValue)
//            }
//            input.insert(contentsOf: cupsToMove, at: destinationIndex! + 1)
//            for index in cupsToMoveIndexs.reversed() {
//                if destinationIndex! + 3 < index {
//                    input.remove(at: index + 3)
//                } else {
//                    input.remove(at: index)
//                }
//            }
//            input.append(input.remove(at: 0))
        }
        
        let nextInt = ints[ints[1]!]!
        let oneAfterNext = ints[ints[nextInt]!]!
        let answer = ints[nextInt]! * ints[oneAfterNext]!
        
        return "Answer: \(answer)"
    }
}
