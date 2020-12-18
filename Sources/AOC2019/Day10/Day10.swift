//
//  Day10.swift
//  AOC
//
//  Created by Trey Carpenter on 12/10/19.
//

import Foundation

public class Day10: Day {
    
    var field: [[String]]!
    var maxAsteriods = 0
    var maxX = 0
    var maxY = 0
    
    override public func part1() -> String {
        
        var currentY = 0
        
        field = Input().arrayOfCharacterLines(name: "Day10Input.txt", year: "2019")
        guard let field = field else { return "Failed to parse" }
        
        for line in field {
            var currentX = 0
            for asteroid in line {
                
                guard asteroid == "#" else {
                    currentX += 1
                    continue
                }
                
                //print("Found asteroid at \(currentX), \(currentY)")
                countAsteroidsFrom(x: currentX, y: currentY)
                currentX += 1
            }
            currentY += 1
        }
        
        return "Maxmium asteroids detected: \(maxAsteriods) at \(maxX),\(maxY)"
    }
    
    override public func part2() -> String {
        maxAsteriods = 0
        maxX = 0
        maxY = 0
        field = Input().arrayOfCharacterLines(name: "Day10Input.txt", year: "2019")
        var totalDestroyed = [(Int, Int)]()
        while totalDestroyed.count < 200 {
            let asteroidsDestroyed = countAsteroidsFrom(x: 11, y: 13)
            totalDestroyed.append(contentsOf: asteroidsDestroyed)
            removeAsteroids(asteroids: asteroidsDestroyed)
        }
        
        return "\(totalDestroyed[200])"
    }
    
    private func removeAsteroids(asteroids: [(Int, Int)]) {
        asteroids.forEach {
            field[$0.0][$0.1] = "."
        }
    }
    
    @discardableResult
    private func countAsteroidsFrom(x: Int, y: Int) -> [(Int, Int)] {
        var asteroidsEncountered = [(Int, Int)]()
        var uniqueSlopes = [Double]()
        var currentY = 0
        for line in field {
            var currentX = 0
            for asteroid in line {
                
                guard asteroid == "#" else {
                    currentX += 1
                    continue
                }
                
                if currentX == x && currentY == y {
                    currentX += 1
                    continue
                }

                var radians = atan2(Double(y - currentY), Double(x - currentX))
                
                if (radians < 0) {
                    radians += Double.pi*2.0;
                }
                
                if !uniqueSlopes.contains(radians) {
                    uniqueSlopes.append(radians)
                    asteroidsEncountered.append((currentX, currentY))
                }
                currentX += 1
            }
            currentY += 1
        }
        
        if uniqueSlopes.count > maxAsteriods {
            maxAsteriods = uniqueSlopes.count
            maxX = x
            maxY = y
        }
        maxAsteriods = max(maxAsteriods, uniqueSlopes.count)
        
        return asteroidsEncountered
    }
}
