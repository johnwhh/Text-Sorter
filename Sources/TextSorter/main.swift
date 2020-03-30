import ArgumentParser

struct TextSort: ParsableCommand {
    @Argument(help: "The name of the unsorted text file.")
    var unsortedFilePath: String
    
    func run() throws {
        let sorter = Sorter()
        let text = sorter.sort(path: unsortedFilePath)
        
        print(text ?? "Unable to sort text.")
    }
}

TextSort.main()
