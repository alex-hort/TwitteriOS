//
//  Utilities.swift
//  Twitter
//
//  Created by Alexis Horteales Espinosa on 15/12/25.
//

import UIKit


class Utilities{
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView{
        let view = UIView()
        let iv = UIImageView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        iv.image = image.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .label
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .secondaryLabel
        view.addSubview(dividerView)
        // Cambiado: paddingBottom de 8 a 0 para pegar la línea al fondo del contenedor
        // Esto crea más separación visual entre el texto y la línea
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 0, height: 0.75)
        
        return view
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField{
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.textColor = .secondaryLabel
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
          tf.autocapitalizationType = .none
        return tf
    }
    
    func attriutedButton(_ firstPart: String, _ secondPart: String) -> UIButton{
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
}
