//
//  RoundedButton.swift
//  MappyMapAdyenTask
//
//  Created by Mohamed Elatabany on 02/08/2022.
//

import UIKit
class CircleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    convenience init(backgroundColor: UIColor, systemImageName: String? = nil, imageFontSize: CGFloat = 24 ) {
        self.init(frame: .zero)
        set(systemImageName: systemImageName, backgroundColor: backgroundColor, imageFontSize: imageFontSize)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        layer.borderWidth = 1.0
        layer.borderColor = tintColor.cgColor
        layer.cornerRadius = 20
        layer.masksToBounds = true
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        setTitleColor(tintColor, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 1.0
        layer.borderColor = tintColor.cgColor
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    func set(systemImageName: String? = nil, backgroundColor: UIColor, imageFontSize: CGFloat) {
        self.backgroundColor = backgroundColor
        if let systemImageName = systemImageName {
            let boldConfig = UIImage.SymbolConfiguration(pointSize: imageFontSize, weight: .semibold, scale: .large)
            let boldImage = UIImage(systemName: systemImageName, withConfiguration: boldConfig)
            setImage(boldImage, for: .normal)
        }
    }
}
