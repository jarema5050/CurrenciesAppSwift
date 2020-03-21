//
//  CollectionViewCell.swift
//  currencies
//
//  Created by Jedrzej Sokolowski on 17/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    private var button : CurrencyButton?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = AppColors.darkGrey
    }
    func setButton(mid: String, date: String, code: String, name: String){
        button?.removeFromSuperview()
        button = CurrencyButton(mid: mid, date: date, code: code, name: name)
        if let button = button {
            addSubview(button)
            //button.addTarget(self, action: #selector(currencyButtonTapped), for: .touchUpInside)
        }
        setupCurrencyButtonConstraints(button: button)
    }
    
    @objc func currencyButtonTapped(){
        
    }
    
    fileprivate func setupCurrencyButtonConstraints(button: CurrencyButton?){
        if let button = button {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            button.topAnchor.constraint(equalTo: topAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
