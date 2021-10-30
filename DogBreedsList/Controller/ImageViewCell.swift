//
//  ImageViewCell.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import UIKit
import SnapKit

class ImageViewCell: UITableViewCell {
    
    var uiiv_Image = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.uiiv_Image)
        self.backgroundColor = UIColor.mWhite()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage (url: URL) {

        self.uiiv_Image.layer.cornerRadius = 10.0
        self.uiiv_Image.layer.masksToBounds = true
        self.uiiv_Image.contentMode = .scaleAspectFit
        self.uiiv_Image.kf.setImage(
                with: url,
                placeholder: UIImage(named: "dogplaceholder"),
                options: [ .cacheOriginalImage],
                progressBlock: nil,
                completionHandler: { result in
                    
                })
        
        self.uiiv_Image.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalTo(250)
            make.height.equalTo(250)
        }
        
        
    }
    
    
    
}

