import UIKit

func calculator (n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(n1, n2)
}

func add(n1: Int, n2: Int) -> Int {
    return n1 + n2
}

func multiply(n1: Int, n2: Int) -> Int {
    return n1 * n2
}

//print(calculator(n1: 2, n2: 3, operation: multiply))

calculator(n1: 2, n2: 3, operation: { (n1, n2) in n1 * n2 })

calculator(n1: 2, n2: 3, operation: { (n1, n2) in
    return n1 * n2
})

calculator(n1: 2, n2: 3, operation: { $0 * $1 })

calculator(n1: 2, n2: 3) { $0 * $1 }

let array = [6,2,3,9,4,1]


array.map{ $0 + 1 }

let newArray = array.map{ "\($0)" }
print(newArray)
