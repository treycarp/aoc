import Foundation

open class Day3 {
    
    static func parseFile() throws -> [[String]] {
        let fileURL = Bundle.main.url(forResource: "Day3Input", withExtension: "txt")
        let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
        let lines = content.split { $0.isNewline }
        var result = [[String]]()
        
        lines.forEach {
            result.append($0.components(separatedBy: ","))
        }
        return result
    }

    public static func computeLines() throws {
        
        let lineCommands = try parseFile()
        var line1 = [(Int, Int)]()
        var line2 = [(Int, Int)]()
        line1.append((0, 0))
        line2.append((0, 0))
        var currentCoord: (Int, Int) = (0, 0)
        lineCommands[0].forEach {
            let direction = $0.first
            let distance = Int($0.dropFirst())!
            
            for _ in 0..<distance {
                
                switch direction {
                case "U":
                    currentCoord.1+=1
                case "D":
                    currentCoord.1-=1
                case "L":
                    currentCoord.0-=1
                case "R":
                    currentCoord.0+=1
                default:
                    break
                }
                //print(currentCoord)
                line1.append(currentCoord)
            }
        }
        
        currentCoord = (0,0)
        lineCommands[1].forEach {
            let direction = $0.first
            let distance = Int($0.dropFirst())!
            
            for _ in 0..<distance {
                
                switch direction {
                case "U":
                    currentCoord.1+=1
                case "D":
                    currentCoord.1-=1
                case "L":
                    currentCoord.0-=1
                case "R":
                    currentCoord.0+=1
                default:
                    break
                }
                //print(currentCoord)
                line2.append(currentCoord)
            }
        }
        
        let commonElements = line1.filter({ (tuple1) -> Bool in
            line2.contains { (tuple2) -> Bool in
               tuple1 == tuple2
            }
        })
        
        var minDistance: Int = 0
        commonElements.forEach {
            let value = abs($0.0) + abs($0.1)
            if minDistance == 0 {
                minDistance = value
            } else {
                minDistance = min(minDistance, value)
            }
            
        }
        
        print(commonElements)
        print(minDistance)
        var minSteps = 0
        commonElements.forEach { tuple in
            let index1 = line1.firstIndex(where: { $0 == tuple })!
            let index2 = line2.firstIndex(where: { $0 == tuple })!
            
            if minSteps == 0 {
                minSteps = index1 + index2
            } else {
                minSteps = min(minSteps, index1+index2)
            }
        }
        
        print(minSteps)
    }
}
