func pickOne(from choices: [Int]?) -> Int {
    choices?.randomElement() ?? Int.random(in: 0...100)
}
let actualChoices: [Int]? = [23, 42, 69]
for _ in 1..<10 {
    print("This time we got: \(pickOne(from: actualChoices))")
}
let illusionOfChoice: [Int]? = nil
for _ in 1..<10 {
    print("I had to make this one up: \(pickOne(from: illusionOfChoice))")
}
let thisIsJustMean: [Int] = []
print("You suck! \(pickOne(from: thisIsJustMean))")
