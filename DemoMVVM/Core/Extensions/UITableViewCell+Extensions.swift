//
//  UITableViewCell+Extensions.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 03.11.2021.
//

import UIKit

extension UITableViewCell {
    static var nib: UINib { UINib(nibName: name, bundle: nil) }
    static var name: String { String(describing: Self.self) }
}

extension UICollectionViewCell {
    static var nib: UINib { UINib(nibName: name, bundle: nil) }
    static var name: String { String(describing: Self.self) }
}

extension UITableView {
    func register<CELL: UITableViewCell>(cell: CELL.Type) {
        register(CELL.nib, forCellReuseIdentifier: CELL.name)
    }

    func dequeue<CELL: UITableViewCell>(for indexPath: IndexPath) -> CELL {
        if let cell = dequeueReusableCell(withIdentifier: CELL.name, for: indexPath) as? CELL {
            return cell
        }
        fatalError("\(CELL.self) is not registered")
    }
}

extension UICollectionView {
    func register<CELL: UICollectionViewCell>(cell: CELL.Type) {
        register(CELL.nib, forCellWithReuseIdentifier: CELL.name)
    }

    func dequeue<CELL: UICollectionViewCell>(for indexPath: IndexPath) -> CELL {
        if let cell = dequeueReusableCell(withReuseIdentifier: CELL.name, for: indexPath) as? CELL {
            return cell
        }
        fatalError("\(CELL.self) is not registered")
    }
}
