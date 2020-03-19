//
//  CurrencyButton.swift
//  currencies
//
//  Created by Jedrzej Sokolowski on 18/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import Foundation
import UIKit

class CurrencyButton: UIButton {
    
    private var nameLabel : UILabel
    private var dateLabel : UILabel
    private var codeLabel : UILabel
    private var midLabel : UILabel
    required init(mid: String, date: String, code: String, name: String) {
        
        // set myValue before super.init is called
        nameLabel = {
            let label = UILabel()
            label.text = name
            label.textColor = .gray
            label.textAlignment = .center
            return label
        }()
        
        dateLabel = {
            let label = UILabel()
            label.text = date
            label.textColor = .gray
            label.textAlignment = .center
            return label
        }()
        
        codeLabel = {
            let label = UILabel()
            label.text = code
            label.textColor = .gray
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(rawValue: 0))
            return label
        }()
        
        midLabel = {
            let label = UILabel()
            label.text = mid
            label.textAlignment = .center
            label.textColor = UIColor(red: 45/255, green: 196/255, blue: 0/255, alpha: 1.0)
            label.backgroundColor = UIColor(red: 241.0/255, green: 242.0/255, blue: 244.0/255, alpha: 1)
            label.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight(rawValue: 0))
            return label
        }()
        
        
        
        super.init(frame: .zero)
        
        addSubview(nameLabel)
        addSubview(codeLabel)
        addSubview(midLabel)
        addSubview(dateLabel)
        
        setupNameLabelConstraint()
        setupCodeLabelConstraint()
        setupMidLabelConstraint()
        setupDateLabelConstraint()
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
        nameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
    }
    
    fileprivate func setupCodeLabelConstraint(){
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        codeLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        codeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        codeLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
    }
    
    fileprivate func setupMidLabelConstraint(){
        midLabel.translatesAutoresizingMaskIntoConstraints = false
        midLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        midLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        midLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor).isActive = true
        midLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45).isActive = true
    }
    
    fileprivate func setupDateLabelConstraint(){
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: midLabel.bottomAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
    }
}
