//
//  ViewController.swift
//  Comic Collector
//
//  Created by Nathan Glynn on 1/12/18.
//  Copyright © 2018 Nathan Glynn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // outlet for tableView object in viewcontroller
    @IBOutlet weak var tableView: UITableView!
    //create variable for tableview, it is defined as an empty array, the content will get set in the 'view will appear' function below
    var comiclist: [ComicData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    // function for what to do when the viewcontroller appears
    override func viewWillAppear(_ animated: Bool) {
        // sets the 'context' for the data, (this was copy/pasted from the other file where data is entered)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // sets the value of the comiclist variable as the contents of the comicdata db using a fetch request, wrapped in a try/catch block, because it has to be
        do {
        comiclist = try context.fetch(ComicData.fetchRequest())
        tableView.reloadData()
        } catch {
            
        }
    }
        // function to set number of rows as an integer...
        func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
            // ...where the integer is the count of items in the 'comiclist variable/array
            return comiclist.count
        }
    // function to describe cells
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            // make a cell and define what a cell is/has
            let cell = UITableViewCell()
            let comic = comiclist[indexPath.row]
            // set the label for the cell based on the title of the row in the array
            cell.textLabel?.text = comic.title
            //sets a thumbnail for the cell, the stuff after the '=' is converting the image data back to an image
            cell.imageView?.image = UIImage(data: (comic.image)!)
            return cell
        }
    // function to allow user to select a row and view the comic
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            let comic = comiclist[indexPath.row]
        performSegue(withIdentifier: "comicSegue", sender: comic)
    }
    // function to send the comic that was selected to the comic view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! ComicViewController
        nextVC.comic = sender as? ComicData
    }
}


