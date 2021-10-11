//
//  ViewCode.swift
//  Dropdown-ViewCode
//
//  Created by Pedro Alvarez on 10/10/21.
//

protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCode {
    func configureViews() { }
    
    func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
