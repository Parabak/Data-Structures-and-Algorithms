import Foundation

final class TrieNode {
    var isTerminal: Bool
    var value: Character
    var children = [TrieNode]()

    init(value: Character, isTerminal: Bool) {
        self.isTerminal = isTerminal
        self.value = value
    }
}

public final class Trie {
    var root = TrieNode(value: Character("-"), isTerminal: false)

    func insertIfNoPrefixExist(_ word: String) -> Bool {

        var pointer = root

        for (index, char) in word.enumerated() {
            let isTerminalChar = index == word.count - 1

            if let exist = pointer.children.first(where: { $0.value == char }) {
                exist.isTerminal = exist.isTerminal || isTerminalChar

                pointer = exist

                if pointer.isTerminal {
                    return false
                }
            } else {
                let new = TrieNode(value: char, isTerminal: isTerminalChar)
                pointer.children.append(new)

                pointer = new
            }
        }

        return true
    }
}

// Hackerank task
func findPrefix(words: [String]) -> String? {

    let length = words.first?.count ?? 0
    let notEqualLenght = words.first { $0.count != length }
    if notEqualLenght == nil {

        let set = Set(words)
        if set.count == words.count {
            return nil
        }
    }

    let trie = Trie()

    for word in words {
        if trie.insertIfNoPrefixExist(word) == false {
            return word
        }
    }

    return nil
}




