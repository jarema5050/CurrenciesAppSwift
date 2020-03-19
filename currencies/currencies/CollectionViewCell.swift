//
//  CollectionViewCell.swift
//  currencies
//
//  Created by Jedrzej Sokolowski on 17/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    private var button : CurrencyButton
    override init(frame: CGRect) {
        button = CurrencyButton(mid: "4.0749", date: "2020-20-02", code: "CHF", name: "frank francuski")
        super.init(frame: frame)
        addSubview(button)
        setupCurrencyButtonConstraints()
        
        backgroundColor = UIColor(red: 231.0/255, green: 232.0/255, blue: 234.0/255, alpha: 1)
    }
    
    fileprivate func setupCurrencyButtonConstraints(){
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
