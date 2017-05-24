//
//  SKTableViewCell.swift
//  AutoLayoutDemo
//
//  Created by 董知樾 on 2017/3/28.
//  Copyright © 2017年 董知樾. All rights reserved.
//

import UIKit

class SKTableViewCell: UITableViewCell {

    var model : SKTableViewCellModel! {
        didSet {
            titleLabel.text = model.title
            authorLabel.text = model.author
            contentLabel.numberOfLines = model.isExpand ? 0 : 3
            contentLabel.text = model.content
            
            self.layoutIfNeeded()
        }
    }
    
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    var authorLabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        titleLabel.backgroundColor = UIColor.hexValue(0xf8f8f8)
        titleLabel.textColor = UIColor.hexValue(0x333333)
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.centerX.equalTo(contentView)
        }
        
        authorLabel.backgroundColor = UIColor.hexValue(0xf8f8f8)
        authorLabel.textColor = UIColor.hexValue(0x666666)
        contentView.addSubview(authorLabel)
        authorLabel.font = UIFont.systemFont(ofSize: 10)
        authorLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel.snp.trailing).offset(12)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
        }
        
        contentLabel.backgroundColor = UIColor.hexValue(0xf8f8f8)
        contentLabel.textColor = UIColor.hexValue(0x666666)
        contentView.addSubview(contentLabel)
        contentLabel.font = UIFont.systemFont(ofSize: 12)
        contentLabel.lineBreakMode = .byTruncatingTail
        contentLabel.numberOfLines = 3
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(authorLabel.snp.bottom).offset(2)
            make.leading.equalTo(12)
            make.bottom.trailing.equalTo(-12)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
