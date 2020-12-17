//
//  Day12.swift
//  AOC2019
//
//  Created by Trey Carpenter on 12/14/20.
//

import Foundation

public class Day12: Day {
    public override func part1() -> String {
        let lines = Input().strings(name: "Day12Input.txt", year: "2019")
        var moons = lines.map { Moon(raw: $0) }
        
        for _ in 0..<1000 {
            for (index, moon) in moons.enumerated() {
                for (innerIndex, moon2) in moons.enumerated() {
                    guard innerIndex > index else { continue }
                    let xChanges = compareAxis(axis1:  moon.x, axis2:  moon2.x)
                    moons[index].vX += xChanges.0
                    moons[innerIndex].vX += xChanges.1
                    
                    let yChanges = compareAxis(axis1:  moon.y, axis2:  moon2.y)
                    moons[index].vY += yChanges.0
                    moons[innerIndex].vY += yChanges.1
                    
                    let zChanges = compareAxis(axis1:  moon.z, axis2:  moon2.z)
                    moons[index].vZ += zChanges.0
                    moons[innerIndex].vZ += zChanges.1
                }
            }
            
            // update positions
            for (index, _) in moons.enumerated() {
                moons[index].updatePosition()
            }
        }
        
        let total = moons.reduce(0) {
            $0 + $1.totalEnergy()
        }

        return "Total energy: \(total)"
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day12Input.txt", year: "2019")
        var moons = lines.map { Moon(raw: $0) }

        var numSteps = [0, 0, 0]
        for axisIndex in 0..<numSteps.count {
            for moonIndex in 0..<moons.count {
                moons[moonIndex].reset()
            }
            
            var finished = false
            while !finished {
                for (index, moon) in moons.enumerated() {
                    for (innerIndex, moon2) in moons.enumerated() {
                        guard innerIndex > index else { continue }
                        if axisIndex == 0 {
                            let xChanges = compareAxis(axis1:  moon.x, axis2:  moon2.x)
                            moons[index].vX += xChanges.0
                            moons[innerIndex].vX += xChanges.1
                            
                        } else if axisIndex == 1 {
                            let yChanges = compareAxis(axis1:  moon.y, axis2:  moon2.y)
                            moons[index].vY += yChanges.0
                            moons[innerIndex].vY += yChanges.1
                        } else {
                            let zChanges = compareAxis(axis1:  moon.z, axis2:  moon2.z)
                            moons[index].vZ += zChanges.0
                            moons[innerIndex].vZ += zChanges.1
                        }
                    }
                }
                
                // update positions
                for (index, _) in moons.enumerated() {
                    moons[index].updatePosition()
                }
                
                numSteps[axisIndex] += 1
                finished = moons.allSatisfy({$0.sameAsInitial()})
            }
        }
        
        let answer = numSteps.reduce(numSteps.first!, {Math().lcm($0, $1)})
        return "Answer: \(answer)"
    }
    
    func compareAxis(axis1: Int, axis2: Int) -> (Int, Int) {
        if axis1 < axis2 {
            return (1, -1)
        } else if axis1 > axis2 {
            return (-1, 1)
        }
        
        return (0, 0)
    }
}

struct Moon {
    
    init(raw: String) {
        initialX = Int(String(raw.split(separator: ",")[0].split(separator: "=").last!))!
        initialY = Int(String(raw.split(separator: ",")[1].split(separator: "=").last!))!
        initialZ = Int(String(raw.split(separator: ",")[2].split(separator: "=").last!).dropLast())!
        x = initialX
        y = initialY
        z = initialZ
    }
    
    var initialX: Int
    var initialY: Int
    var initialZ: Int
    
    var x: Int
    var y: Int
    var z: Int
    
    var vX: Int = 0
    var vY: Int = 0
    var vZ: Int = 0
    
    mutating func updatePosition() {
        x += vX
        y += vY
        z += vZ
    }
    
    mutating func reset() {
        initialX = x
        initialY = y
        initialZ = z
        vX = 0
        vY = 0
        vZ = 0
    }
    
    func sameAsInitial() -> Bool {
        return initialX == x &&
        initialY == y &&
        initialZ == z &&
        vZ == 0 &&
        vY == 0 &&
        vX == 0
    }
    
    func totalEnergy() -> Int {
        (abs(x) + abs(y) + abs(z)) * (abs(vX) + abs(vY) + abs(vZ))
    }
}
