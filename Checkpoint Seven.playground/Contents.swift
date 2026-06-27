import UIKit

class Animal {
    private(set) var legs: Int
    private var whatToSay: String

    init(legs: Int, whatToSay: String) {
        self.legs = legs
        self.whatToSay = whatToSay
    }

    final func speak() {
        print(whatToSay)
    }
}

class Dog : Animal {
    init(whatToSay: String = "Bark! Bark! Bark!") {
        super.init(legs: 4, whatToSay: whatToSay)
    }
}

class Corgi : Dog {
    init() {
        super.init(whatToSay: "Yip! Yip! Yip!")
    }
}

class Poodle : Dog {
    init() {
        super.init(whatToSay: "Grrr!")
    }
}

class Cat : Animal {
    let isTame: Bool

    init(isTame: Bool, whatToSay: String = "Meow!") {
        self.isTame = isTame
        super.init(legs: 4, whatToSay: whatToSay)
    }
}

class Persian : Cat {
    init() {
        super.init(isTame: true, whatToSay: "I'm spoiled")
    }
}

class Lion : Cat {
    init() {
        super.init(isTame: false, whatToSay: "ROOOOAARRRR!")
    }
}
let animals: [Animal] = [Corgi(), Poodle(), Persian(), Lion()]
for animal in animals {
    animal.speak()
}
