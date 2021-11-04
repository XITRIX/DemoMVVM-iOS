//
//  DemoDetailsViewController.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 02.11.2021.
//

import UIKit
import Bond

class DemoDetailsViewController: MvvmViewController<DemoDetailsViewModel> {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.name.bind(to: nameLabel.reactive.text).dispose(in: bag)
        viewModel.age.bind(to: ageLabel.reactive.text).dispose(in: bag)
    }
}
