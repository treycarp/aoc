//
//  Day16.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/16/20.
//

import Foundation

public class Day16: Day {
    
    public override func part1() -> String {
        let lines = Input().strings(name: "Day16Input.txt", year: "2020")
        var fields = [TicketField]()
        var yourTicket: Ticket?
        var nearbyTickets: [Ticket] = []
        var parsingNearbyTickets = false
        var errorValues = [Int]()
        for (index, line) in lines.enumerated() {
            guard line != "your ticket:" else {
                yourTicket = Ticket(fields: lines[index+1].split(separator: ",").map { Int($0)! })
                continue
            }
            
            guard line != "nearby tickets:" else {
                parsingNearbyTickets = true
                continue
            }
            
            guard !parsingNearbyTickets else {
                // other tickets
                nearbyTickets.append(Ticket(fields: lines[index].split(separator: ",").map { Int($0)! }))
                continue
            }

            guard line.contains(":") else { continue }
            //fields
            let string = line.components(separatedBy: ": ")
            let name = string[0]
            let ranges = string[1].components(separatedBy: " or ")
            let lowerRange = Int(ranges[0].split(separator: "-")[0])!...Int(ranges[0].split(separator: "-")[1])!
            let upperRange = Int(ranges[1].split(separator: "-")[0])!...Int(ranges[1].split(separator: "-")[1])!
            fields.append(TicketField(name: name, lowerRange: lowerRange, upperRange: upperRange))
            continue
        }
        
        for ticket in nearbyTickets {
            for field in ticket.fields {
                var found = false
                for aField in fields {
                    guard !found else { continue }
                    found = aField.valid(field)
                }
                if !found {
                    errorValues.append(field)
                }
            }
        }

        
        return "Answer: \(errorValues.reduce(0, +))"
    }
    
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day16Input.txt", year: "2020")
        var fields = [TicketField]()
        var yourTicket: Ticket?
        var nearbyTickets: [Ticket] = []
        var parsingNearbyTickets = false
        for (index, line) in lines.enumerated() {
            guard line != "your ticket:" else {
                yourTicket = Ticket(fields: lines[index+1].split(separator: ",").map { Int($0)! })
                continue
            }
            
            guard line != "nearby tickets:" else {
                parsingNearbyTickets = true
                continue
            }
            
            guard !parsingNearbyTickets else {
                // other tickets
                nearbyTickets.append(Ticket(fields: lines[index].split(separator: ",").map { Int($0)! }))
                continue
            }

            guard line.contains(":") else { continue }
            //fields
            let string = line.components(separatedBy: ": ")
            let name = string[0]
            let ranges = string[1].components(separatedBy: " or ")
            let lowerRange = Int(ranges[0].split(separator: "-")[0])!...Int(ranges[0].split(separator: "-")[1])!
            let upperRange = Int(ranges[1].split(separator: "-")[0])!...Int(ranges[1].split(separator: "-")[1])!
            fields.append(TicketField(name: name, lowerRange: lowerRange, upperRange: upperRange))
            continue
        }
        
        for (index, ticket) in nearbyTickets.enumerated() {
            for field in ticket.fields {
                var found = false
                for aField in fields {
                    guard !found else { continue }
                    found = aField.valid(field)
                }
                if !found {
                    nearbyTickets[index].valid = false
                }
            }
        }
        
        nearbyTickets.removeAll {
            !$0.valid
        }
        
        // determine field
        var fieldIndex = 0
        while fieldIndex < fields.count {
            var ticketFieldIndex = 0
            while ticketFieldIndex < fields.count {
                if nearbyTickets.allSatisfy({ fields[fieldIndex].valid($0.fields[ticketFieldIndex])}) {
                    fields[fieldIndex].index.append(ticketFieldIndex)
                }
                ticketFieldIndex += 1
            }
            fieldIndex += 1
        }
        
        //sort out fields
        var figured = false
        var reducedFields: [Int] = []
        while !figured {
            let field = fields.first {
                $0.index.count == 1 && !reducedFields.contains($0.index[0])
            }
            
            for (index, ticket) in fields.enumerated() {
                if ticket.index.count > 1 {
                    fields[index].index.removeAll(where: { fieldIndex -> Bool in
                        return fieldIndex == field?.index.first!
                    })
                }
            }
            reducedFields.append(field!.index.first!)
            if fields.allSatisfy({ $0.index.count == 1 }) {
                figured = true
            }
        }
        
        let departureFields = fields.filter {
            $0.name.contains("departure")
        }
        
        let answer = departureFields.reduce(1) {
            $0 * yourTicket!.fields[$1.index.first!]
        }

        return "Answer: \(answer)"
    }
}

struct TicketField {
    let name: String
    let lowerRange: ClosedRange<Int>
    let upperRange: ClosedRange<Int>
    
    var index: [Int] = []

    
    func valid(_ value: Int) -> Bool {
        print("value: \(value), upper: \(upperRange), lower: \(lowerRange), valid: \(lowerRange.contains(value) || upperRange.contains(value))")
        return lowerRange.contains(value) || upperRange.contains(value)
    }
}

struct Ticket {
    var fields: [Int]
    var valid = true
}
