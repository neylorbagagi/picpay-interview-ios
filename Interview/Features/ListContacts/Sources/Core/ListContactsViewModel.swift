import Foundation
import Combine

final class ListContactsViewModel {
    
    @Published private var displayState: ListContactsDisplayState
    
    var displayStateSubject: Published<ListContactsDisplayState>.Publisher {
        $displayState
    }
    
    var viewDidLoad: (() -> Void)?
    
    private var cancellables = Set<AnyCancellable>()
    private let dataProvider: ListContactsDataProviding
    
    init(dataProvider: ListContactsDataProviding) {
        self.dataProvider = dataProvider
        self.displayState = .emptyDisplayState()
        
        binding()
    }
    
    private func binding() {
        viewDidLoad = { [weak self] in
            self?.dataProvider.getListContactsData()
        }
        
        dataProvider.dataModel
            .sink { [weak self] dataModel in
                self?.updateDisplayState(data: dataModel)
            }.store(in: &cancellables)
    }
    
    private func updateDisplayState(data: ListContactsDataModel) {
        let newState = ListContactsDisplayStateBuilder.build(from: data)
        displayState = newState
    }
}
