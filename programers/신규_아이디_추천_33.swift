import Foundation

func solution_33(_ new_id: String) -> String {
    let id: String = new_id.lowercased()
        .filter { $0.isLetter || $0.isNumber || ["-", "_", "."].contains($0) }
        .reduce("") { $0.last == "." && $1 == "." ? $0: $0 + String($1) }
        .trimmingCharacters(in: ["."]).prefix(15).trimmingCharacters(in: ["."])
    return id.isEmpty ? "aaa" : id.count <= 2 ? String("\(id)\(id.last!)\(id.last!)".prefix(3)) : id
}
