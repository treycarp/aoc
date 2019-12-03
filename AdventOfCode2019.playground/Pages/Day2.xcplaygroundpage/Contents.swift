import Foundation

func parseFile() throws -> [String] {
    let fileURL = Bundle.main.url(forResource: "Day2Input", withExtension: "txt")
    let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    return content.components(separatedBy: ",")
}

func compute() throws {
    //Needs a refactor, but it solved the problem.
    let nextOperationOffset = 4
    var originalPositions = try parseFile()
    originalPositions[1] = "0"
    originalPositions[2] = "0"
    var opcodeIndex = 0
    
    while Int(originalPositions[1])! < 100 {
        while Int(originalPositions[2])! < 100 {
            //print("Position2: \(originalPositions[2])")
            var tempPositions = originalPositions
            while opcodeIndex < tempPositions.count {
                guard let opcode = Int(tempPositions[opcodeIndex]),
                    let computePosition1 = Int(tempPositions[opcodeIndex + 1]),
                    let computePosition2 = Int(tempPositions[opcodeIndex + 2]),
                    let storePosition = Int(tempPositions[opcodeIndex + 3]),
                    let compute1 = Int(tempPositions[computePosition1]),
                    let compute2 = Int(tempPositions[computePosition2]) else { return }
                
                var computedValue = 0
                
                if opcode == 1 {
                    computedValue = compute1 + compute2
                } else if opcode == 2 {
                    computedValue = compute1 * compute2
                } else if opcode == 99 {
                    break
                }
                
                tempPositions[storePosition] = String(computedValue)
                
                opcodeIndex += nextOperationOffset
            }
            
            //print("Completed position 0: \(tempPositions[0])")
            if tempPositions[0] == "19690720" {
                print("Found!\nPosition 1: \(tempPositions[1])\nPosition 2: \(tempPositions[2])")
                return
            }
            
            originalPositions[2] = String(Int(originalPositions[2])! + 1)
            opcodeIndex = 0
        }
        originalPositions[2] = "0"
        originalPositions[1] = String(Int(originalPositions[1])! + 1)
        
    }
    
    
    
}

try compute()

