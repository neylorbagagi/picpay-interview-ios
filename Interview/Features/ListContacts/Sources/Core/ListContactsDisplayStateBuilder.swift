//
//  ListContactsDisplayStateBuilder.swift
//  Interview
//
//  Created by Neylor Bagagi on 13/07/25.
//

final class ListContactsDisplayStateBuilder {
    
    static func build(from data: ListContactsDataModel) -> ListContactsDisplayState {
        ListContactsDisplayState(
            navigationControllerTitle: navigationControllerTitle(),
            contactsCellViewDisplayState: conctactsViewCellDisplayState(from: data.contacts)
        )
    }
    
    private static func navigationControllerTitle() -> String {
        return "Lista de contatos"
    }
    
    private static func conctactsViewCellDisplayState(from data: [ContactDataModel]) -> [ListContactsCellDisplayState] {
        return data.map { contact in
            ListContactsCellDisplayState(
                name: contact.name,
                photoURL: contact.photoURL
            )
        }
    }
}
