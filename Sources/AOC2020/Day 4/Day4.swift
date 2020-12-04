//
//  Day4.swift
//  AOC
//
//  Created by Trey Carpenter on 12/3/20.
//

import Foundation

public class Day4: Day {
    
    public override func part1() -> String {
        let strings = Input().stringsByBlankLine(name: "Day4Input.txt", year: "2020")
        let passports: [Passport] = strings.compactMap { Passport(rawString: $0) }
        let validPassports = passports.filter {
            $0.hasRequiredFields()
        }
        
        return "Valid passports: \(validPassports.count)"
    }
    
    public override func part2() -> String {
        let strings = Input().stringsByBlankLine(name: "Day4Input.txt", year: "2020")
        let passports: [Passport] = strings.compactMap { Passport(rawString: $0) }
        let validPassports = passports.filter {
            let valid = $0.meetsFieldCriteria()
            print("\(valid ? "Valid" : "Invalid") Passport: \($0.printDescription())")
            return valid
        }
        
        return "Valid passports: \(validPassports.count)"
    }
}

struct Passport {
    var birthYear: String?
    var birthYearValid: Bool {
        guard let birthYear = birthYear,
              birthYear.count == 4,
              let birthYearNumber = Int(birthYear) else { return false }
        return birthYearNumber <= 2002 && birthYearNumber >= 1920
    }
    var issueYear: String?
    var issueYearValid: Bool {
        guard let issueYear = issueYear,
              issueYear.count == 4,
              let issueYearNumber = Int(issueYear) else { return false }
        return issueYearNumber <= 2020 && issueYearNumber >= 2010
    }
    var expirationYear: String?
    var expirationYearValid: Bool {
        guard let expirationYear = expirationYear,
              expirationYear.count == 4,
              let expirationYearNumber = Int(expirationYear) else { return false }
        return expirationYearNumber <= 2030 && expirationYearNumber >= 2020
    }
    var height: String?
    var heightValid: Bool {
        guard let height = height else { return false }
        let end = height.suffix(2)
        switch end {
        case "cm":
            guard let heightInt = Int(height.prefix(height.count - 2)) else { return false }
            return  heightInt >= 150 && heightInt <= 193
        case "in":
            guard let heightInt = Int(height.prefix(height.count - 2)) else { return false }
            return  heightInt >= 59 && heightInt <= 76
        default: return false
        }
    }
    var hairColor: String?
    var hairColorValid: Bool {
        guard let hairColor = hairColor else { return false }
        return try! NSRegularExpression(pattern: "^#(?:[0-9a-f]{3}){2}$").matches(hairColor)
    }
    var eyeColor: String?
    var eyeColorValid: Bool {
        guard let eyeColor = eyeColor else { return false}
        return eyeColor == "amb" || eyeColor == "blu" ||  eyeColor == "brn" || eyeColor == "gry" || eyeColor == "grn" || eyeColor == "hzl" || eyeColor == "oth"
    }
    var passportId: String?
    var passportValid: Bool {
        guard let passportId = passportId else { return  false }
        return try! NSRegularExpression(pattern: "^[0-9]{9}$").matches(passportId)
    }
    var countryId: String?
}

extension Passport {
    init(rawString: String) {
        let parts = rawString.split(separator: " ")
        parts.forEach {
            let splitParts = $0.split(separator: ":")
            switch PassportField(rawValue: String(splitParts[0])) {
                case .byr: self.birthYear = String(splitParts[1])
                case .iyr: self.issueYear = String(splitParts[1])
                case .eyr: self.expirationYear = String(splitParts[1])
                case .hgt: self.height = String(splitParts[1])
                case .hcl: self.hairColor = String(splitParts[1])
                case .ecl: self.eyeColor = String(splitParts[1])
                case .pid: self.passportId = String(splitParts[1])
                case .cid: self.countryId = String(splitParts[1])
            case .none:
                break
            }
        }
    }
    
    func hasRequiredFields() -> Bool {
        
        birthYear != nil
            && issueYear != nil
            && expirationYear != nil
            && height != nil
            && hairColor != nil
            && eyeColor != nil
            && passportId != nil
    }
    
    func meetsFieldCriteria() -> Bool {
        guard hasRequiredFields() else { return false }
        
        return birthYearValid && issueYearValid && expirationYearValid && heightValid && hairColorValid && eyeColorValid && passportValid
    }
    
    func printDescription() -> String {
        let isBY = birthYearValid
        let isIY = issueYearValid
        let isEY = expirationYearValid
        let isH = heightValid
        let isHC = hairColorValid
        let isEC = eyeColorValid
        let isPID = passportValid
        
        return "\(!isBY ? "birthdate invalid\n" : "")\(!isIY ? "issue year invalid\n" : "")\(!isEY ? "expiration year invalid\n" : "")\(!isH ? "height invalid\n" : "")\(!isHC ? "haircolor invalid\n" : "")\(!isEC ? "eyecolor invalid\n" : "")\(!isPID ? "passport invalid\n" : "") \(self)\n"
    }
}

enum PassportField: String {
    case byr
    case iyr
    case eyr
    case hgt
    case hcl
    case ecl
    case pid
    case cid
}
