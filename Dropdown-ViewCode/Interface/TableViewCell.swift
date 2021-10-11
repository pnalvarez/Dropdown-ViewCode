//
//  TableViewCell.swift
//  Dropdown-ViewCode
//
//  Created by Pedro Alvarez on 10/10/21.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
    func didSelectCellHeader(at index: IndexPath)
}

class TableViewCell: UITableViewCell {
    static let cellIdentifier = "TableViewCell"
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.configure(title: "Título")
        view.delegate = self
        return view
    }()
    
    private lazy var tableView: ContentSizedTableView = {
        let tableView = ContentSizedTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .blue
        tableView.isScrollEnabled = false
        tableView.register(OtherCell.self, forCellReuseIdentifier: OtherCell.cellIdentifier)
        return tableView
    }()
    
    private var expanded = true {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var index: IndexPath?
    private weak var delegate: TableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        backgroundColor = .purple
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(index: IndexPath, delegate: TableViewCellDelegate? = nil) {
        self.index = index
        self.delegate = delegate
    }
}

extension TableViewCell: HeaderViewDelegate {
    func didTapHeader(_ view: HeaderView) {
        expanded = !expanded
        delegate?.didSelectCellHeader(at: index ?? IndexPath())
    }
}

extension TableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        expanded ? 10 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherCell.cellIdentifier, for: indexPath) as? OtherCell else {
            return UITableViewCell()
        }
        return cell
    }
}

extension TableViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.left.right.equalToSuperview().inset(16)
        }
    }
}
