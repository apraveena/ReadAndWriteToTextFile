//
//  ViewController.swift
//  ReadAndWriteToTextFile
//
//  Created by Spur IQ on 5/26/19.
//  Copyright © 2019 Praveena. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var allToys = ["None"]
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    let strFileName = "spurIQArrayTest.txt"
    //let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    @IBAction func inputPressEnterTriggered(_ sender: Any) {
        updateData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allToys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellID")
        cell.textLabel?.text = allToys[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCell.EditingStyle.delete){
            allToys.remove(at: indexPath.row)
            writeArrayToFile()
            myTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        readDataFromFile()
        myTableView.reloadData()
    }
    
    @IBAction func SaveToArrayButton(_ sender: Any) {
        updateData()
    }
    
    func updateData(){
        if(input.text != "") {
            allToys.append(input.text!)
            writeArrayToFile()
            myTableView.reloadData()
            input.text = ""
        }
    }
    
    func readDataFromFile(){
        let fileURL = dir?.appendingPathComponent(strFileName)
        print(fileURL)
        allToys = NSMutableArray(contentsOf: fileURL!) as! [String]
    }
    
    // This is to write array of data to a file
    func writeArrayToFile()
    {
     let fileURL = dir?.appendingPathComponent(strFileName)
       (allToys as NSArray).write(to: fileURL!, atomically: true)
    }
    
}

