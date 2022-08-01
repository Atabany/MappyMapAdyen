//
//  ViewController.swift
//  MappyMapAdyenTask
//
//  Created by Mohamed Elatabany on 02/08/2022.
//

import UIKit

class HomeViewController: UIViewController {
  
  let stackView = UIStackView()
  let label = UILabel()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
  
}


extension HomeViewController {
  
  private func style() {
    view.backgroundColor = .systemBackground
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Welcome"
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    
    
  }
  
  private func layout() {
    stackView.addArrangedSubview(label)
    
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    ])
  }
}



