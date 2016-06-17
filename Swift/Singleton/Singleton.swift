//
//  Singleton.swift
//  TestiOSSwift
//
//  Created by light_bo on 16/6/17.
//  Copyright © 2016年 李旭波. All rights reserved.
//

import UIKit

class Singleton: NSObject {
    static let shareInstance = Singleton()
    private override init() { }
}
