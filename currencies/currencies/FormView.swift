//
//  FormView.swift
//  currencies
//
//  Created by Jedrzej Sokolowski on 22/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import UIKit

class FormView: UIView {
    
    private var startDateTxtField = CustomTextField(placeholder: "Data początkowa")
    private var endDateTxtField = CustomTextField(placeholder: "Data końcowa")
    private var endDate : Date?
    private var startDate : Date?
    private let infoLabel = UILabel()
    private let confirmButton = UIButton()
    private let stackView = UIStackView()
    private let infoStackView = UIStackView()
    public var delegate : DateChangeable!
    
    required init() {
        super.init(frame: .zero)
       
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()
    {
        endDateTxtField.inputView = createDatePicker(target: { datePicker in
            datePicker.addTarget(self, action: #selector(endDateChanged(datePicker: )), for: .valueChanged)
            }
        )
        startDateTxtField.inputView = createDatePicker(target: { datePicker in
        datePicker.addTarget(self, action: #selector(startDateChanged(datePicker: )), for: .valueChanged)
        })
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        
        addGestureRecognizer(tapGestureRecognizer)
        
        setupInfoLabel()
        addSubview(infoStackView)
        setupStackViewAndContents()
        setupInfoStackViewAndContents()
        setupConfirmButton()
    }
    
    func setupConfirmButton(){
        addSubview(confirmButton)
        confirmButton.setTitle("Pobierz dane", for: .normal)
        confirmButton.setTitleColor(.gray, for: .normal)
        confirmButton.layer.masksToBounds = true
        confirmButton.layer.borderColor = AppColors.lightGreen.cgColor
        confirmButton.layer.borderWidth = 2.0
        confirmButton.layer.cornerRadius = 5
        confirmButton.backgroundColor = AppColors.lightGrey
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 0))
        confirmButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        confirmButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50).isActive = true
        //confirmButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        //confirmButton.isEnabled = false
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    func setupStackViewAndContents(){
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(startDateTxtField)
        stackView.addArrangedSubview(endDateTxtField)
    
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.8).isActive = true
        stackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        startDateTxtField.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4).isActive = true
        endDateTxtField.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4).isActive = true

    }
    
    func setupInfoStackViewAndContents(){
        
        infoStackView.axis = .horizontal
        infoStackView.alignment = .center
        infoStackView.distribution = .equalSpacing
        let startLabel = UILabel()
        let endLabel = UILabel()
        
        startLabel.text = "Od"
        endLabel.text = "Do"
        
        startLabel.textColor = .gray
        endLabel.textColor = .gray
        infoStackView.addArrangedSubview(startLabel)
        infoStackView.addArrangedSubview(endLabel)
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        infoStackView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 40).isActive = true
        infoStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        startLabel.widthAnchor.constraint(equalTo: infoStackView.widthAnchor, multiplier: 0.4).isActive = true
        endLabel.widthAnchor.constraint(equalTo: infoStackView.widthAnchor, multiplier: 0.4).isActive = true

    }
    
    func setupInfoLabel(){
        
        addSubview(infoLabel)
        infoLabel.text = "Wybierz daty wyszukiwania."
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.8).isActive = true
        infoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        endEditing(true)
    }
    
    func createDatePicker(target: (UIDatePicker) -> Void) -> UIDatePicker
    {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -367, to: Date())
        datePicker.maximumDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        datePicker.date = Date()
        startDate = datePicker.date
        endDate = datePicker.date
        startDateTxtField.text = dateFormatter.string(from:datePicker.date)
        endDateTxtField.text = dateFormatter.string(from:datePicker.date)
        endDateTxtField.adjustsFontSizeToFitWidth = true
        startDateTxtField.adjustsFontSizeToFitWidth = true
        
        target(datePicker)
        return datePicker
    }
    
    @objc func startDateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        startDate = datePicker.date
        startDateTxtField.text = dateFormatter.string(from:datePicker.date)
        //activateConfirmButton()
    }
    
    @objc func endDateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        endDate = datePicker.date
        endDateTxtField.text = dateFormatter.string(from:datePicker.date)
        //activateConfirmButton()
    }
    
    func activateConfirmButton(){
        confirmButton.setTitle("Pobierz dane", for: .normal)
        if endDate != nil && startDate != nil {
            confirmButton.isEnabled = true
        }
        else {
            confirmButton.isEnabled = false
        }
    }
    @objc func confirmButtonTapped(){
        endEditing(true)
        print("hello")
        if endDate != nil && startDate != nil {
            if endDate! >= startDate! {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                delegate.passDates(startDate:dateFormatter.string(from: startDate!), endDate:dateFormatter.string(from: endDate!))
                confirmButton.setTitle("Odśwież", for: .normal)
            }
            else {
                infoLabel.text = "Data końcowa nie może być wcześniejsza niż data początkowa!"
            }
        }
    }
}
