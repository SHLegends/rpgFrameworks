//
//  HubViewController.swift
//  Gold & Glory
//
//  Created by Joel Huggett on 2017-12-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit



class HubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HubViewDelegate {
    
    func refreshCellForRow(_ path: IndexPath) {
        let row: HubTableViewCell = tableView.cellForRow(at: path) as! HubTableViewCell
        let rowContestent = contestants.contestants[path.row]
        if rowContestent.isDead {
            row.wellbeingLabel.text = "Feeling Deceased"
        } else {
            row.wellbeingLabel.text = "Feeling Alive and Well"
        }
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataToPass: (person: contestent, path: IndexPath)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contestants.contestants.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "hubCell", for: indexPath) as! HubTableViewCell
        let rowContestent = contestants.contestants[indexPath.row]
        
        
        row.nameLabel.text = rowContestent.name
        if rowContestent.isDead {
            row.wellbeingLabel.text = "Feeling Deceased"
        } else {
            row.wellbeingLabel.text = "Feeling Alive and Well"
        }
        
        return row
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = (person: contestants.contestants[indexPath.row], path: indexPath)
        self.dataToPass = data
        performSegue(withIdentifier: "hubSelected", sender: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        
        if let VC: HubSelectedViewController = segue.destination as? HubSelectedViewController {
            if let data = dataToPass {
                
                VC.contestant = data.person
                VC.index = data.path
            }
            
            VC.delegate = self
        }
        
    }
 

}
