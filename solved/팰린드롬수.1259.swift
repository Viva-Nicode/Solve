import Foundation

func solve_1259() {
    while true {
        let number = readLine()!
        if number == "0" {
            break
        } else {
            if String(number.prefix(number.count / 2)) == String(number.suffix(number.count / 2).reversed()) {
                print("yes")
            } else {
                print("no")
            }
        }
    }
}
