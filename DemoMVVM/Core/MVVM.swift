//
//  MVVM.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 03.11.2021.
//

import Foundation

class MVVM {
    static let shared = MVVM()

    let container: Container
    var router: Router! {
        container.resolve(type: Router.self)
    }

    init() {
        container = Container()

        registerContainer()
        registerRouting()
    }
}

extension MVVM {
    func registerContainer() {
        // Register services
        container.registerSingleton { Router(container: self.container) }

        // Register ViewModels
        container.register() { DemoViewModel() }
        container.register() { DemoDetailsViewModel() }

        // Register ViewControllers
        container.register() { ViewController() }
        container.register() { DemoDetailsViewController() }
    }

    func registerRouting() {
        router.register(viewModel: DemoViewModel.self, viewController: ViewController.self)
        router.register(viewModel: DemoDetailsViewModel.self, viewController: DemoDetailsViewController.self)
    }
}
