//
//  EXViewController.swift
//  Exchange
//
//  Created by Flávio Arêas on 30/12/24.
//

import UIKit

class EXViewController: UIViewController {
    
    let logoImageView = UIImageView()
    var containerView: UIView!
    let contentStackView = UIView()
    let contentHeaderView = UIView()
    let contentTitle = UILabel()
    let contentText = UILabel()
    let currencyInput = EXCurrencyInput()
    let currencyOutput = EXCurrencyInput(readonly: true)
    let convertButton = UIButton()
    
    var exchanges: CurrencyExchange?
    var currenctCurrency: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        getCurrencies()
        configure()
    }
    
    private func getCurrencies() {
        Task {
            do {
                let currencies = try await NetworkManager.shared.getCurrencies()
                let options = mapCurrenciesToPicker(currencies)
                currencyInput.set(options: options)
                currencyOutput.set(options: options)
            } catch {
                print(error)
            }
        }
    }
    
    private func exchangeCurrency(currency: String) {
        
        Task {
            do {
                let exchanges = try await NetworkManager.shared.exchangeCurrency(currency)
                self.exchanges = exchanges
                
                DispatchQueue.main.async {
                    self.updateUIWithExchanges()
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func configure() {
        view.backgroundColor = Colors.gray400
        view.addSubview(logoImageView)
        view.addSubview(contentStackView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        configureLogo()
        configureContentView()
        configureHeaderView()
        configureContentTitle()
        configureContentText()
        configureCurrencyInput()
        configureCurrencyOutput()
        configureConvertButton()
    }
    
    private func configureLogo() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(resource: .logo)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            logoImageView.widthAnchor.constraint(equalToConstant: 210)
        ])
    }
    
    private func configureContentView() {
        contentStackView.addSubview(contentHeaderView)
        contentStackView.addSubview(currencyInput)
        contentStackView.addSubview(convertButton)
        contentStackView.addSubview(currencyOutput)
        
        contentStackView.backgroundColor = Colors.white
        contentStackView.layer.cornerRadius = 12
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200)
        ])
    }
    
    private func configureHeaderView() {
        contentHeaderView.addSubview(contentTitle)
        contentHeaderView.addSubview(contentText)
        
        contentHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentHeaderView.topAnchor.constraint(equalTo: contentStackView.topAnchor, constant: 24),
            contentHeaderView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 24),
            contentHeaderView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -24),
        ])
    }
    
    private func configureContentTitle() {
        contentTitle.text = "Conversor de moedas"
        contentTitle.font = Typography.title
        contentTitle.textColor = Colors.gray100
        
        contentTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentTitle.topAnchor.constraint(equalTo: contentHeaderView.topAnchor),
            contentTitle.leadingAnchor.constraint(equalTo: contentHeaderView.leadingAnchor),
            contentTitle.trailingAnchor.constraint(equalTo: contentHeaderView.trailingAnchor),
        ])
    }
    
    private func configureContentText() {
        contentText.text = "Digite o valor escolha as moedas de conversão"
        contentText.font = Typography.textSM
        contentText.textColor = Colors.gray200
        contentText.numberOfLines = 0
        
        contentText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentText.topAnchor.constraint(equalTo: contentTitle.bottomAnchor, constant: 8),
            contentText.leadingAnchor.constraint(equalTo: contentHeaderView.leadingAnchor),
            contentText.trailingAnchor.constraint(equalTo: contentHeaderView.trailingAnchor),
        ])
    }
    
    private func configureCurrencyInput() {
        
        currencyInput.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currencyInput.topAnchor.constraint(equalTo: contentText.bottomAnchor, constant: 40),
            currencyInput.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 24),
            currencyInput.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -24),
            currencyInput.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func configureCurrencyOutput() {
        
        currencyOutput.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currencyOutput.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: -24),
            currencyOutput.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 24),
            currencyOutput.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -24),
            currencyOutput.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func configureConvertButton() {
        
        convertButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        convertButton.setImage(UIImage(systemName: "arrow.left.arrow.right"), for: .normal)
        convertButton.tintColor = Colors.purpleBase
        convertButton.layer.borderWidth = 1
        convertButton.layer.borderColor = Colors.purpleBase.cgColor
        convertButton.layer.cornerRadius = 8
        convertButton.backgroundColor = Colors.purpleLight
        convertButton.contentHorizontalAlignment = .center
        convertButton.contentVerticalAlignment = .center
        
        convertButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            convertButton.topAnchor.constraint(equalTo: currencyInput.bottomAnchor, constant: 16),
            convertButton.centerXAnchor.constraint(equalTo: contentStackView.centerXAnchor),
            convertButton.heightAnchor.constraint(equalToConstant: 40),
            convertButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func didTapButton() {
        
        if exchanges == nil || currenctCurrency != currencyInput.currency {
            if let currency = currencyInput.currency {
                currenctCurrency = currencyInput.currency
                exchangeCurrency(currency: currency)
            }
        } else {
            updateUIWithExchanges()
        }
        
        dismissKeyboard()
    }
    
    private func updateUIWithExchanges() {
                        
        if let valueFrom = currencyInput.value,
           let valueFromNumber = Double(valueFrom),
           let currencyTo = currencyOutput.currency,
           let exchanges = self.exchanges,
           let exchange = exchanges.data[currencyTo] {
                        
            currencyInput.set(value: valueFromNumber)
            currencyOutput.set(value: valueFromNumber * exchange)
        }
    }
}
