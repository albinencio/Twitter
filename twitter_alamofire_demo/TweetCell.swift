//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Alberto Nencioni on 02/27/18.
//  Copyright © 2018 Alberto Nencioni. All rights reserved.
//

import UIKit
import AlamofireImage

protocol TweetCellUpdater: class {
  func updateTableView()
}

class TweetCell: UITableViewCell {
  
  // Profile image
  @IBOutlet weak var profileImageView: UIImageView!
  
  // Buttons
  @IBOutlet weak var retweetButton: UIButton!
  @IBOutlet weak var favoriteButton: UIButton!
  
  // Labels
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var screenNameLabel: UILabel!
  @IBOutlet weak var createdAtLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var favoriteCountLabel: UILabel!
  @IBOutlet weak var repliesCountLabel: UILabel!
  
  // Icons
  let retweet_def: UIImage = #imageLiteral(resourceName: "retweet-icon")
  let retweet_sel: UIImage = #imageLiteral(resourceName: "retweet-icon-green")
  let favorite_def: UIImage = #imageLiteral(resourceName: "favor-icon")
  let favorite_sel: UIImage = #imageLiteral(resourceName: "favor-icon-red")
  
  weak var delegate: TweetCellUpdater?
  var tweet: Tweet! {
    didSet {
      nameLabel.text = tweet.user?.name
      let screenName = (tweet.user?.screenName)!
      screenNameLabel.text = "@\(screenName)"
      createdAtLabel.text = tweet.createdAtString
      tweetTextLabel.text = tweet.text
      retweetCountLabel.text = String(tweet.retweetCount!)
      favoriteCountLabel.text = String(tweet.favoriteCount!)
      profileImageView.af_setImage(withURL: URL(string: (tweet.user?.profileImgURL)!)!)
    }
  }
  
  @IBAction func didTapRetweet(_ sender: Any) {
    if (tweet.retweeted)! {
      tweet.retweeted = false
      tweet.retweetCount = tweet.retweetCount! - 1
      self.retweetButton.setImage(retweet_def, for: .normal)
    } else {
      tweet.retweeted = true
      tweet.retweetCount = tweet.retweetCount! + 1
      self.retweetButton.setImage(retweet_sel, for: .normal)
    }
    self.retweetCountLabel.text = String(tweet.retweetCount!)
    updateTableView()
  }
  
  @IBAction func didTapFavorite(_ sender: Any) {
    if (tweet.favorited!) {
      tweet.favorited = false
      tweet.favoriteCount = tweet.favoriteCount! - 1
      self.favoriteButton.setImage(favorite_def, for: .normal)
    } else {
      tweet.favorited = true
      tweet.favoriteCount = tweet.favoriteCount! + 1
      self.favoriteButton.setImage(favorite_sel, for: .normal)
    }
    self.favoriteCountLabel.text = String(tweet.retweetCount!)
    updateTableView()
  }
  
  func updateTableView() {
    delegate?.updateTableView()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
