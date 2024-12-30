//
//  EXCurrencyInput.swift
//  Exchange
//
//  Created by Flávio Arêas on 30/12/24.
//

import UIKit

class EXCurrencyInput: UIView {
    
    let valueInputText = UITextField()
    let inputDivider = UIView()
    let currencyInput = UIView()
    
    let padding: CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 2
        self.layer.borderColor = Colors.gray300.cgColor
        
        self.addSubview(valueInputText)
        self.addSubview(inputDivider)
        self.addSubview(currencyInput)
        
        configureCurrencyInput()
        configureInputDivider()
        configureValueInput()
    }
    
    private func configureCurrencyInput() {
        
        currencyInput.backgroundColor = .systemPink
        currencyInput.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currencyInput.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            currencyInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            currencyInput.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            currencyInput.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureInputDivider() {
        
        inputDivider.backgroundColor = Colors.gray300
        inputDivider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inputDivider.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            inputDivider.trailingAnchor.constraint(equalTo: currencyInput.leadingAnchor, constant: -padding),
            inputDivider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            inputDivider.widthAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func configureValueInput() {
        
        valueInputText.textColor = Colors.gray100
        valueInputText.tintColor = Colors.gray100
        valueInputText.textAlignment = .left
        valueInputText.font = Typography.textMD
        valueInputText.adjustsFontSizeToFitWidth = true
        valueInputText.placeholder = "1000,00"
        valueInputText.keyboardType = .decimalPad
        
        valueInputText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueInputText.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            valueInputText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            valueInputText.trailingAnchor.constraint(equalTo: currencyInput.leadingAnchor, constant: -padding),
            valueInputText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
        ])
    }
}
