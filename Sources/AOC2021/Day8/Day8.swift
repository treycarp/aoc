//
//  Day8.swift
//  AOC2021
//
//  Created by Trey Carpenter on 12/8/21.
//

import Foundation

public class Day8: Day {
    public override func part1() -> String {
        let lines = Input().strings(name: "Day8Input.txt", year: "2021")
        let overallSum = lines.reduce(0) { partialResult, string in
            let outputs = string.split(separator: "|")[1].split(separator: " ")
            let sum = outputs.reduce(0) { partialResult, output in
                if output.count == 2 || output.count == 3 || output.count == 4 || output.count == 7 {
                    print(output)
                    return partialResult + 1
                }
                
                return partialResult + 0
            }
            return partialResult + sum
        }
        return "\(overallSum)"
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day8Input.txt", year: "2021")
        var sum = 0
        for line in lines {
            let outputs = line.split(separator: "|")[1].split(separator: " ").map { Set($0) }
            let inputs = line.split(separator: "|")[0].split(separator: " ").map { Set($0) }
            let display = SegmentDisplay(inputs + outputs)
            var value = ""
            for output in outputs {
               value += String(display.decode(output))
            }
            sum += Int(value)!
        }
        return "\(sum)"
    }
    
    struct SegmentDisplay {
        
        let one: Set<Character>
        let two: Set<Character>
        let three: Set<Character>
        let four: Set<Character>
        let five: Set<Character>
        let six: Set<Character>
        let seven: Set<Character>
        let eight: Set<Character>
        let nine: Set<Character>
        let zero: Set<Character>
        
        init (_ strings: [Set<Character>]) {
            let one = strings.first { $0.count == 2 }!
            let four = strings.first { $0.count == 4 }!
            let seven = strings.first { $0.count == 3 }!
            let eight = strings.first { $0.count == 7 }!
            
            // determine sides from this bunch
            let top = seven.subtracting(one)
            let nine = strings.first { $0.subtracting(four).subtracting(top).count == 1 && $0.count == 6 }!
            let bottom = nine.subtracting(four).subtracting(top)
            let three = strings.first { $0.subtracting(seven).subtracting(bottom).count == 1 }!
            let middle = three.subtracting(top).subtracting(bottom).subtracting(one)
            let topLeft = four.subtracting(one).subtracting(middle)
            let zero = eight.subtracting(middle)
            let six = strings.first { $0.subtracting(four).subtracting(top).subtracting(bottom).count == 1 && $0 != zero && $0 != nine && $0.count == 6 }!
            let topRight = eight.subtracting(six)
            let bottomRight = one.subtracting(topRight)
            let bottomLeft = eight.subtracting(three).subtracting(topLeft)
            let two = eight.subtracting(topLeft).subtracting(bottomRight)
            let five = eight.subtracting(topRight).subtracting(bottomLeft)
            
            self.one = one
            self.two = two
            self.three = three
            self.four = four
            self.five = five
            self.six = six
            self.seven = seven
            self.eight = eight
            self.nine = nine
            self.zero = zero
        }
        
        func decode(_ chars: Set<Character>) -> Int {
            switch chars {
            case one: return 1
            case two: return 2
            case three: return 3
            case four: return 4
            case five: return 5
            case six: return 6
            case seven: return 7
            case eight: return 8
            case nine: return 9
            default: return 0
            }
        }
    }
}
