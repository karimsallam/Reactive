//
//  Wireframe.swift
//  Reactive
//
//  Created by Karim Sallam on 21/01/2017.
//  Copyright © 2017 Karim Sallam. All rights reserved.
//

import UIKit

public protocol BaseReactiveWireframeProtocol: class {
    
    init(presentingViewController: UIViewController)
    
    var presentingViewController: UIViewController { get }
    
    func loadReactiveUserInterface(identifier: String, fromStoryboard name: String) -> ReactiveUserInterface
    
    func unloadReactiveUserInterface(identifier: String)
}

open class BaseReactiveWireframe: BaseReactiveWireframeProtocol {
    
    public let presentingViewController: UIViewController
    
    internal var reactiveUserInterfaces = [String : ReactiveUserInterface]()
    
    public required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
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
        
        reactiveUserInterfaces[identifier] = reactiveUserInterface
        
        return reactiveUserInterface
    }
    
    public func unloadReactiveUserInterface(identifier: String) {
        precondition(reactiveUserInterfaces[identifier] != nil, "ReactiveUserInterface \(identifier) is not loaded")
        
        reactiveUserInterfaces[identifier] = nil
    }
    
    deinit {
        debugPrint("\(NSStringFromClass(type(of: self))) deallocated")
    }
}

extension BaseReactiveWireframe {
    
    var presentingTabBarController: ReactiveTabBarController? {
        return presentingViewController as? ReactiveTabBarController
    }
}

public protocol ReactiveWireframeProtocol: BaseReactiveWireframeProtocol {
    
    weak var reactivePresenterProtocol: ReactivePresenterProtocol? { get set }
}

open class ReactiveWireframe: BaseReactiveWireframe, ReactiveWireframeProtocol {
    
    public weak var reactivePresenterProtocol: ReactivePresenterProtocol?

    override public func loadReactiveUserInterface(identifier: String, fromStoryboard name: String) -> ReactiveUserInterface {
        let reactiveUserInterface = super.loadReactiveUserInterface(identifier: identifier, fromStoryboard: name)
        reactivePresenterProtocol?.add(reactiveUserInterface: reactiveUserInterface)
        return reactiveUserInterface
    }
    
    override public func unloadReactiveUserInterface(identifier: String) {
        reactivePresenterProtocol?.remove(reactiveUserInterface: reactiveUserInterfaces[identifier]!)
        super.unloadReactiveUserInterface(identifier: identifier)
    }
}

