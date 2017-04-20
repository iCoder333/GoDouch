//
//  IntroVC.swift
//  Go Dutch
//
//  Created by Mario Romano on 9/2/16.
//  Copyright © 2016 Sergey Bill. All rights reserved.
//

import UIKit

class IntroVC: BasicVC {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var btn_continue: UIButton!
    
    @IBOutlet weak var bottom_continueBtn: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 1...Number_IntroScreen
        {
            let imageView = UIImageView(image: UIImage(named: "intro" + String(i)))
            imageView.frame = CGRect(x: CGFloat((i - 1)) * self.view.width  , y: 0, width: self.view.width  , height: self.view.height)
            
            scrollView.addSubview(imageView)
        }
        
        scrollView.contentSize = CGSize(width: self.view.width * CGFloat(Number_IntroScreen) , height: self.view.height)
        
    }
    
    
// MARK: - UIScrollView & UIPageControl DataSource

    func scrollViewDidScroll(_ scrollView: UIScrollView) // any offset changes
    {
        let index = scrollView.contentOffset.x / self.view.width
        
        self.pageControl.currentPage = Int(index)
        
        self.pagingScrollViewDidChangePages(scrollView)
    }

//    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
//        if scrollView.panGestureRecognizer.translationInView(scrollView.superview).x < 0 {
//            if !self.hasNext(self.pageControl) {
//
//                self.onContinue(self.btn_continue)
//            }
//        }
//    }
//    
//    func hasNext(pageControl: UIPageControl) -> Bool {
//        return pageControl.numberOfPages > pageControl.currentPage + 1
//    }
    
    func isLast(_ pageControl: UIPageControl) -> Bool {
        return pageControl.numberOfPages == pageControl.currentPage + 1
    }
    
    func pagingScrollViewDidChangePages(_ pagingScrollView: UIScrollView)
    {
        if self.isLast(self.pageControl) {
            if self.pageControl.alpha == 1 && self.bottom_continueBtn.constant != 19 {
                
                self.pageControl.alpha = 0
                self.bottom_continueBtn.constant = 19.0

                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut , animations: {
                    self.view.layoutIfNeeded()

                    self.btn_continue.alpha = 1
                    }, completion: { (result) in
                })
            }
        }
        else {
            if self.pageControl.alpha == 0 && self.bottom_continueBtn.constant >= -50 {
                
                self.bottom_continueBtn.constant = -50.0

                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut , animations: {
                    self.view.layoutIfNeeded()
                    
                    self.btn_continue.alpha = 0
                    }, completion: { (result) in
                        
                        self.pageControl.alpha = 1
                })
            }
        }
    }

// MARK: - IBAction

    @IBAction func onPageControl(_ sender: AnyObject) {
        
        scrollView.setContentOffset(CGPoint(x: self.view.width * CGFloat(self.pageControl.currentPage) , y: 0), animated: true)
    }
    
    
    @IBAction func onContinue(_ sender: AnyObject) {
        
        self.playSound(Sound_BtnClick)
        self.performSegue(withIdentifier: "goJoin", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
