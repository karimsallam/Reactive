//
//  ReactiveUserInterface.swift
//  DatePlay
//
//  Created by Karim Sallam on 21/12/2016.
//  Copyright © 2016 Karim Sallam. All rights reserved.
//

import Foundation
import ReactiveSwift

public enum ReactiveState {

    case loading
    
    case ready
}

public enum ViewState {
    
    case Invisible
    
    case WillBecomeVisible
    
    case Visible
    
    case WillBecomeInvisible
}

public protocol ReactiveUserInterface: class {
    
    var reactiveState: MutableProperty<ReactiveState> { get }
    
    var viewState: MutableProperty<ViewState> { get }
    
    var reactiveIdentifier: String { get }
    
    func prepareForReuse()
}

public func ==(lhs: ReactiveUserInterface, rhs: ReactiveUserInterface) -> Bool {
    return lhs.reactiveIdentifier == rhs.reactiveIdentifier
}
