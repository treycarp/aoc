//
//  Day4.swift
//  AOC2019
//
//  Created by Trey Carpenter on 11/26/21.
//

import Foundation
import OrderedCollections

public class Day4: Day {
    
    public override func part1() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
        let lines = Input().strings(name: "Day4Input.txt", year: "2018")
        
        var logbook: OrderedDictionary<Date, String> = [:]
        
        for line in lines {
            var splits = line.split(separator: " ")
            let dateString = String((String(splits[0]) + " " + String(splits[1])).dropFirst().dropLast())
            guard let date = dateFormatter.date(from: dateString) else { continue }
            splits.removeFirst()
            splits.removeFirst()
            logbook[date] = String(splits.joined(separator: " "))
        }
        return ""
    }
    
    public override func part2() -> String {
        return ""
    }
}
