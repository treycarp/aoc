import Foundation

open class Day4 {

    public static func compute() {
        let min = "356261"
        let max = "846303"
        
        var possiblePasswordCount = 0
        var possiblePasswords = [Int]()

        for i in Int(min)!...Int(max)! {
            var foundDouble = false
            var possibleDouble = false
            var currentDoubleDigitTest = -1
            var alwaysIncreasing = true
            let digits = String(i).compactMap{ $0.wholeNumberValue }
            var previousValue = 0 
            digits.forEach {
                
                if !possibleDouble && !foundDouble && currentDoubleDigitTest != $0 {
                    possibleDouble = previousValue == $0
                    if possibleDouble {
                        currentDoubleDigitTest = $0
                    }
                } else if possibleDouble {
                    foundDouble = true
                    if previousValue == $0 && currentDoubleDigitTest == $0 {
                        //print("Triple or more: \(digits.reduce(0, {$0*10 + $1}))")
                        possibleDouble = false
                        foundDouble = false
                    } else if currentDoubleDigitTest != $0 {
                        currentDoubleDigitTest = -1
                    }
                }
                
                if $0 >= previousValue {
                    previousValue = $0
                } else { 
                    alwaysIncreasing = false
                }
                
                previousValue = $0
            }
            
            if (foundDouble || possibleDouble) && alwaysIncreasing {
                print("Found possible match: \(digits.reduce(0, {$0*10 + $1}))")
                possiblePasswordCount += 1
                possiblePasswords.append(digits.reduce(0, {$0*10 + $1}))
            }
        }

        print("Possible password count: \(possiblePasswordCount)")
    }
    
}
