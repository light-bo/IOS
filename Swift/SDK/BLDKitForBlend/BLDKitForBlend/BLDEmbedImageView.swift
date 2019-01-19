//
//  BLDEmbedImageView.swift
//  BLDKitForBlend
//
//  Created by light_bo on 2019/1/13.
//  Copyright © 2019 light_bo. All rights reserved.
//

import UIKit

@objcMembers
public class BLDEmbedImageView: UIView {
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = UIColor.white
        
        bkImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.addSubview(bkImageView)
    }
    
    lazy var bkImageView: UIImageView = {
        let imageView = UIImageView()

        //访问 sdk framework 中资源核心代码
        let bundle = Bundle(for: BLDEmbedImageView.self)
        let url = bundle.url(forResource: "BLDResource", withExtension: "bundle")
        let imageBundle = Bundle(url: url!)
        let img = UIImage(contentsOfFile: imageBundle!.path(forResource: "error", ofType: "png")!)
        
        
        print(img ?? "img is nil")
        imageView.image = img
        
        return imageView
    } ()
}

