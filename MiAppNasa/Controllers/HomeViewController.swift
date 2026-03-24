//
//  HomeViewController.swift
//  MiAppNasa
//
//  Created by Cinthia Villegas on 23/03/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var lblTitleImage: UILabel!
    
    @IBOutlet weak var imgOfDay: UIImageView!
    
    var loadingView: UIView?
    
    var apodData: Apod?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLoading()
    }
    func setupUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkChanged), name: .networkStatusChanged, object: nil)
        
    }
    
    func initialConnection() {
        if Network.shared.isOnline {
            hideNetworkAlertView()
            fetchApodData()
        } else {
            showNetworkAlertView(title: "Espera", msg: "No tienes internet")
        }
    }
    
    func hideNetworkAlertView () {
        
    }
    
    func showNetworkAlertView(title: String, msg: String) {
        let vc = AlertViewController()
       
        vc.textFrom = title
        vc.msgFrom = msg
        vc.onRetry = { [weak self] in
               
            self?.navigationController?.popViewController(animated: true)
            self?.retryConnection()
           }
        self.navigationController?.present(vc, animated: true)
    }
    
    @objc private func networkChanged() {
        if Network.shared.isOnline {
            hideNetworkAlertView()
            fetchApodData()
        } else {
            showNetworkAlertView(title: "Espera", msg: "No tienes internet")
        }
    }
    
    
    func retryConnection(){
        if Network.shared.isOnline {
            hideNetworkAlertView()
            setupLoading()
            fetchApodData()
        }else {
            showNetworkAlertView(title: "Espera", msg: "No tienes internet")
        }
    }
    
   
    
    func setupLoading() {
        let loading = UIView(frame: view.bounds)
        loading.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = loading.center
        spinner.startAnimating()
        
        loading.addSubview(spinner)
        view.addSubview(loading)
        
        loadingView = loading
    }
    
    func hideLoading() {
        loadingView?.removeFromSuperview()
    }
    
    func fetchApodData() {
        
        let api = ApiNetwork()
        Task {
            do {
                apodData = try await api.getInfoOfDay()
                self.imgOfDay.getImageFromURL(urlToShow: apodData?.url ?? "")
                self.lblTitleImage.text = apodData?.title ?? ""
    
            } catch {
                apodData = nil
            }
            hideLoading()
        }
    }

    @IBAction func onClickedReload(_ sender: Any) {
        setupLoading()
        fetchApodData()
    }
    

}
