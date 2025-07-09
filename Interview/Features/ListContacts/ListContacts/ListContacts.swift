//
//  ListContacts.swift
//  ListContacts
//
//  Created by Neylor Bagagi on 09/07/25.
//  Copyright © 2025 PicPay. All rights reserved.
//

import Foundation
import UIKit

public struct ListContacts {
    public init() {}
    
    public func build() -> UIViewController {
        // Crie e retorne o ViewController principal do módulo
        return ListContactsViewController()
    }
}
