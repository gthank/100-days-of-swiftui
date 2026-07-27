//
//  ContentView.swift
//  WordScramble
//
//  Created by Hank Gay on 7/24/26.
//

import SwiftUI

struct ContentView: View {
    @State private var words = [String]()
    @State private var root = "miccheck"
    @State private var newWord = ""

    @State private var errTitle = ""
    @State private var errMsg = ""
    @State private var isErrorShowing = false

    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .ascii) {
                let allWords = startWords.components(separatedBy: "\n")

                root = allWords.randomElement() ?? "silkworm"
                return
            }
        }

        fatalError("Could not load starting word list (start.txt) from bundle.")
    }

    func showError(title: String, message: String) {
        errTitle = title
        errMsg = message
        isErrorShowing = true
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }

                Section {
                    ForEach(words, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(root)
            .onSubmit(addWord)
            .onAppear(perform: startGame)
            .alert(errTitle, isPresented: $isErrorShowing) { } message: {
                Text(errMsg)
            }
        }
    }

    func isOriginal(word: String) -> Bool {
        !words.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord = root

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    func isItAReal(word: String) -> Bool {
        let checker = UITextChecker()
        // If you're as annoyed about that utf16 as me, just know that it's
        // because UIKit is old as balls.
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en",
        )
        return misspelledRange.location == NSNotFound

    }

    func addWord() {
        let answer = newWord.trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        guard answer.count > 0 else { return }

        guard isOriginal(word: newWord) else {
            showError(
                title: "I Heard You The First Time",
                message: "You already used that one.",
            )
            return
        }

        guard isPossible(word: newWord) else {
            showError(
                title: "Inconceivable!",
                message: "You can't make that word with those letters.",
            )
            return
        }

        guard isItAReal(word: newWord) else {
            showError(
                title: "I don't think so, Tim",
                message: "Nice try, but that's not a real word.",
            )
            return
        }
        withAnimation {
            words.insert(answer, at: 0)
        }
        newWord = ""
    }
}

#Preview {
    ContentView()
}
