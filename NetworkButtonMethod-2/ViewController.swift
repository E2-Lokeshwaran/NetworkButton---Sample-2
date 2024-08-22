//
//  ViewController.swift
//  NetworkButtonMethod-2
//
//  Created by Lokeshwaran on 26/04/24.
//

import UIKit
import Network

class ViewController: UIViewController {

    @IBOutlet weak var Headlbl: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    let monitor = NWPathMonitor()
    var isMonitoringActive = false
    var connect : ConnectedPage?
            
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupMonitoring()
    }
        
    func setupMonitoring()
    {
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied 
                {
                    self.updateImageView(isConnected: true)
//                    self.connect?.statusLbl.text = "connected"
                }
                else
                {
                    self.updateImageView(isConnected: false)
//                  self.connect?.statusLbl.text = "Not connected"
                }
            }
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "ConnectedPage") as! ConnectedPage
//        navigationController?.pushViewController(vc, animated: true);
            let queue = DispatchQueue(label: "NetworkMonitor")
            monitor.start(queue: queue)
            isMonitoringActive = true
        }
        
        func updateImageView(isConnected: Bool) 
        {
            DispatchQueue.main.async
                {
                if isConnected
                {
                    self.img.image = UIImage(named: "online")
                    self.status.text = "Online"
                    //self.view.backgroundColor = .green
                    print("online")
                }
                else
                {
                    self.img.image = UIImage(named: "offlin")
                    self.status.text = "Offline"
                    //self.view.backgroundColor = .red
                    print("offline")
                }
            }
        }
    
    @IBAction func nextVc(_ sender: Any)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ConnectedPage") as! ConnectedPage
        navigationController?.pushViewController(vc, animated: true);
    }
}


