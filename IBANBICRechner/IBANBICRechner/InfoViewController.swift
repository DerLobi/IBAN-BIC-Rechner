//
//  InfoViewController.swift
//  IBANBICRechner
//
//  Created by Christian Lobach on 23/05/15.
//  Copyright (c) 2015 Christian Lobach. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: InfoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = InfoViewModel()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let index = tableView.indexPathForCell(cell)?.row
        
        let details = segue.destinationViewController as! LicenseDetailsViewController
        details.license = viewModel?.allLicenses()[index!]
    }
    
    @IBAction func doneTapped(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func openPersonalWebsite(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(viewModel!.websiteURL)
    }
    
    @IBAction func openGitHub(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(viewModel!.githubURL)
    }
}

extension InfoViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.allLicenses().count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("license") as! UITableViewCell
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.text = viewModel?.allLicenses()[indexPath.row].name
        return cell;
    }
}

extension InfoViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

