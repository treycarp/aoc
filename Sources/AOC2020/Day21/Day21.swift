//
//  Day21.swift
//  AOC2020
//
//  Created by Trey Carpenter on 12/22/20.
//

import Foundation

public class Day21: Day {
    
    public override func part1() -> String {
        let lines = Input().strings(name: "Day21Input.txt", year: "2020")
        var foods = [Food]()
        var uniqueAllergens = Set<String>()
        var translation: [String: Set<String>] = [:]
        for line in lines {
            guard let allergenStart = line.firstIndex(of: "(") else {
                foods.append(Food(ingredients: line, allergens: nil))
                continue
            }
            
            let allergenInfo = line.suffix(from: allergenStart).replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ")", with: "").split(separator: " ").dropFirst().map { String($0) }
            foods.append(Food(ingredients: String(line.prefix(upTo: allergenStart)), allergens: allergenInfo))
            allergenInfo.forEach { uniqueAllergens.insert($0) }
        }
        
        for allergen in uniqueAllergens {
            
            let fca = foods.filter { $0.allergens?.contains(allergen) == true }
            let ingredientLists = fca.map { food -> [String] in
                food.ingredients.split(separator: " ").map { String($0) }
            }
            let firstList =  ingredientLists.first ?? []

            let commonElements = ingredientLists.reduce(Set(firstList)) { (result, list)  in
                let intersection = result.intersection(list)
                return intersection
            }
            translation[allergen] = commonElements
        }
        
        // remove other allergens from sets.
        for allergen in translation.keys {
            for otherAllergen in translation.keys {
                guard let ingredients = translation[allergen],
                      let otherIngredients = translation[otherAllergen] else { continue }
                if allergen == otherAllergen { continue }
                if ingredients.count > 1 && otherIngredients.count == 1 && ingredients.contains(otherIngredients.first!) {
                    translation[allergen]?.remove(otherIngredients.first!)
                }
            }
        }
        
        var notAllergens = [String]()
        for food in foods {
            let ingredientLists = food.ingredients.split(separator: " ").map { String($0) }
            for ingredient in ingredientLists {
                var notFound = true
                for (_, allergens) in translation.enumerated() {
                    for allergen in allergens.value {
                        if ingredient == allergen {
                            notFound = false
                        }
                    }
                }
                
                if notFound {
                    notAllergens.append(ingredient)
                }
            }
        }
        
        return "Answer: \(notAllergens.count)"
    }
    
    public override func part2() -> String {
        let lines = Input().strings(name: "Day21Input.txt", year: "2020")
        var foods = [Food]()
        var uniqueAllergens = Set<String>()
        var translation: [String: Set<String>] = [:]
        for line in lines {
            guard let allergenStart = line.firstIndex(of: "(") else {
                foods.append(Food(ingredients: line, allergens: nil))
                continue
            }
            
            let allergenInfo = line.suffix(from: allergenStart).replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ")", with: "").split(separator: " ").dropFirst().map { String($0) }
            foods.append(Food(ingredients: String(line.prefix(upTo: allergenStart)), allergens: allergenInfo))
            allergenInfo.forEach { uniqueAllergens.insert($0) }
        }
        
        for allergen in uniqueAllergens {
            
            let fca = foods.filter { $0.allergens?.contains(allergen) == true }
            let ingredientLists = fca.map { food -> [String] in
                food.ingredients.split(separator: " ").map { String($0) }
            }
            let firstList =  ingredientLists.first ?? []

            let commonElements = ingredientLists.reduce(Set(firstList)) { (result, list)  in
                let intersection = result.intersection(list)
                return intersection
            }
            translation[allergen] = commonElements
        }
        
        // remove other allergens from sets.
        while !translation.values.allSatisfy { $0.count == 1 } {
            for allergen in translation.keys {
                for otherAllergen in translation.keys {
                    guard let ingredients = translation[allergen],
                          let otherIngredients = translation[otherAllergen] else { continue }
                    if allergen == otherAllergen { continue }
                    if ingredients.count > 1 && otherIngredients.count == 1 && ingredients.contains(otherIngredients.first!) {
                        translation[allergen]?.remove(otherIngredients.first!)
                    }
                }
            }
        }
        
        var string = ""
        
        for allergen in translation.keys.sorted { $0 < $1 } {
            string.append("\(translation[allergen]!.first!),")
        }
        
        
        return "Answer: \(string)"
    }
}

struct Food {
    let ingredients: String
    let allergens: [String]?
}
