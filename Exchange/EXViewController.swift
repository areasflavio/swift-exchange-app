//
//  EXViewController.swift
//  Exchange
//
//  Created by Flávio Arêas on 30/12/24.
//

import UIKit

class EXViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let contentStackView = UIView()
    let contentHeaderView = UIView()
    let contentTitle = UILabel()
    let contentText = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        view.backgroundColor = Colors.gray400
        view.addSubview(logoImageView)
        view.addSubview(contentStackView)
        
        configureLogo()
        configureContentView()
        configureHeaderView()
        configureContentTitle()
        configureContentText()
    }
    
    private func configureLogo() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(resource: .logo)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 32),
            logoImageView.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    private func configureContentView() {
        contentStackView.addSubview(contentHeaderView)
        
        contentStackView.backgroundColor = .systemRed //Colors.white
        contentStackView.layer.cornerRadius = 12
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
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
        contentText.numberOfLines = 0
        
        contentText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentText.topAnchor.constraint(equalTo: contentTitle.bottomAnchor, constant: 8),
            contentText.leadingAnchor.constraint(equalTo: contentHeaderView.leadingAnchor),
            contentText.trailingAnchor.constraint(equalTo: contentHeaderView.trailingAnchor),
        ])
    }
}
