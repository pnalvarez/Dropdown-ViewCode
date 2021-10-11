//
//  HeaderView.swift
//  Dropdown-ViewCode
//
//  Created by Pedro Alvarez on 10/10/21.
//

import UIKit
import SnapKit

protocol HeaderViewDelegate: AnyObject {
    func didTapHeader(_ view: HeaderView)
}

class HeaderView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var iconImageView = UIImageView()
    
    weak var delegate: HeaderViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
    }
    
    convenience init() {
        self.init(frame: .zero)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(gesture)
        buildLayout()
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}

@objc
private extension HeaderView {
    func didTap() {
        delegate?.didTapHeader(self)
    }
}

extension HeaderView: ViewCode {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(iconImageView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
        }
        iconImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.right.equalToSuperview().inset(16)
            $0.width.height.equalTo(15)
        }
    }
    
    func configureViews() {
        backgroundColor = .systemPink
    }
}
