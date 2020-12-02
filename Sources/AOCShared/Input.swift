//
//  Input.swift
//  AOC
//
//  Created by Trey Carpenter on 12/9/19.
//

import Foundation

public final class Input {
    
    private func readFile(name: String, year: String) -> String {
        let fileURL = inputFileURL(name: name, year: year)
        do {
            return try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
        } catch let error {
            print("Error parsing file: \(error)")
        }
        return ""
    }
    
    public func inputFileURL(name: String, year: String) -> URL? {
        let root = URL(fileURLWithPath: "\(#file)").deletingLastPathComponent()
                                                    .deletingLastPathComponent()
                                                    .appendingPathComponent("AOC\(year)")
        guard let enumerator = FileManager.default.enumerator(
            at: root,
            includingPropertiesForKeys: [.nameKey],
            options: [.skipsHiddenFiles, .skipsPackageDescendants],
            errorHandler: nil) else {
                fatalError("Could not enumerate \(root)")
        }

        for case let url as URL in enumerator where url.isFileURL {
            if url.lastPathComponent == name {
                return url
            }
        }
        
        return nil
    }
    
    public func numbers(name: String, year: String) -> [Int] {
        let content = readFile(name: name, year: year)
        return content.split { $0.isNewline }.compactMap{ Int($0) }
    }
    
    public func strings(name: String, year: String) -> [String] {
        let content = readFile(name: name, year: year)
        return content.split { $0.isNewline }.compactMap{ String($0) }
    }
    
    public func numbersCsv(name: String, year: String) -> [Int] {
        let content = readFile(name: name, year: year).trimmingCharacters(in: .newlines)
        return content.components(separatedBy: ",").compactMap{ Int($0) }
    }

    public func charactersInLines(name: String, year: String) -> [[String]] {
        let content = readFile(name: name, year: year).split { $0.isNewline }
        var results = [[String]]()
        content.forEach {
            results.append( [String($0)] )
        }
        return results
    }
    
    public func arrayOfCharacterLines(name: String, year: String) -> [[String]] {
        let content = readFile(name: name, year: year).split { $0.isNewline }
        var results = [[String]]()
        content.forEach {
            results.append($0.map { String($0) })
        }
        return results
    }
}
