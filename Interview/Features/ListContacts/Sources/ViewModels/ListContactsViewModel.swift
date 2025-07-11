import Foundation
import Combine

class ListContactsViewModel {
    
    var contacts: [Contact] = []
    
    var contactsSubject: PassthroughSubject<[Contact], Error> = PassthroughSubject()
    var viewDidLoad: (() -> Void)?
    
    // TODO: Injetar isso
    private let service = ListContactService()
    
    init() {
        binding()
    }
    
    func binding() {
        viewDidLoad = { [weak self] in
            self?.service.fetchContacts { contacts, error in
                if let error = error {
                    self?.contactsSubject.send(completion: .failure(error))
                } else if let contacts = contacts {
                    self?.contacts = contacts
                    self?.contactsSubject.send(contacts)
                }
            }
        }
    }
}
