//
//  DetailsCell.swift
//  StreetLightUI
//
//  Created by Maxim Reshetov on 30/03/2019.
//  Copyright © 2019 Maxim Reshetov. All rights reserved.
//

import UIKit

class PowerCell: UITableViewCell {
    
    let powerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "power"))
        return imageView
    }()
    
    let powerLabel: UILabel = {
        let label = UILabel()
        label.text = "270W"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    func configureCell() {
        addSubview(powerImageView)
        powerImageView.anchor(top: nil, left: leadingAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 40, height: 40, enableInsets: false)
        powerImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(powerLabel)
        powerLabel.anchor(top: topAnchor, left: powerImageView.trailingAnchor, bottom: bottomAnchor, right: trailingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: -30, width: 0, height: 0, enableInsets: false)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
