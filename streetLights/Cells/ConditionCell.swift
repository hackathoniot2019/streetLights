//
//  ConditionCell.swift
//  StreetLightUI
//
//  Created by Maxim Reshetov on 30/03/2019.
//  Copyright © 2019 Maxim Reshetov. All rights reserved.
//

import UIKit

class ConditionCell: UITableViewCell {
    
    let conditionLabel: UILabel = {
        let label = UILabel()
        label.text = "Condition: In a good condition"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    func configureCell() {
        addSubview(conditionLabel)
        conditionLabel.anchor(top: topAnchor, left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
