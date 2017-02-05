//
//  ViewController.swift
//  pick-me-up
//
//  Created by Roger King on 2/5/17.
//  Copyright © 2017 arcingio. All rights reserved.
//

import UIKit
import GiphySwift
import SwiftGifOrigin

class ViewController: UIViewController {
    
    var data : Data = Data()
    var isLoaded : Bool = Bool()
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Giphy.configure(with: .publicKey)
        giphyMe()
        isLoaded = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func gifBtnPressed(_ sender: UIButton) {
        // Let's get a random GIF
        if(isLoaded){
            self.gifImageView.image = UIImage.gif(data: self.data)
            isLoaded = false
        } else{
            giphyMe()
            self.gifImageView.image = UIImage.gif(data: self.data)
        }
        
        
        
    }
    
    //TODO: Load 10 gifs into an array for faster loading.
    
    func giphyMe(){
        Giphy.Gif.request(.random(tag: "puppies")){ result in
            switch result {
                
            case .success(result: let gifs, properties: _):
                //print(gifs[0].images.original.gif.url)
                _ = UIImage(named: "gif")
                let url = URL(string: gifs[0].images.original.gif.url)!
                self.data = try! Data(contentsOf: url)
                
            case .error(let error):
                print("ERR: \n \(error)")
                
            }
            
        }
    }

}

