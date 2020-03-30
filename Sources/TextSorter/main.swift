import ArgumentParser

struct TextSort: ParsableCommand {
    @Argument(help: "The name of the unsorted text file.")
    var unsortedFilePath: String
    
    @Argument(help: "The name of the sorted text file.")
    var sortedFilePath: String?
    
    func run() throws {
        let sorter = Sorter()
        let text = sorter.sort(path: unsortedFilePath)
        
        if sortedFilePath != nil {
            let output = sorter.compare(text: text!, path: sortedFilePath!)
            print(output ?? "Unable to sort text.")
        } else {
            print(text ?? "Unable to sort text.")
        }
    }
}

TextSort.main()
