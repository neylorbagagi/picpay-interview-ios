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
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoURL = try container.decode(String.self, forKey: .photoURL)
        self.id = try container.decode(Int.self, forKey: .id)
    }
}
