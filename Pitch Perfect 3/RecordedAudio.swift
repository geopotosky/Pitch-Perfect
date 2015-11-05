//
//  RecordedAudio.swift
//  Pitch Perfect 3
//
//  Created by George Potosky on 3/27/15.
//  Copyright (c) 2015 GeoWorld. All rights reserved.
//

import Foundation

import AVFoundation
import Foundation

class RecordedAudio: NSObject{
    
    // variables used for storing the recorder audio file
    
    var filePathUrl: NSURL!
    var title: String!
    
    // Initialize the variables
    
    init(filePathUrl: NSURL!, title: String!){
    self.filePathUrl = filePathUrl
    self.title = title
    }
}
