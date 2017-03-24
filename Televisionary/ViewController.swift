//
//  ViewController.swift
//  Televisionary
//
//  Created by Dilinie Seimon on 24/03/17.
//  Copyright © 2017 Dilinie Seimon. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    final let urlString = "http://tvshowapi.azurewebsites.net/tvshownewsfeed"
    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [String]()
    var favouriteCountArray = [String]()
    var imgURLArray = [String]()
    var contentArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadJsonWithURL()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadJsonWithURL() {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String:Any]] {
                
                for tvshow in jsonObj! {
                    if let name = tvshow["screenName"] as? String {
                        self.nameArray.append(name)
                    }
                    if let cnt = tvshow["favouriteCount"] as? Int {
                        self.favouriteCountArray.append("\(cnt)")
                    }
                    if let image = tvshow["imageUrl"] as? String {
                        self.imgURLArray.append(image)
                    }
                    if let content = tvshow["content"] as? String {
                        self.contentArray.append(content)
                    }
                }
                
                
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
        }).resume()
    }
    
    /*func downloadJsonWithURL() {
     let url = NSURL(string: urlString)
     URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
     
     if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
     print(jsonObj!.value(forKey: "")!)
     
     if let tvshowArray = jsonObj!.value(forKey: "") as? NSArray {
     for tvshow in tvshowArray{
     if let tvshowDict = tvshow as? NSDictionary {
     if let name = tvshowDict.value(forKey: "screenName") {
     self.nameArray.append(name as! String)
     }
     if let name = tvshowDict.value(forKey: "favouriteCount") {
     self.favouriteCountArray.append(name as! String)
     }
     if let name = tvshowDict.value(forKey: "image") {
     self.imgURLArray.append(name as! String)
     }
     
     }
     }
     }
     
     OperationQueue.main.addOperation({
     self.tableView.reloadData()
     })
     }
     }).resume()
     }*/
    
    
    
    
    
    func downloadJsonWithTask() {
        
        let url = NSURL(string: urlString)
        
        var downloadTask = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            
            print(jsonData!)
            
        }).resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        cell.nameLabel.textAlignment = .left
        cell.nameLabel.text = nameArray[indexPath.row]
        cell.dobLabel.text = favouriteCountArray[indexPath.row]
        
        let imgURL = NSURL(string: imgURLArray[indexPath.row])
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.imgView.image = UIImage(data: data as! Data)
        }
        
        return cell
    }
    
    ///for showing next detailed screen with the downloaded info
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.imageString = imgURLArray[indexPath.row]
        vc.nameString = nameArray[indexPath.row]
        vc.dobString = favouriteCountArray[indexPath.row]
        vc.contentString = contentArray[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

