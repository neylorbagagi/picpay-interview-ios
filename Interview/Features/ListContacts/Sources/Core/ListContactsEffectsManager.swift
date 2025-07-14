//
//  ListContactsEffectsManager.swift
//  Interview
//
//  Created by Neylor Bagagi on 14/07/25.
//

import Combine

protocol ListContactsEffectsCreating {
    func viewDidLoad()
}

final class ListContactsEffectsManager: ListContactsEffectsCreating {
        
    private var eventStreamOutlet: ListContactsEventStream.Outlet
    private let dataProvider: ListContactsDataProviding
    private var cancellables = Set<AnyCancellable>()
    
    init(eventStreamOutlet: ListContactsEventStream.Outlet,
         dataProvider: ListContactsDataProviding) {
        self.eventStreamOutlet = eventStreamOutlet
        self.dataProvider = dataProvider
        
        binding()
    }
    
    private func binding() {
        eventStreamOutlet.sink { [weak self] event in
            switch event {
                case .viewDidLoad:
                    self?.viewDidLoad()
            }
        }.store(in: &cancellables)
    }
    
    internal func viewDidLoad() {
        self.dataProvider.getListContactsData()
    }
}
