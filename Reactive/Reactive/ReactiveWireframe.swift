//
//  Wireframe.swift
//  Reactive
//
//  Created by Karim Sallam on 21/01/2017.
//  Copyright © 2017 Karim Sallam. All rights reserved.
//

import UIKit

public protocol ReactiveWireframeProtocol: class {
    
    init(presentingViewController: UIViewController)

    weak var reactivePresenterProtocol: ReactivePresenterProtocol? { get set }
    
    var presentingViewController: UIViewController { get }
    
    func loadReactiveUserInterface(identifier: String, fromStoryboard name: String) -> ReactiveUserInterface
    
    func unloadReactiveUserInterface(identifier: String)
}

open class ReactiveWireframe {
    
    public weak var reactivePresenterProtocol: ReactivePresenterProtocol?
    
    public let presentingViewController: UIViewController
    
    internal var reactiveUserInterfaces = [String : ReactiveUserInterface]()
    
    public required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    deinit {
        debugPrint("\(NSStringFromClass(type(of: self))) deallocated")
    }
}

extension ReactiveWireframe: ReactiveWireframeProtocol {
    
    /// Will find the Top View Controller if it's a Navigation Controller.
    ///
    /// - Parameter name: Storyboard name
    /// - Returns: User Interface
    public func loadReactiveUserInterface(identifier: String, fromStoryboard name: String) -> ReactiveUserInterface {
        precondition(reactiveUserInterfaces[identifier] == nil, "ReactiveUserInterface \(identifier) is already loaded")
        
        let storyboard = UIStoryboard(name: name, bundle: nil)
        var reactiveUserInterface = storyboard.instantiateInitialViewController() as! ReactiveUserInterface
        // If it's a Navigation Controller load it's Top View Controller if it has one.
        // We don't care about the Navigation Controller itself. We can always get it from the Top View Controller.
        if let topViewController = (reactiveUserInterface as? ReactiveNavigationController)?.topViewController {
            reactiveUserInterface = topViewController as! ReactiveUserInterface
        }
        reactivePresenterProtocol?.add(reactiveUserInterface: reactiveUserInterface)
        reactiveUserInterfaces[identifier] = reactiveUserInterface
        
        return reactiveUserInterface
    }
    
    public func unloadReactiveUserInterface(identifier: String) {
        precondition(reactiveUserInterfaces[identifier] != nil, "ReactiveUserInterface \(identifier) is not loaded")
        
        reactivePresenterProtocol?.remove(reactiveUserInterface: reactiveUserInterfaces[identifier]!)
        reactiveUserInterfaces[identifier] = nil
    }
}
