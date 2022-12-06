//
//  Day3.swift
//  AOC2022
//
//  Created by Trey Carpenter on 12/2/22.
//

import Foundation

enum Priority: String {
    case a
    case b
    case c
    case d
    case e
    case f
    case g
    case h
    case i
    case j
    case k
    case l
    case m
    case n
    case o
    case p
    case q
    case r
    case s
    case t
    case u
    case v
    case w
    case x
    case y
    case z
    case A
    case B
    case C
    case D
    case E
    case F
    case G
    case H
    case I
    case J
    case K
    case L
    case M
    case N
    case O
    case P
    case Q
    case R
    case S
    case T
    case U
    case V
    case W
    case X
    case Y
    case Z
    
    func intValue() -> Int {
        switch self {
        case .a: return 1
        case .b: return 2
        case .c: return 3
        case .d: return 4
        case .e: return 5
        case .f: return 6
        case .g: return 7
        case .h: return 8
        case .i: return 9
        case .j: return 10
        case .k: return 11
        case .l: return 12
        case .m: return 13
        case .n: return 14
        case .o: return 15
        case .p: return 16
        case .q: return 17
        case .r: return 18
        case .s: return 19
        case .t: return 20
        case .u: return 21
        case .v: return 22
        case .w: return 23
        case .x: return 24
        case .y: return 25
        case .z: return 26
        case .A: return 27
        case .B: return 28
        case .C: return 29
        case .D: return 30
        case .E: return 31
        case .F: return 32
        case .G: return 33
        case .H: return 34
        case .I: return 35
        case .J: return 36
        case .K: return 37
        case .L: return 38
        case .M: return 39
        case .N: return 40
        case .O: return 41
        case .P: return 42
        case .Q: return 43
        case .R: return 44
        case .S: return 45
        case .T: return 46
        case .U: return 47
        case .V: return 48
        case .W: return 49
        case .X: return 50
        case .Y: return 51
        case .Z: return 52
        }
    }
}
public class Day3: Day {

    public override func part1() -> String {
        let lines = Input().arrayOfCharacterLines(name: "Day3Input.txt", year: "2022")
        let pairs: [(Set<String>, Set<String>)] = lines.map {
            let a = Set($0[0..<$0.count/2].map { String($0) })
            let b = Set($0[$0.count/2...$0.count-1].map { String($0) })
            return (a, b)
        }
        let uniqueValues: [String] = pairs.compactMap {
            let intersection = $0.0.intersection($0.1)
            return intersection.first ?? nil
        }
        
        let sum = uniqueValues.reduce(0) { partialResult, value in
            return partialResult + Priority(rawValue: value)!.intValue()
        }
        return "\(sum)"
    }

    public override func part2() -> String {
        let lines = Input().characterSets(name: "Day3Input.txt", year: "2022")
        var sum = 0
        
        for i in stride(from: 0, to: lines.count-1, by: 3) {
            let line1: Set<String> = lines[i]
            let line2: Set<String> = lines[i+1]
            let line3: Set<String> = lines[i+2]
            let common = line1.intersection(line2).intersection(line3)
            sum += Priority(rawValue: common.joined())!.intValue()
        }
        return "\(sum)"
    }
}
