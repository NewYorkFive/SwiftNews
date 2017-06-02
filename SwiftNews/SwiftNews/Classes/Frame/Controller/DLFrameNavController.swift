//
//  DLFrameNavController.swift
//  SwiftNews
//
//  Created by NowOrNever on 01/06/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit

class DLFrameNavController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        navigationBar.isHidden = true;
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationBar.isHidden = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationBar.isHidden = childViewControllers.count == 1;
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        navigationBar.isHidden = childViewControllers.count == 1;
        return super.popViewController(animated: animated);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
