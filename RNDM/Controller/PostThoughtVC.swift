//
//  PostThoughtVC.swift
//  RNDM
//
//  Created by W.S. van Arkel jr. on 30-12-17.
//  Copyright © 2017 Warcom. All rights reserved.
//

import UIKit
import Firebase

class PostThoughtVC: UIViewController, UITextViewDelegate {
    
    //Outlets
    @IBOutlet private weak var categorySegment: UISegmentedControl!
    @IBOutlet private weak var userNameTxt: UITextField!
    @IBOutlet private weak var thoughtTxt: UITextView!
    @IBOutlet private weak var postBtn: UIButton!
    
    //Variables
    
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        thoughtTxt.layer.cornerRadius = 4
        postBtn.layer.cornerRadius = 4
        thoughtTxt.text = "My random thought......"
        thoughtTxt.textColor = UIColor.darkGray
        thoughtTxt.delegate = self
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        thoughtTxt.text = ""
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        default:
            selectedCategory = ThoughtCategory.crazy.rawValue
        }
    }
    
    
    @IBAction func postBtnTapped(_ sender: Any) {
        guard let username = userNameTxt.text else {return}
        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [
            CATEGORY : selectedCategory,
            NUM_COMMENTS : 0,
            NUM_LIKES : 0,
            THOUGHT_TXT : thoughtTxt.text,
            TIMESTAMP: FieldValue.serverTimestamp(),
            USERNAME : username
        ]) { (err) in
            if let err = err {
                debugPrint("Error adding documenst: \(err)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
