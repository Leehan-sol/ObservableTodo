//
//  Observable.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import Foundation

class Observable<T> {

    // 3. listner호출됨
    var value: T {
        didSet {
            self.listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    var listener: ((T) -> Void)?
    
    func bind(_ listener: @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }
    
    
}
