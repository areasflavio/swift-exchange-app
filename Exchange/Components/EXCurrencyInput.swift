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
    
    let currencyPickerView = UIPickerView()
    let currencyInputField = UITextField()
    
    var value: String? { valueInputText.text?.replacingOccurrences(of: ",", with: ".") }
    var currency: String? { currencyInputField.text }
    
    let padding: CGFloat = 16
    var options: [String] = []
    var readonly: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    public init(readonly: Bool) {
        super.init(frame: .zero)
        
        self.readonly = readonly
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(value: Double) {
        valueInputText.text = String(format: "%.2f", value).replacingOccurrences(of: ".", with: ",")
    }
    
    public func set(options: [String]) {
        self.options = options
        
        if let firstOption = options.first {
            currencyInputField.text = firstOption
        }
    }
    
    private func configure() {
        
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 2
        self.layer.borderColor = Colors.gray300.cgColor
        
        self.addSubview(valueInputText)
        self.addSubview(inputDivider)
        self.addSubview(currencyInputField)
        
        configureCurrencyInput()
        configureInputDivider()
        configureValueInput()
    }
    
    private func configureCurrencyInput() {
        
        let chevron = UIImageView(image: UIImage(systemName: "chevron.down"))
        chevron.contentMode = .scaleAspectFit
        chevron.tintColor = Colors.gray100
        
        currencyInputField.font = Typography.textMD
        currencyInputField.textColor = Colors.gray100
        currencyInputField.borderStyle = .none
        currencyInputField.rightView = chevron
        currencyInputField.rightViewMode = .always
        currencyInputField.translatesAutoresizingMaskIntoConstraints = false
        
        currencyPickerView.delegate = self
        currencyPickerView.dataSource = self
        currencyInputField.inputView = currencyPickerView
                
        NSLayoutConstraint.activate([
            currencyInputField.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            currencyInputField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            currencyInputField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            currencyInputField.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureInputDivider() {
        
        inputDivider.backgroundColor = Colors.gray300
        inputDivider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inputDivider.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            inputDivider.trailingAnchor.constraint(equalTo: currencyInputField.leadingAnchor, constant: -padding),
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
        valueInputText.isUserInteractionEnabled = !readonly
        
        valueInputText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueInputText.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            valueInputText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            valueInputText.trailingAnchor.constraint(equalTo: currencyInputField.leadingAnchor, constant: -padding),
            valueInputText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
        ])
    }
}

extension EXCurrencyInput: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyInputField.text = options[row]
        currencyInputField.resignFirstResponder()
    }
}
