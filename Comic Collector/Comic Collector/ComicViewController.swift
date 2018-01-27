//
//  ComicViewController.swift
//  Comic Collector
//
//  Created by Nathan Glynn on 1/12/18.
//  Copyright © 2018 Nathan Glynn. All rights reserved.
//

import UIKit

class ComicViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var addupdate: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    // function to hide keyboard when done typing, attached to the textfield via the storyboard
    @IBAction func doneTyping(_ sender: AnyObject) {
    sender.resignFirstResponder()
    }
    var imagePicker = UIImagePickerController()
    // create a "comic" variable to use to determine button layout on this view controller, (if game = true then show 'edit' buttons, if false then show 'add', or whatever)
    var comic : ComicData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // delegation?
        imagePicker.delegate = self
        
        //if comic is not nil then...
        if comic != nil {
            // set the image for the viewcontroller as the image from the comic data
            comicImageView.image =  UIImage(data: (comic?.image)!)
            // set the title for the viewController as the title from the data
            titleTextField.text = comic?.title
            // change the title of the 'add' button to 'update'
            addupdate.setTitle("Update", for: .normal)
        }
        // if comic is nil then hide the delete button
        else {
            deleteButton.isHidden = true
        }
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
        // sets source to camera
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    // function for the 'add'/'update' button behavior
    @IBAction func addTapped(_ sender: Any) {
        
        // if this is an existing comic then update an existing one
        if comic != nil {
            comic!.title = titleTextField.text
            // "UIImagePNGrepresentation renders an image as a png so it can be stored in the database?
            comic!.image = UIImagePNGRepresentation(comicImageView.image!)
        }
            // if it's a new comic then create a new entry
        else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let comic = ComicData(context: context)
            comic.title = titleTextField.text
            comic.image = UIImagePNGRepresentation(comicImageView.image!)

        }
        

        // saves the data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        // closes the "add tab"
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        // set context that the button will be interacting with
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // deletes the "comic" object
        context.delete(comic!)
        // saves the data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        // closes the "add tab"
        navigationController!.popViewController(animated: true)
    }

}
