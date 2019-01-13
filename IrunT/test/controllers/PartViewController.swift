//
//  PartViewController.swift
//  test
//
//  Created by Alex Iakab on 07/12/2018.
//  Copyright © 2018 Alex Iakab. All rights reserved.
//

import UIKit

class PartViewController: UIViewController,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var titleStrings = ["CPU","GPU","Memory","PSU","Motherboard","Case","Storage","CPU Cooler"]
    var imageStrings = ["nav-cpu","nav-videocard","nav-memory","nav-powersupply","nav-motherboard","nav-case","nav-ssd","nav-cpucooler"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var viewController: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
         viewController.backgroundColor = UIColor(patternImage: UIImage(named: "BackgroundD")!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleStrings.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "partcell", for: indexPath) as! partCell
        cell.bgView.setShadow()
        cell.bgView.setCorner(8)
        cell.descLabel.text = titleStrings[indexPath.row]
        cell.imageView.image = UIImage(named: imageStrings[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.viewController.frame.width / 2 - 6, height: self.viewController.frame.width / 2 - 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch titleStrings[indexPath.row] {
        case "GPU":
            performSegue(withIdentifier: "gotoGPU", sender: self)
        case "CPU":
            performSegue(withIdentifier: "gotoCPU", sender: self)
        case "PSU":
            performSegue(withIdentifier: "gotoPSU", sender: self)
        case "Memory":
            performSegue(withIdentifier: "gotoMem", sender: self)
        case "Case":
            performSegue(withIdentifier: "gotoCase", sender: self)
        case "Motherboard":
            performSegue(withIdentifier: "gotoMobo", sender: self)
        case "CPU Cooler":
            performSegue(withIdentifier: "gotoCooler", sender: self)
        default: break
            //
        }
    }
}
