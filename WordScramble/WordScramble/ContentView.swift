//
//  ContentView.swift
//  WordScramble
//
//  Created by Hank Gay on 7/24/26.
//

import SwiftUI

struct ContentView: View {
    @State private var words = [String]()
    @State private var root = ""
    @State private var newWord = ""

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
        }
        .navigationTitle(root)
        .onSubmit(addWord)
    }

    func addWord() {
        let answer = newWord.trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        guard answer.count > 0 else { return }

        withAnimation {
            words.insert(answer, at: 0)
        }
        newWord = ""
    }
}

#Preview {
    ContentView()
}
