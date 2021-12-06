//
//  MovieImageVC.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 11/10/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import SDWebImage
import AVKit

class MediaVC: UIViewController{
    
    //MARK:- Outlets
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var termSearchBar: UISearchBar!
    @IBOutlet weak var mediaSegmentedControl: UISegmentedControl!
    
    //MARK:- Propreties
    private var mediaType = MediaType.all.rawValue
    private var arrOfMedia: [Media] = []
    private let email = UserDefaultManger.shared().getUserEmail()
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        SqlManager.shared().createMediaTable()
        setup()
    }
    override func  viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = MediaKeys.movie
        self.navigationItem.hidesBackButton = true
        getDataFromDB()
    }
    override func viewWillDisappear(_ animated: Bool) {
        if let media = CoderManager.shared().encodMedia (media: self.arrOfMedia){
            if self.arrOfMedia.count > 0 {
                SqlManager.shared().insertInMediaTable(email: self.email ?? " ", mediaData: media, type: self.mediaType)
            }
        }
    }
    
    //MARK:- Private Methods
    private func setup() {
        UserDefaultManger.shared().setIsLoggedIn(Key: true)
        termSearchBar.delegate = self
        movieTableView.register(UINib(nibName: MediaKeys.moviesCell, bundle: nil), forCellReuseIdentifier: MediaKeys.moviesCell)
        movieTableView.dataSource = self
        movieTableView.delegate = self
        addProfileButton()
    }
    private func getDataFromDB(){
        if let data = SqlManager.shared().getMediaDataFromDB(email: email ?? " " )?.0{
            if let media = CoderManager.shared().decodedMedia(mediaData: data){
                if let type = SqlManager.shared().getMediaDataFromDB(email: email ?? " ")?.1{
                    self.arrOfMedia = media
                    self.mediaType = type
                    setSegmanet()
                    self.movieTableView.reloadData()
                }
            }
        }
    }
    private func setMoviesData(){
        APIManager.loadMediaArray(term: termSearchBar.text ?? " " ,media: mediaType ){ (error, mediaarray) in
            if let error = error {
                print (error.localizedDescription)
            }else if let mediaArr = mediaarray{
                self.arrOfMedia = mediaArr
                self.movieTableView.reloadData()
            }
        }
    }
    private func addProfileButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Titles.profile, style: .plain, target: self, action: #selector(goToProfile))
    }
    @objc private func goToProfile (){
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let profilVc = sb.instantiateViewController(withIdentifier: ViewController.profileVC) as! ProfileVC
        self.navigationController?.pushViewController(profilVc, animated: true)
    }
    private func playVideo(at indexPath: IndexPath, urlLink: String){
        let videoURL = URL(string: urlLink)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true, completion: nil)
    }
    private func setSegmanet() {
        switch mediaType {
        case MediaType.music.rawValue:
            mediaType = MediaType.music.rawValue
            mediaSegmentedControl.selectedSegmentIndex = 1
        case MediaType.tvShow.rawValue:
            mediaType = MediaType.tvShow.rawValue
            mediaSegmentedControl.selectedSegmentIndex = 2
        case MediaType.movie.rawValue:
            mediaType = MediaType.movie.rawValue
            mediaSegmentedControl.selectedSegmentIndex = 3
        default:
            mediaType = MediaType.all.rawValue
            mediaSegmentedControl.selectedSegmentIndex = 0
        }
    }
    
    //MARK:- Action
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 1:
            mediaType = MediaType.music.rawValue
        case 2:
            mediaType = MediaType.tvShow.rawValue
        case 3:
            mediaType = MediaType.movie.rawValue
        default:
            mediaType = MediaType.all.rawValue
        }
        setMoviesData()
    }
}

//MARK:- UISearchBarDelegate
extension MediaVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = termSearchBar.text , !text.isEmpty else{
            return
        }
        setMoviesData()
        searchBar.resignFirstResponder()
    }
}

//MARK:- UITableViewDataSource, UITableViewDelegate
extension MediaVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfMedia.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaKeys.moviesCell, for: indexPath) as! MoviesCell
        let media = arrOfMedia[indexPath.row]
        cell.setupCellData(type: mediaType, media: media)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let media = arrOfMedia[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        playVideo(at: indexPath, urlLink: media.trailer ?? "")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
}
