//
//  TableButton.swift
//  currencies
//
//  Created by Jedrzej Sokolowski on 18/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import Foundation
import UIKit

class TableButton: UIButton {
    
    private var nameLabel : UILabel
    
    private var defaultLabel : UILabel  = {
        let label = UILabel()
        label.text = "TABELA"
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    required init(name: String) {
        
        // set myValue before super.init is called
        nameLabel = {
            let label = UILabel()
            label.text = name
            label.textColor = .red
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(rawValue: 0))
            return label
        }()
        
        super.init(frame: .zero)
        
        
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(defaultLabel)
        
        setupNameLabelConstraint()
        setupDefaultLabelConstraint()
        // set other operations after super.init, if required
        //backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupNameLabelConstraint(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: defaultLabel.bottomAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75).isActive = true
    }
    
    fileprivate func setupDefaultLabelConstraint(){
        defaultLabel.translatesAutoresizingMaskIntoConstraints = false
        defaultLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        defaultLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        defaultLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        defaultLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
    }
}