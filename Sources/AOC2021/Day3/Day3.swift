//
//  Day3.swift
//  AOC2021
//
//  Created by Trey Carpenter on 12/2/21.
//

import Foundation

public class Day3: Day {
    
    public override func part1() -> String {
        let lines = Input().arrayOfCharacterLines(name: "Day3Input.txt", year: "2021")
        
        var gamma = [String]()
        var epsilon = [String]()
        
        for index in 0..<lines[0].count {
            let bitCount = lines.reduce(0) { partialResult, number in
                partialResult + Int(number[index])!
            }
            gamma.append(bitCount > lines.count / 2 ? "1" : "0")
            epsilon.append(bitCount < lines.count / 2 ? "1" : "0")
        }
        return "\(Int(gamma.joined(), radix: 2)! * Int(epsilon.joined(), radix: 2)!)"
    }
    
    public override func part2() -> String {
        let lines = Input().arrayOfCharacterLines(name: "Day3Input.txt", year: "2021")
        
        var oxygenRating = ""
        var co2Rating = ""
        
        var tempLines = lines
        for index in 0..<tempLines[0].count {
            let bitSum = tempLines.reduce(0) { partialResult, number in
                partialResult + Int(number[index])!
            }
            
            let commonBit = Double(bitSum) >= Double(tempLines.count) / 2 ? "1" : "0"
        
            tempLines = tempLines.filter {
                $0[index] == commonBit
            }
            
            if tempLines.count == 1 {
                oxygenRating = tempLines[0].joined()
            }
        }
        
        tempLines = lines

        for index in 0..<tempLines[0].count {
            let bitSum = tempLines.reduce(0) { partialResult, number in
                partialResult + Int(number[index])!
            }
        
            let commonBit = Double(bitSum) < Double(tempLines.count) / 2 ? "0" : "1"
            
            tempLines = tempLines.filter {
                $0[index] != commonBit
            }
            
            if tempLines.count == 1 {
                co2Rating = tempLines[0].joined()
            }
        }
        
        
        return "Oxygen rating: \(oxygenRating)\nC02 rating: \(co2Rating)\n\(Int(oxygenRating, radix: 2)! * Int(co2Rating, radix: 2)!)"
    }
}
