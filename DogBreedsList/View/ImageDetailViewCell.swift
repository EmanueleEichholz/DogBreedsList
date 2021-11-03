//
//  ImageViewCell.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import UIKit
import SnapKit

class ImageDetailViewCell: UITableViewCell {
    
    var imageBreed = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.imageBreed)
        self.backgroundColor = UIColor.mWhite()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage (url: URL) {
        
        //Aparência da imagem
        self.imageBreed.layer.cornerRadius = 10.0
        self.imageBreed.layer.masksToBounds = true
        self.imageBreed.contentMode = .scaleAspectFit
        self.imageBreed.kf.setImage(
                with: url,
                placeholder: UIImage(named: "dogplaceholder"),
                options: [ .cacheOriginalImage],
                progressBlock: nil,
                completionHandler: { result in
                    
                })
        //Arruma as constraints
        self.imageBreed.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalTo(250)
            make.height.equalTo(250)
        }
    }
}

