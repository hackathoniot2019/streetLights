//
//  SearchCell.swift
//  StreetLightUI
//
//  Created by Maxim Reshetov on 30/03/2019.
//  Copyright © 2019 Maxim Reshetov. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    let nameOfStreet: UILabel = {
        let label = UILabel()
        label.text = "Mail.ru group one love"
        return label
    }()
    
    let numberOfLights: UILabel = {
        let label = UILabel()
        label.text = "273"
        label.textAlignment = .right
        return label
    }()
    
    func configureCell() {
        addSubview(nameOfStreet)
        addSubview(numberOfLights)
        nameOfStreet.anchor(top: topAnchor, left: leadingAnchor, bottom: bottomAnchor, right: centerXAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        numberOfLights.anchor(top: topAnchor, left: centerXAnchor, bottom: bottomAnchor, right: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: -30, width: 0, height: 0, enableInsets: false)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
