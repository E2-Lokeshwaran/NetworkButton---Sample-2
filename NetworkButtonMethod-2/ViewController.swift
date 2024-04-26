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
    

    private let monitor = NWPathMonitor()
        private var isMonitoringActive = false
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupMonitoring()
        }
        
        private func setupMonitoring() {
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    self.updateImageView(isConnected: true)
                } else {
                    self.updateImageView(isConnected: false)
                }
            }
            
            let queue = DispatchQueue(label: "NetworkMonitor")
            monitor.start(queue: queue)
            isMonitoringActive = true
        }
        
        private func updateImageView(isConnected: Bool) {
            DispatchQueue.main.async {
                if isConnected 
                {
                    self.img.image = UIImage(named: "online")
                    self.status.text = "Online"
                }
                else
                {
                    self.img.image = UIImage(named: "offlin")
                    self.status.text = "Offline"
                    self.showOfflineAlert()
                }
            }
        }
        private func showOfflineAlert() {
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
        deinit {
            if isMonitoringActive {
                monitor.cancel()
            }
        }
    }


