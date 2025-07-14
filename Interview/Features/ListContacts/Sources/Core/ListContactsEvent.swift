//
//  ListContactsEvent.swift
//  Interview
//
//  Created by Neylor Bagagi on 14/07/25.
//

import Foundation
import Combine
import FeatureFoundation

typealias ListContactsEventStream = EventStream<ListContactsEvent>

enum ListContactsEvent {
    case viewDidLoad
}
