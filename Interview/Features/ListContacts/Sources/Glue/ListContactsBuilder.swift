//
//  ListContactsBuilder.swift
//  Interview
//
//  Created by Neylor Bagagi on 13/07/25.
//

import UIKit

protocol ListContactsBuildable {
    func build() -> UIViewController
}
 
final public class ListContactsBuilder: ListContactsBuildable {
    private var effectsManager: ListContactsEffectsManager?
    
    public init() {}
    
    public func build() -> UIViewController {
        
        let eventStream = ListContactsEventStream()
        let dataProvider = ListContactsDataProvider()
        effectsManager = ListContactsEffectsManager(
            eventStreamOutlet: eventStream.outlet(),
            dataProvider: dataProvider
        )
        let viewModel = ListContactsViewModel(dataProvider: dataProvider)
        return ListContactsViewController(
            viewModel: viewModel,
            eventStream: eventStream
        )
    }
}
