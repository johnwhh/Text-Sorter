//
//  Sort.swift
//
//
//  Created by John Holtzworth on 3/30/20.
//
import Foundation

struct Sorter {
    func sort(path: String) -> String? {
        let fileContents = getFileContents(at: path)
        if fileContents != nil {
            return sortAscending(text: sortAlphabetically(text: fileContents!))
        }
        return nil
    }
    
    private func getFileContents(at path: String) -> String? {
        let url = URL(fileURLWithPath: path)
        
        do {
            return try String(contentsOf: url)
        } catch {
            print("File does not exist.")
        }
        
        return nil
    }

    private func sortAscending(text: String) -> String {
        let lines = textToStringArray(text: text)
        let sortedLines = lines.sorted { $0.count < $1.count }
        return stringArrayToText(array: sortedLines)
    }

    private func sortAlphabetically(text: String) -> String {
        let lines = textToStringArray(text: text)
        let sortedLines = lines.sorted { $0.self < $1.self }
        return stringArrayToText(array: sortedLines)
    }

    private func stringArrayToText(array: [String]) -> String {
        var text = ""
        
        for line in array {
            text += line + "\n"
        }
        
        return text
    }

    private func textToStringArray(text: String) -> [String] {
        var lines = text.split(separator: "\n").map(String.init)
        
        for i in 0..<lines.count {
            lines[i] = lines[i].trimmingCharacters(in: .whitespaces)
        }
        
        return lines
    }
}
