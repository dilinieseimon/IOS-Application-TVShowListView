//
//  DetailViewController.swift
//  Televisionary
//
//  Created by Dilinie Seimon on 24/03/17.
//  Copyright © 2017 Dilinie Seimon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //current controller IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    //data from previous controller
    var nameString:String!
    var dobString:String!
    var imageString:String!
    var contentString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        
        
        contentLabel.numberOfLines = 0;
        contentLabel.textAlignment = .justified
        //contentLabel.textAlignment = NSTextAlignmentCenter;
        
        self.nameLabel.text = nameString
        self.dobLabel.text = dobString
        self.contentLabel.text = contentString
        
        let imgURL = URL(string:imageString)
        
        let data = NSData(contentsOf: (imgURL)!)
        self.imageView.image = UIImage(data: data as! Data)
    }
}
