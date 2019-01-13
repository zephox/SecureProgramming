import Foundation

typealias Cases = [Case]

struct Case: Codable, Hashable {
    let ratings: String
    let name: String
    let powerSupply: String
    let price: String
    let int35B: String
    let ext525B: String
    let type: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case ratings = "ratings"
        case name = "name"
        case powerSupply = "power-supply"
        case price = "price"
        case int35B = "int35b"
        case ext525B = "ext525b"
        case type = "type"
        case id = "id"
    }
}
