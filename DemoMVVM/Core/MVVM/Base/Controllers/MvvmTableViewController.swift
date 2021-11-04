//
//  MvvmTableViewController.swift
//  ReManga
//
//  Created by Даниил Виноградов on 04.11.2021.
//

import UIKit

class MvvmTableViewController<ViewModel: MvvmViewModel>: UITableViewController, MvvmViewControllerProtocol {
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.title.observeNext(with: { [unowned self] in title = $0 }).dispose(in: bag)
    }
}
