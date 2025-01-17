//
//  MoviesTableViewController.swift
//  Movie List
//
//  Created by Patrick Millet on 11/8/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController, HasSeenDelegate, AddMovieDelegate{
    
    func toggleSeen(on cell: MoviesTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let seenSwitch = seenController.seen[indexPath.row]
        
        seenController.toggleSeen(hasSeen: seenSwitch)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: Properties
    
    var seenController = SeenController()
    
    //    var hasSeenMovie: SeenController?
    
    func movieWasAdded(movie: Movie) {
        seenController.seen.append(movie)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seenController.seen.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewMovieCell", for: indexPath) as? MoviesTableViewCell else { fatalError("Fatal Error: Problem casting cell as custom cell type") }
        
        let singleMovie = seenController.seen[indexPath.row]
        
        cell.seen = singleMovie
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = seenController.seen[indexPath.row]
            
            seenController.swipeTo(delete: movie)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddMovieSegue" {
            if let addMovieVC = segue.destination as? AddMovieViewController {
                addMovieVC.movieDelegate = self
            }
        }
    }
}

