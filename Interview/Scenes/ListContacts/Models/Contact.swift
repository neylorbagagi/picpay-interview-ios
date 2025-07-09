import Foundation

struct Contact: Codable {
    var id: Int
    var name: String
    var photoURL: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case photoURL = "photoURL"
        case id = "id"
    }
    
}
