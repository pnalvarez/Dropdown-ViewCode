//
//  MainViewController.swift
//  Dropdown-ViewCode
//
//  Created by Pedro Alvarez on 10/10/21.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = ContentSizedTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .green
        tableView.isScrollEnabled = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifier)
        tableView.register(OtherCell.self, forCellReuseIdentifier: OtherCell.cellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildLayout()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifier, for: indexPath) as? TableViewCell else {
                return UITableViewCell()
            }
            cell.configure(index: indexPath, delegate: self)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherCell.cellIdentifier, for: indexPath) as? OtherCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
}

extension MainViewController: TableViewCellDelegate {
    func didSelectCellHeader(at index: IndexPath) {
        tableView.reloadData()
    }
}

extension MainViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
}
