//
//  InterfaceController.swift
//  Shows WatchKit Extension
//
//  Created by karthi on 2/11/17.
//  Copyright © 2017 tringapps. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications


class InterfaceController: WKInterfaceController {

    @IBOutlet var showImage: WKInterfaceImage!
    @IBOutlet var showName: WKInterfaceLabel!
    var arrayIndex = 0
    @IBAction func nextButton() {
        arrayIndex = arrayIndex + 1
        if(arrayIndex < 4){
        var currentShow:[String] = ["Rush Hour","Spectre" ,"Die Hard ", "Rambo"]
            var imageName:[String] = ["RushHour.jpeg","spectre.jpeg","Die Hard.jpeg","rambo.jpeg"]
            self.setImageForShowName(currentShowName: currentShow[arrayIndex], imageName: imageName[arrayIndex])
        }
        if( arrayIndex == 3){
        arrayIndex = -1
    }
        
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    func setImageForShowName(currentShowName: String, imageName: String)
    {
        self.showName.setText(currentShowName)
        self.showImage.setImageNamed(imageName)
    }
    }
