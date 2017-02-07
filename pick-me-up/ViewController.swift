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
//import Material

class ViewController: UIViewController {
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    var data : Data = Data()
    var isLoaded : Bool = Bool()
    var gifArray : Array <URL> = []
    var gifRequestIndex:Int = 0
    var yPosition:CGFloat = 200
    
    @IBOutlet weak var gifBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // UI setup
        gifBtn.layer.cornerRadius = 10
        gifBtn.layer.borderWidth = 1
        gifBtn.layer.borderColor = UIColor.black.cgColor
        
        Giphy.configure(with: .publicKey)
        giphyMe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func gifBtnPressed(_ sender: UIButton) {
        let gifHeight:CGFloat = 150
        let gifWidth:CGFloat = 150
        let gifImageView: UIImageView = UIImageView()
        
        
        gifImageView.contentMode = UIViewContentMode.scaleAspectFit
        gifImageView.frame.size.width = gifWidth
        gifImageView.frame.size.height = gifHeight
        gifImageView.frame.origin.y = contentScrollView.frame.height - yPosition
        gifImageView.frame.origin.x = 30
        
        // Let's get a random GIF
        if gifRequestIndex < gifArray.count{
            print("GIFS!!!!!")
            self.data = try! Data(contentsOf: gifArray[gifRequestIndex])
            gifImageView.image = UIImage.gif(data: self.data)
            gifRequestIndex += 1
        }else{
            giphyMe()
            gifRequestIndex = 0
        }
        contentScrollView.addSubview(gifImageView)
        
        let spacer:CGFloat = 8
        
        yPosition+=gifHeight + spacer
        
    }
    
    internal func giphyMe(){
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

