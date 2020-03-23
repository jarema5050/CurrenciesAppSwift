//
//  File.swift
//  currencies
//
//  Created by Jedrzej Sokolowski on 22/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    required init(placeholder: String) {
        super.init(frame: .zero)
        
        self.layer.masksToBounds = true
        self.layer.borderColor = AppColors.darkGrey.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 5
        self.placeholder = placeholder
        
        self.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let padding = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15);

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
