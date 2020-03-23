//
//  TableViewCell.swift
//  currencies
//
//  Created by Jedrzej Sokolowski on 23/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    private var dateLabel : UILabel
    private var rateLabel : UILabel
    private var additionalRateLabel : UILabel?
    private var stackView : UIStackView
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        dateLabel = UILabel()
        rateLabel = UILabel()
        additionalRateLabel = UILabel()
        
        self.stackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .equalSpacing
            return stackView
        }()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(stackView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(rateLabel)
        
        setupStackViewConstraints()
        
    }
    func setProperties(date: String, rate: String, additionalRate: String?){
        dateLabel.text = date
        rateLabel.text = rate
        if let additionalRate = additionalRate {
            additionalRateLabel?.text = additionalRate
            if !stackView.arrangedSubviews.contains(additionalRateLabel!){
                stackView.addArrangedSubview(additionalRateLabel!)
            }
        }
    }
    
    func setupStackViewConstraints(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        stackView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
