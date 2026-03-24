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
        initialConnection()
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
        self.present(vc, animated: true)
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
        guard Network.shared.isOnline else {
            hideLoading()
            showNetworkAlertView(title: "Espera", msg: "No tienes internet")
            return
        }

        let api = ApiNetwork()
        Task { @MainActor in
            do {
                apodData = try await api.getInfoOfDay()
                self.imgOfDay.getImageFromURL(urlToShow: apodData?.url ?? "")
                self.lblTitleImage.text = apodData?.title ?? ""
                
            } catch let error as URLError {
                switch error.code {
                case .notConnectedToInternet:
                    showNetworkAlertView(title: "Espera", msg: "No tienes internet")
                default:
                  
                    showNetworkAlertView(title: "Error", msg: "No se cargo la info")
                }
                
            } catch {
                showNetworkAlertView(title: "Error", msg: "Ocurrio un problema")
            }
            hideLoading()
        }
    }

    @IBAction func onClickedReload(_ sender: Any) {
        fetchApodData()
    }
}
