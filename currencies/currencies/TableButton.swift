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
        setupView()
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
        nameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
    }
    
    fileprivate func setupDefaultLabelConstraint(){
        defaultLabel.translatesAutoresizingMaskIntoConstraints = false
        defaultLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        defaultLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        defaultLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        defaultLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
    }
    fileprivate func setupView() {
        layer.masksToBounds = true
        layer.borderColor = AppColors.darkGrey.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 5
    }
    
    func setAsActive()
    {
        layer.borderColor = AppColors.lightGreen.cgColor
        isEnabled = false
    }
    func setAsInactive()
    {
        layer.borderColor = AppColors.darkGrey.cgColor
        isEnabled = true
    }
    func getEndpoint() -> Endpoints{
        switch nameLabel.text {
        case "A":
            return Endpoints.TableA
        case "B":
            return Endpoints.TableB
        case "C":
            return Endpoints.TableC
        default:
            return Endpoints.TableA
        }
    }
}
