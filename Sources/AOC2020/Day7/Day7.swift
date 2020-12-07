//
//  Day7.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/7/20.
//

import Foundation

public class Day7: Day {
    var bags: [Bag]?
    
    public override func part1() -> String {
        let lines = Input().strings(name: "Day7Input.txt", year: "2020")
        bags = lines.compactMap {
            return Bag(raw: $0)
        }
        var containsShinyGold = Set<Bag>()
        
        bags?.forEach {
            if bagContainsShinyGold($0) && $0.color != "shiny gold" {
                containsShinyGold.insert($0)
            }
        }
        
        return "Bag count: \(containsShinyGold.count)"
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day7Input.txt", year: "2020")
        bags = lines.compactMap {
            return Bag(raw: $0)
        }
        
        let shinyGold = bags?.first { $0.color == "shiny gold" }
        let bagCount = countBags(shinyGold) - 1
        return "Bag count: \(bagCount)"
    }
    
    private func countBags(_ currentBag: Bag?) -> Int {
        guard let bagsContained = currentBag?.contains else { return 1 }
        var count = 1
        for outerBag in bagsContained {
            let nextBag = bags?.first(where: { innerBag -> Bool in outerBag.color == innerBag.color })
            count += outerBag.amount * countBags(nextBag)
        }
        
        return count
    }
    
    private func bagContainsShinyGold(_ currentBag: Bag?) -> Bool {
        guard currentBag?.color != "shiny gold" else { return true }
        guard let bagsContained = currentBag?.contains else { return false }
        for outerBag in bagsContained {
            let nextBag = bags?.first(where: { innerBag -> Bool in outerBag.color == innerBag.color })
            if bagContainsShinyGold(nextBag) {
                return true
            }
        }

        return false
    }
    
    struct Bag: Hashable {
        var amount: Int = 0
        var color: String
        var contains: [Bag]?
        
        init(raw: String) {
            let strings = raw.components(separatedBy: " contain ")
            self.amount = 0
            self.color = strings[0].split(separator: " ").dropLast().joined(separator: " ")
            
            guard !strings[1].contains("no other") else {
                contains = nil
                return
            }
            
            contains = []
            let bags = strings[1].split(separator: ",")
            bags.forEach {
                let subBag = $0.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: ".", with: "").split(separator: " ")
                let color = String(subBag.dropLast().dropFirst().joined(separator: " "))
                contains?.append(Bag(amount: Int(subBag[0])!, color: color == "other" ? "" : color))
            }
        }
        
        init(amount: Int, color: String) {
            self.amount = amount
            self.color = color
        }
        
        static func == (lhs: Bag, rhs: Bag) -> Bool {
                return lhs.color == rhs.color
        }
    }
}
