//
//  EventStream.swift
//  Interview
//
//  Created by Neylor Bagagi on 14/07/25.
//

import Combine
import Foundation

/// An object that broadcasts elements to downstream subscribers.
/// This is a thin wrapper of a ``PassthroughSubject`` that never completes or fails.
public struct EventStream<EventType> {
    /// A type-erasing AnyPublisher that allows downstream to subscribe to the events,
    /// and hides the ``send(_:)`` functionality.
    public typealias Outlet = AnyPublisher<EventType, Never>

    private let passthroughSubject: PassthroughSubject<EventType, Never>

    public init() {
        self.passthroughSubject = PassthroughSubject<EventType, Never>()
    }

    /// Sends an event to the subscriber of this EventStream.
    ///
    /// - Parameter event: The event to send.
    public func send(_ event: EventType) {
        passthroughSubject.send(event)
    }

    /// Returns the ``Outlet`` that downstream subscribers can subscribe to.
    public func outlet() -> Outlet {
        passthroughSubject.eraseToAnyPublisher()
    }
}
