//
//  DemoViewModel.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 22.10.2021.
//

import Foundation
import ReactiveKit
import Bond

struct TestStruct {

}

class DemoViewModel: MvvmViewModel, DisposeBagProvider {
    let bag = DisposeBag()

    let name = Observable<String?>(nil)
    let surname = Observable<String?>(nil)
    let age = Observable<Int?>(nil)

    let payAvailable = Observable<Bool>(false)
    let payTitle = Observable<String?>("")

    required init() {
        super.init()
        title.value = "Payment form"
        makePayBindings()
    }

    func payButtonAction() {
        if let name = name.value,
           let surname = surname.value,
           let age = age.value
        {
            let model = DemoDetailsModel(name: name, surname: surname, age: age)
            navigate(to: DemoDetailsViewModel.self, prepare: model)
        }
    }
}

private extension DemoViewModel {
    func makePayBindings() {
        combineLatest(name, surname, age).observeNext { [unowned self] name, surname, age in
            if let name = name,
               let surname = surname,
               let age = age {
                if age >= 18 {
                    self.payAvailable.value = true
                    self.payTitle.value = "Pay: \(name) \(surname) \(age)"
                } else {
                    self.payAvailable.value = false
                    self.payTitle.value = "Pay unavailable: 18+ only"
                }
            } else {
                self.payAvailable.value = false
                self.payTitle.value = "Pay unavailable"
            }
        }.dispose(in: bag)
    }
}
