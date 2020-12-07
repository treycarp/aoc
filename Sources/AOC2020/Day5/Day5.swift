//
//  Day5.swift
//  AOC
//
//  Created by Trey Carpenter on 12/4/20.
//

import Foundation

public class Day5: Day {
    
    public override func part1() -> String {
        var maxSeatId = 0
    
        let lines = Input().arrayOfCharacterLines(name: "Day5Input.txt", year: "2020")
        
        lines.forEach {
            let rowForTicket = getNumberFor(charKey: ("F", "B"), range: (0, 127), chars: $0.filter { char in char == "F" || char == "B" })
            let seatForTicket = getNumberFor(charKey: ("L", "R"), range: (0, 7), chars: $0.filter { char in char == "L" || char == "R" } )
            
            maxSeatId = max(maxSeatId, Int(rowForTicket * 8 + seatForTicket))
            print("Id: \($0.joined(separator: "")), Row: \(rowForTicket), Seat: \(seatForTicket), Seat ID: \(rowForTicket * 8 + seatForTicket)")
        }
        return "\(maxSeatId)"
    }
    
    public override func part2() -> String {
        var rows = [[Int]](repeating: [Int](repeating: 0, count: 8), count: 128)
        let lines = Input().arrayOfCharacterLines(name: "Day5Input.txt", year: "2020")
        lines.forEach {
            let rowForTicket = getNumberFor(charKey: ("F", "B"), range: (0, 127), chars: $0.filter { char in char == "F" || char == "B" })
            let seatForTicket = getNumberFor(charKey: ("L", "R"), range: (0, 7), chars: $0.filter { char in char == "L" || char == "R" } )
            
            rows[rowForTicket][seatForTicket] = 1
        }
        
        var emptySeats = [Int]()
        var rowIndex = 0
        rows.forEach {
            if let emptyIndex = $0.firstIndex(where: { value -> Bool in value == 0 }) {
                emptySeats.append(rowIndex * 8 + emptyIndex)
            }
            rowIndex += 1
        }
        
        return "Open seats: \(emptySeats)"
    }
    
    private func getNumberFor(charKey: (String, String), range: (Double, Double), chars: [String]) -> Int {
        var rowRange = range
        chars.forEach { letter in
            if letter == charKey.0 {
                rowRange = (rowRange.0, ((rowRange.1 + rowRange.0) / 2).rounded(.up))
            } else if letter == charKey.1 {
                rowRange = (((rowRange.1 + rowRange.0) / 2).rounded(.down), rowRange.1)
            }
        }
        
        return chars.last == charKey.0 ? Int(rowRange.0) : Int(rowRange.1)
    }
}
