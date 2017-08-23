//
//  DetailViewController.swift
//  JSON
//
//  Created by Lijie Zhao on 8/23/17.
//  Copyright © 2017 Lijie Zhao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var contact: Contact?

    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.text = contact?.formattedJSON
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
