//
//  DemoDetailsViewModel.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 02.11.2021.
//

import Foundation
import Bond

struct DemoDetailsModel {
    var name: String
    var surname: String
    var age: Int
}

class DemoDetailsViewModel: MvvmViewModelWith<DemoDetailsModel> {
    let name = Observable<String>("")
    let age = Observable<String>("")

    override func prepare(with item: DemoDetailsModel) {
        title.value = "Detail controller"
        name.value = "\(item.name) \(item.surname)"
        age.value = "You are \(item.age) years old"
    }
}
