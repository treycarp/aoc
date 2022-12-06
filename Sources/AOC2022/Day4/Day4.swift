//
//  Day4.swift
//
//  Created on 12/2/22.
//  
//

import Foundation

public class Day4: Day {

    public override func part1() -> String {
        let ranges = Input().strings(name: "Day4Input.txt", year: "2022").map {
            return $0.split(separator: ",").map { return $0.split(separator: "-").map { Int(String($0))! } }
        }
        
        let contains: [Bool] = ranges.map { pairs in
            var range1 = [Int]()
            for i in pairs[0][0]...pairs[0][1] {
                range1.append(i)
            }
            
            var range2 = [Int]()
            for i in pairs[1][0]...pairs[1][1] {
                range2.append(i)
            }
            if Set(range1).isSubset(of: Set(range2)) ||
                Set(range2).isSubset(of: Set(range1)) {
                return true
            }
            
            return false
        }
        return "\(contains.filter({ $0 == true }).count)"
    }

    public override func part2() -> String {
        let ranges = Input().strings(name: "Day4Input.txt", year: "2022").map {
            return $0.split(separator: ",").map { return $0.split(separator: "-").map { Int(String($0))! } }
        }
        
        let contains: [Bool] = ranges.map { pairs in
            var range1 = [Int]()
            for i in pairs[0][0]...pairs[0][1] {
                range1.append(i)
            }
            
            var range2 = [Int]()
            for i in pairs[1][0]...pairs[1][1] {
                range2.append(i)
            }
            return !Set(range1).intersection(Set(range2)).isEmpty
        }
        return "\(contains.filter({ $0 == true }).count)"
    }
}
