//
//  Observable.swift
//  Rick and Morty
//
//  Created by Chris Park on 12/17/21.
//

import Foundation

final class Observable<T> {
    typealias Listener = ((T) -> Void)
    private var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
