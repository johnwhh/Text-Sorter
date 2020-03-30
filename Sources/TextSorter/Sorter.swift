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
    
    func compare(text: String, path: String) -> String? {
        let firstLines = textToStringArray(text: text)
        let contents = getFileContents(at: path)
        
        if contents == nil {
            return nil
        }
        
        let secondLines = textToStringArray(text: contents!)
        
        if firstLines.count != secondLines.count {
            return "Test failed. The given file when sorted does not equal the sorted file."
        }
        
        for i in 0..<firstLines.count {
            if firstLines[i] != secondLines[i] {
                return "Test failed. The given file when sorted does not equal the sorted file."
            }
        }
        
        return "Test successful. The given file when sorted equals the sorted file."
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
