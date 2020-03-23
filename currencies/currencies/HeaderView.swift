//
//  HeaderView.swift
//  currencies
//
//  Created by Jedrzej Sokolowski on 19/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import Foundation
import UIKit

class HeaderView: UICollectionReusableView {
    private var buttonA : TableButton
    private var buttonB : TableButton
    private var buttonC : TableButton
    public var stackView : UIStackView
    public var delegate : Selectable!
    
    override init(frame: CGRect) {
        buttonA = TableButton(name: "A")
        buttonB = TableButton(name: "B")
        buttonC = TableButton(name: "C")
        self.stackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .equalSpacing
            return stackView
        }()
        super.init(frame: frame)
        addSubview(stackView)
        stackView.addArrangedSubview(buttonA)
        stackView.addArrangedSubview(buttonB)
        stackView.addArrangedSubview(buttonC)
        setupStackViewConstraints()
        setupTableButtonConstraints(button: buttonA)
        setupTableButtonConstraints(button: buttonB)
        setupTableButtonConstraints(button: buttonC)
        backgroundColor = .white
        
        buttonA.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        buttonB.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        buttonC.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        buttonA.setAsActive()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupTableButtonConstraints(button: TableButton){
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15).isActive = true
        button.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    fileprivate func setupStackViewConstraints(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    @objc func buttonTapped(sender: TableButton){
        buttonA.setAsInactive()
        buttonB.setAsInactive()
        buttonC.setAsInactive()
        sender.setAsActive()
        delegate.changeDataSource(endpoint: sender.getEndpoint())
    }
}
