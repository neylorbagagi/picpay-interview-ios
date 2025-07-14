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
    
    public init() {}
    
    public func build() -> UIViewController {
        let dataProvider = ListContactsDataProvider()
        let viewModel = ListContactsViewModel(dataProvider: dataProvider)
        return ListContactsViewController(viewModel: viewModel)
    }
}
