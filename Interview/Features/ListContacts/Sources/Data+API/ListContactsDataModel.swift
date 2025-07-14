import Foundation

// TODO: The name ListContacts must be refactored, maybe ListContactDataModel?
struct ListContactsDataModel: Codable {
    let contacts: [ContactDataModel]
}

struct ContactDataModel: Codable {
    var id: Int
    var name: String
    var photoURL: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case photoURL = "photoURL"
        case id = "id"
    }
}

extension ListContactsDataModel {
    static func emptyDataModel() -> ListContactsDataModel {
        return ListContactsDataModel(contacts: [])
    }
}
