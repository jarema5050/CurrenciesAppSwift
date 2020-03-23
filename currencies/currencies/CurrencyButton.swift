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
    private var dateStackView : UIStackView!
    private var codeLabel : UILabel
    private var midLabel : UILabel?
    private var midStackView : UIStackView?
    private var bidLabel : UILabel?
    private var bidStackView : UIStackView?
    private var askLabel : UILabel?
    private var askStackView : UIStackView?
    
    required init(mid: String?, bid: String?, ask: String?, date: String, code: String, name: String) {
        
        // set myValue before super.init is called
        nameLabel = {
            let label = UILabel()
            label.text = name
            label.textColor = .gray
            label.textAlignment = .center
            label.backgroundColor = AppColors.darkGrey
            return label
        }()
        
        dateLabel = {
            let label = UILabel()
            label.text = date
            label.textColor = .red
            label.textAlignment = .center
            return label
        }()
        
        codeLabel = {
            let label = UILabel()
            label.text = code
            label.textColor = .gray
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(rawValue: 0))
            label.backgroundColor = AppColors.darkGrey
            return label
        }()
        
        if let mid = mid {
            print("yes1")
            midLabel = {
                let label = UILabel()
                label.text = mid
                label.textAlignment = .center
                label.textColor = AppColors.lightGreen
                label.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight(rawValue: 0))
                return label
            }()
        }
        if let bid = bid {
            bidLabel = {
                let label = UILabel()
                label.text = bid
                label.textAlignment = .center
                label.textColor = AppColors.lightGreen
                label.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(rawValue: 0))
                return label
            }()
        }
        
        if let ask = ask {
            askLabel = {
                let label = UILabel()
                label.text = ask
                label.textAlignment = .center
                label.textColor = AppColors.lightGreen
                label.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(rawValue: 0))
                return label
            }()
        }
        
        
        super.init(frame: .zero)
        addSubview(nameLabel)
        addSubview(codeLabel)
        setupNameLabelConstraint()
        setupCodeLabelConstraint()
        
        if let midLabel = midLabel {
            print("yes")
            midStackView = createStackView(content: midLabel, description: "ŚREDNI")
            addSubview(midStackView!)
            setupMidStackViewConstraint()
        }
        if let bidLabel = bidLabel {
            print("yes")
            bidStackView = createStackView(content: bidLabel, description: "KUPNO")
            addSubview(bidStackView!)
            setupBidStackViewConstraint()
        }
        
        if let askLabel = askLabel {
            askStackView = createStackView(content: askLabel, description: "SPRZEDAŻ")
            addSubview(askStackView!)
            setupAskStackViewConstraint()
        }
        
        dateStackView = createStackView(content: dateLabel, description: "DATA PUBLIKACJI")
        addSubview(dateStackView)
        setupDateStackViewConstraint()
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
    
    fileprivate func setupMidStackViewConstraint(){
        if let midStackView = midStackView {
            midStackView.translatesAutoresizingMaskIntoConstraints = false
            midStackView.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.8).isActive = true
            midStackView.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
            midStackView.topAnchor.constraint(equalTo: codeLabel.bottomAnchor).isActive = true
            midStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45).isActive = true
        }
    }
    
    fileprivate func setupBidStackViewConstraint(){
        if let bidStackView = bidStackView {
            bidStackView.translatesAutoresizingMaskIntoConstraints = false
            bidStackView.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.8).isActive = true
            bidStackView.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
            bidStackView.topAnchor.constraint(equalTo: codeLabel.bottomAnchor).isActive = true
            bidStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.225).isActive = true
        }
    }
    
    fileprivate func setupAskStackViewConstraint(){
        if let askStackView = askStackView {
            askStackView.translatesAutoresizingMaskIntoConstraints = false
            askStackView.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.8).isActive = true
            askStackView.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
            askStackView.topAnchor.constraint(equalTo: bidStackView!.bottomAnchor).isActive = true
            askStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.225).isActive = true
        }
    }
    
    fileprivate func setupDateStackViewConstraint(){
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.8).isActive = true
        dateStackView.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        if let midStackView = midStackView {
            dateStackView.topAnchor.constraint(equalTo: midStackView.bottomAnchor).isActive = true
        }
        else {
            dateStackView.topAnchor.constraint(equalTo: askStackView!.bottomAnchor).isActive = true
        }
        dateStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
    }
    
    fileprivate func createStackView(content: UILabel, description: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.textColor = .gray
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 0))
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(content)
        return stackView
    }
}
