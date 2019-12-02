import UIKit

func sumFuel() throws {
    let fileURL = Bundle.main.url(forResource: "Day1Input", withExtension: "txt")
    let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    let lines = content.split { $0.isNewline }
    var sum = 0
    lines.forEach {
        guard let baseValue = Int($0) else { return }
        
        let fuelNeeded = compoundingAmountNeeded(total: 0, amount: baseValue)
        print("Base value: \(baseValue)\nNeeded value: \(fuelNeeded)")
        sum += fuelNeeded
    }

    print(sum)
}

func fuelAmountNeeded(_ baseValue: Int) -> Int {
    (Int(baseValue / 3)  - 2)
}

func compoundingAmountNeeded(total: Int, amount: Int) -> Int {
    var totalAmount = total
    if amount > 0 && fuelAmountNeeded(amount) > 0 {
        totalAmount += fuelAmountNeeded(amount)
        return compoundingAmountNeeded(total: totalAmount, amount: fuelAmountNeeded(amount))
    }
    
    return totalAmount
}

try sumFuel()
