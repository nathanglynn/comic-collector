//
//  ComicViewController.swift
//  Comic Collector
//
//  Created by Nathan Glynn on 1/12/18.
//  Copyright © 2018 Nathan Glynn. All rights reserved.
//

import UIKit

class ComicViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var comicImageView: UIImageView!

    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // delegation?
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
// function for "photos" button in nav
    @IBAction func photosTapped(_ sender: Any) {
       // sets source for image picker variable described above
        imagePicker.sourceType = .photoLibrary
       //let's us place another viewcontoller on the screen present(*whatever the view controller is*, is it animated, what code should be executed)
        present(imagePicker, animated: true, completion: nil)
    }
    // function with what image was selected, (the 'didfinishpicking..." part), creates a dictionary called info
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //code to set the value of "image" to the image selected in the picker
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // code to set the value of the comic image place holder to the image selected above
        comicImageView.image = image
        // code to dismiss the image picker after choice is made
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
// function for camera button in nav
    @IBAction func cameraTapped(_ sender: Any) {
    }
    @IBAction func addTapped(_ sender: Any) {
    
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let comic = ComicData(context: context)
        comic.title = titleTextField.text
        // "UIImagePNGrepresentation renders an image as a png so it can be stored in the database?
        comic.image = UIImagePNGRepresentation(comicImageView.image!)
        // saves the data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        // closes the "add tab"
        navigationController!.popViewController(animated: true)
    }
}
