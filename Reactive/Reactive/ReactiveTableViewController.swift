//
//  ReactiveTableViewController.swift
//  RealTimeMenu
//
//  Created by Karim Sallam on 28/11/2016.
//  Copyright © 2016 Karim Sallam. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

public protocol ReactiveTableViewUserInterface: class {
    
    var dataSource: ReactiveTableViewDataSource? { get set }

    var cellForRowAtIndexPathSignal: Signal<(ReactiveTableViewCellUserInterface, IndexPath), NoError> { get }
    
    func reloadData()
}

public protocol ReactiveTableViewDataSource: class {
    
    func numberOfSectionsIn(reactiveTableViewUserInterface: ReactiveTableViewUserInterface) -> Int
    
    func reactiveTableViewUserInterface(_ reactiveTableViewUserInterface: ReactiveTableViewUserInterface, numberOfRowsIn section: Int) -> Int
    
    func reactiveTableViewUserInterface(_ reactiveTableViewUserInterface: ReactiveTableViewUserInterface, reusableCellIdentifierForCellAt indexPath: IndexPath) -> String
}

open class ReactiveTableViewController: UITableViewController {
    
    public let reactiveState = MutableProperty<ReactiveState>(.loading)
    
    public let viewState = MutableProperty<ViewState>(.Invisible)
    
    public var reactiveIdentifier = UUID().uuidString
    
    public var dataSource: ReactiveTableViewDataSource?
    
    public var cellForRowAtIndexPathSignal: Signal<(ReactiveTableViewCellUserInterface, IndexPath), NoError> {
        return _cellForRowAtIndexPathSignal
    }
    
    private let (_cellForRowAtIndexPathSignal, cellForRowAtIndexPathObserver) = Signal<(ReactiveTableViewCellUserInterface, IndexPath), NoError>.pipe()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        reactiveState.value = .ready
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewState.value = .WillBecomeVisible
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewState.value = .Visible
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewState.value = .WillBecomeInvisible
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewState.value = .Invisible
    }
    
    open func bind() {
        // Do nothing.
    }
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        guard let dataSource = dataSource else {
            return 0
        }
        
        return dataSource.numberOfSectionsIn(reactiveTableViewUserInterface: self)
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else {
            return 0
        }
        
        return dataSource.reactiveTableViewUserInterface(self, numberOfRowsIn: section)
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = dataSource!.reactiveTableViewUserInterface(self, reusableCellIdentifierForCellAt: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ReactiveTableViewCell
        cellForRowAtIndexPathObserver.send(value: (cell, indexPath))
        return cell
    }
    
    deinit {
        cellForRowAtIndexPathObserver.sendCompleted()
        debugPrint("\(NSStringFromClass(type(of: self))) deallocated")
    }
}

extension ReactiveTableViewController: ReactiveUserInterface {
    
    open func prepareForReuse() {
        // Do nothing.
    }
}

extension ReactiveTableViewController: ReactiveTableViewUserInterface {
    
    open func reloadData() {
        tableView.reloadData()
    }
}
