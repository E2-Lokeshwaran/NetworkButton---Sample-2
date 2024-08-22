//
//  NetworkManager.swift
//  NetworkButtonMethod-2
//
//  Created by Lokeshwaran on 22/08/24.
//


//import UIKit
//import Network
//
//class NetworkManager {
//
//    static let shared = NetworkManager()
//    private let monitor = NWPathMonitor()
//    private var isMonitoring = false
//    private var banner: UILabel?
//
//    private init() { }
//
//    func startMonitoring() {
//        guard !isMonitoring else { return }
//
//        monitor.pathUpdateHandler = { [weak self] path in
//            DispatchQueue.main.async {
//                if path.status == .satisfied {
//                    self?.updateBanner(isConnected: true)
//                } else {
//                    self?.updateBanner(isConnected: false)
//                }
//            }
//        }
//
//        let queue = DispatchQueue(label: "NetworkMonitor")
//        monitor.start(queue: queue)
//        isMonitoring = true
//    }
//
//    func stopMonitoring() {
//        monitor.cancel()
//        isMonitoring = false
//    }
//
//    private func updateBanner(isConnected: Bool) {
//        if banner == nil {
//            setupBanner()
//        }
//        banner?.backgroundColor = isConnected ? .green : .red
//        banner?.text = isConnected ? "Network Connected" : "No Internet Connection"
//    }
//
//    private func setupBanner() {
//        guard let window = UIApplication.shared.windows.first else { return }
//        let banner = UILabel()
//        banner.translatesAutoresizingMaskIntoConstraints = false
//        banner.textAlignment = .center
//        banner.textColor = .white
//        banner.font = UIFont.boldSystemFont(ofSize: 16)
//        banner.numberOfLines = 1
//        banner.backgroundColor = .red // Default color, will be updated
//        window.addSubview(banner)
//        self.banner = banner
//
//        // Setup constraints
//        NSLayoutConstraint.activate([
//            banner.leadingAnchor.constraint(equalTo: window.leadingAnchor),
//            banner.trailingAnchor.constraint(equalTo: window.trailingAnchor),
//            banner.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor),
//            banner.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//}


import UIKit
import Network
import SwiftyGif

class NetworkManager 
{

    static let shared = NetworkManager()
    private let monitor = NWPathMonitor()
    private var isMonitoring = false
    private var noInternetImageView: UIImageView?
    private var backgroundView: UIView?

    //private init() { }

    func startMonitoring() 
    {
        guard !isMonitoring else 
        {
            return
        }

        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async 
            {
                if path.status == .satisfied 
                {
                    self?.showNoInternetImage(show: false)
                } 
                else
                {
                    self?.showNoInternetImage(show: true)
                }
            }
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        isMonitoring = true
    }

    func stopMonitoring() 
    {
        monitor.cancel()
        isMonitoring = false
    }

    private func showNoInternetImage(show: Bool) 
    {
        if noInternetImageView == nil 
        {
            setupNoInternetImageView()
        }
        backgroundView?.isHidden = !show
        noInternetImageView?.isHidden = !show
    }

    private func setupNoInternetImageView() 
    {
        guard let window = UIApplication.shared.windows.first else { return }
        
        let bgView = UIView()
        bgView.translatesAutoresizingMaskIntoConstraints = false
        //bgView.backgroundColor = UIColor.black.withAlphaComponent(0.7) // Semi-transparent black background
        bgView.backgroundColor = .white
        window.addSubview(bgView)
        self.backgroundView = bgView
        
        
        let gifImageView = UIImageView()
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        gifImageView.contentMode = .scaleAspectFit
        //imageView.image = UIImage(named: "no_img") // Replace with your image name
        
        //gif image
        
        do {
            let gif = try UIImage(gifName: "No_Internet_loader") // Replace with your GIF file name
            gifImageView.setGifImage(gif)
        } 
        catch
        {
            print("Failed to load GIF: \(error)")
        }
        
        //gifImageView.contentMode = .scaleAspectFit
        window.addSubview(gifImageView)
        self.noInternetImageView = gifImageView
        
        NSLayoutConstraint.activate([
            bgView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            bgView.topAnchor.constraint(equalTo: window.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: window.bottomAnchor)
        ])

        // Setup constraints to center the image
        NSLayoutConstraint.activate([
            gifImageView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            gifImageView.centerYAnchor.constraint(equalTo: window.centerYAnchor),
            gifImageView.widthAnchor.constraint(equalToConstant: 400),  // Adjust the width as needed
            gifImageView.heightAnchor.constraint(equalToConstant: 400)  // Adjust the height as needed
        ])
        
        bgView.isHidden = true
        gifImageView.isHidden = true // Initially hidden
    }
}

