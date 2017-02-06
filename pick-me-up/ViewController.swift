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
    var gifArray : Array <URL> = []
    var gifRequestIndex:Int = 0
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Giphy.configure(with: .publicKey)
        giphyMe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func gifBtnPressed(_ sender: UIButton) {
        // Let's get a random GIF
        if gifRequestIndex < gifArray.count{
            self.data = try! Data(contentsOf: gifArray[gifRequestIndex])
            self.gifImageView.image = UIImage.gif(data: self.data)
            gifRequestIndex += 1
        }else{
            giphyMe()
            gifRequestIndex = 0
        }
    }
    
    func giphyMe(){
        Giphy.Gif.request(.search("puppies")){ result in
            switch result {
                
            case .success(result: let gifs, properties: _):
                print(gifs.count)
                var i:Int = 0
                while i < gifs.count {
                    let randomNum:UInt32 = arc4random_uniform(23)
                    let gifIndex:Int = Int(randomNum)
                    let url = URL(string: gifs[gifIndex].images.original.gif.url)!
                    self.gifArray.append(url)
                    i += 1
                    //self.data = try! Data(contentsOf: url)
                }
                
            case .error(let error):
                print("ERR: \n \(error)")
                
            }
            
        }
    }

}

