//
//  BreedTableViewCell.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import UIKit
import SnapKit

class BreedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var imageBreed: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelTitle.snp.makeConstraints { make in
            
            make.top.equalTo(self).offset(30)
            make.left.equalTo(self).offset(30)
            make.right.equalTo(imageBreed.snp.left).offset(-30)
            make.bottom.equalTo(labelDescription.snp.top).offset(-10)
            
        }
        
        labelDescription.snp.makeConstraints { make in
            
            make.top.equalTo(labelTitle.snp.bottom).offset(10)
            make.left.equalTo(labelTitle.snp.left).offset(0)
            make.right.equalTo(imageBreed.snp.left).offset(-30)
            make.bottom.greaterThanOrEqualTo(labelTitle.snp.bottom).offset(-10)
        }
        
        imageBreed.snp.makeConstraints { make in
            
            make.centerY.equalTo(self).offset(0)
            make.right.equalTo(self).offset(-50)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        

        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
