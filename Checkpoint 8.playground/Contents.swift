import Foundation

protocol Building {
    var numRooms: Int { get }
    var cost: Int { get set }
    var realtor: String { get set }
    func printSalesSummary()
}

struct House: Building {
    var numRooms: Int
    var cost: Int
    var realtor: String

    init(numRooms: Int, cost: Int, realtor: String) {
        self.numRooms = numRooms
        self.cost = cost
        self.realtor = realtor
    }

    func printSalesSummary() {
        print("This is a \(numRooms)-room house costing \(cost.formatted(.currency(code: "USD"))). It was sold by \(realtor)")
    }
}

struct Office: Building {
    var numRooms: Int
    var cost: Int
    var realtor: String

    init(numRooms: Int, cost: Int, realtor: String) {
        self.numRooms = numRooms
        self.cost = cost
        self.realtor = realtor
    }

    func printSalesSummary() {
        print("This is a \(numRooms)-room office costing \(cost.formatted(.currency(code: "USD"))). It was sold by \(realtor)")
    }
}

let tinyHome = House(numRooms: 3, cost: 50_000, realtor: "TV's own John Weisbarth and Zack Giffin")
tinyHome.printSalesSummary()
let bigAssOffice = Office(numRooms: 500, cost: 20_000_000, realtor: "Saul Goodman")
bigAssOffice.printSalesSummary()
