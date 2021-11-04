//
//  MvvmViewModel.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 02.11.2021.
//

import UIKit
import Bond

class MvvmViewModel {
    let title = Observable<String?>(nil)

    func setAttachedView(_ viewController: UIViewController) {
        guard attachedView == nil else { fatalError("attachedView cannot be reattached") }
        attachedView = viewController
    }

    private(set) weak var attachedView: UIViewController!

    required init() {}
}

class MvvmViewModelWith<T>: MvvmViewModel {
    func prepare(with item: T) {}
}
