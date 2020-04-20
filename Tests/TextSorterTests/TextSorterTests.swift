import XCTest
import class Foundation.Bundle
import Foundation

final class TextSorterTests: XCTestCase {
    
    func testSorter() throws {
        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return
        }

        let product = productsDirectory.appendingPathComponent("TextSorter")

        let process = Process()
        process.arguments = [unsortedPath]

        process.executableURL = product

        let pipe = Pipe()
        process.standardOutput = pipe

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)

        XCTAssertEqual(output!, sortedText)
    }
    
    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }
    
    var projectDirectory: URL {
        return URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
    }
    
    var unsortedPath: String {
        return projectDirectory.appendingPathComponent("Unsorted.txt").path
    }
    
    var sortedText: String {
        let path = projectDirectory.appendingPathComponent("Sorted.txt").path
        return try! String(contentsOfFile: path, encoding: .utf8)
    }
    
    static var allTests = [
        ("testSorter", testSorter),
    ]
}
