//
//  Day13.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/13/20.
//

import Foundation

public class Day13: Day {
    public override func part1() -> String {
        let lines = Input().strings(name: "Day13Input.txt", year: "2020")
        let target = Double(lines[0])!
        var busses: [Bus] = lines[1].split(separator: ",").compactMap { Double($0) }.compactMap { Bus(number: $0, currentTimeStamp: 0)}
        
        var rideableBuses = [Bus]()
        
        while rideableBuses.count != busses.count {
            for (index, _) in busses.enumerated() {
                if rideableBuses.contains(busses[index]) {
                    continue
                }
                
                busses[index].currentTimeStamp += busses[index].number
                
                if busses[index].currentTimeStamp >= target {
                    rideableBuses.append(busses[index])
                }
            }
        }
        
        rideableBuses.sort { (bus1, bus2) -> Bool in
            bus1.currentTimeStamp < bus2.currentTimeStamp
        }
        let firstBus = rideableBuses.first!
        return "First bus: \(firstBus.number * (firstBus.currentTimeStamp - target))"
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day13Input.txt", year: "2020")
        var first = [Int]()
        var remainder = [Int]()
        
        for (index, value) in lines[1].split(separator: ",").enumerated() {
            guard value != "x" else { continue }
            first.append(Int(value)!)
            remainder.append(index)
        }
        let firstTimestamp = abs(Math().crt(remainder, first))
        
        return "Answer: \(firstTimestamp)"
    }
}

struct Bus: Hashable {
    let number: Double
    var currentTimeStamp: Double
    var offset: Double? = 0
    
    static func == (lhs: Bus, rhs: Bus) -> Bool {
            return lhs.number == rhs.number
    }
}


