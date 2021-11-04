//
//  Router.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 03.11.2021.
//

import Foundation

class Router {
    private let container: Container
    private var map = [String: Any]()

    init(container: Container) {
        self.container = container
    }

    func register<VM: MvvmViewModel, VC: MvvmViewController<VM>>(viewModel: VM.Type, viewController: VC.Type) {
        map["\(viewModel)"] = viewController
    }

    func resolve<VM: MvvmViewModel, VC: MvvmViewController<VM>>(viewModel: VM.Type) -> VC {
        if let resolver = map["\(viewModel)"] as? VC.Type {
            let viewModel = VM.init()
            let vc = resolver.init()
            vc.setViewModel(viewModel)
            return vc
        }
        fatalError("\(viewModel) is not registered")
    }

    func resolve<M, VM: MvvmViewModelWith<M>, VC: MvvmViewController<VM>>(viewModel: VM.Type, prepare model: M) -> VC {
        if let resolver = map["\(viewModel)"] as? VC.Type {
            let viewModel = VM.init()
            let vc = resolver.init()
            viewModel.prepare(with: model)
            vc.setViewModel(viewModel)
            return vc
        }
        fatalError("\(viewModel) is not registered")
    }
}
