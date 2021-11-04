//
//  ViewController.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 22.10.2021.
//

import Bond
import UIKit

class ViewController: MvvmViewController<DemoViewModel> {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var payButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(InputCell.name)
        tableView.register(InputCell.nib, forCellReuseIdentifier: InputCell.name)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset.bottom += 58
        configureButton()
    }
}

extension ViewController {
    enum Items: CaseIterable {
        case name
        case surname
        case age
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Items.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Items.allCases[indexPath.row] {
        case .name:
            return configureNameCell(at: indexPath)
        case .surname:
            return configureSurnameCell(at: indexPath)
        case .age:
            return configureAgeCell(at: indexPath)
        }
    }
}

extension ViewController: UITableViewDelegate {}

extension ViewController {
    func configureNameCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InputCell.name, for: indexPath) as! InputCell
        cell.titleLabel.text = "Name"
        cell.textField.placeholder = "Ivan"
        viewModel.name.bidirectionalBind(to: cell.textField.reactive.text).dispose(in: cell.bag)
        return cell
    }

    func configureSurnameCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InputCell.name, for: indexPath) as! InputCell
        cell.titleLabel.text = "Surname"
        cell.textField.placeholder = "Ivanov"
        viewModel.surname.bidirectionalBind(to: cell.textField.reactive.text).dispose(in: cell.bag)
        return cell
    }

    func configureAgeCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InputCell.name, for: indexPath) as! InputCell
        cell.titleLabel.text = "Age"
        cell.textField.placeholder = "18"
        viewModel.age.bidirectionalMap(to: { element in
            String(element)
        }, from: { element in
            Int(element)
        }).bidirectionalBind(to: cell.textField.reactive.text).dispose(in: cell.bag)
        return cell
    }

    func configureButton() {
        viewModel.payAvailable.bind(to: payButton.reactive.isEnabled).dispose(in: bag)
        viewModel.payTitle.bind(to: payButton.reactive.title).dispose(in: bag)

        payButton.reactive.tap.observeNext { [unowned self] _ in
            viewModel.payButtonAction()
        }.dispose(in: bag)
    }
}

extension String {
    init?(_ num: Int?) {
        if let num = num {
            self.init(num)
        } else {
            return nil
        }
    }
}

extension Int {
    init?(_ text: String?) {
        if let text = text {
            self.init(text)
        } else {
            return nil
        }
    }
}
