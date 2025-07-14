//
//  ListContactsDisplayState.swift
//  Interview
//
//  Created by Neylor Bagagi on 13/07/25.
//

struct ListContactsDisplayState {
    let navigationControllerTitle: String
    let contactsCellViewDisplayState: [ListContactsCellDisplayState]
}

struct ListContactsCellDisplayState {
    let name: String
    let photoURL: String
}

extension ListContactsDisplayState {
    static func emptyDisplayState() -> ListContactsDisplayState {
        return ListContactsDisplayState(
            navigationControllerTitle: "",
            contactsCellViewDisplayState: []
        )
    }
}

extension ListContactsCellDisplayState {
    static func emptyDisplayState() -> ListContactsCellDisplayState {
        return ListContactsCellDisplayState(name: "", photoURL: "")
    }
}
