
import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    fileprivate let seekDuration: Float64 = 5
    var step: Step? = nil
    let url = URL(string:  "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview113/v4/99/c4/84/99c48467-71dd-0a95-8388-3c5d4d433ee2/mzaf_6642611679343132363.std.aac.p.m4a")

    
    @IBOutlet weak var ButtonPlay: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var desrciprionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = step?.name ?? ""
        desrciprionLabel.text = step?.description ?? ""
        // Do any additional setup after loading the view.
        
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
                
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
                
        slider.minimumValue = 0
                
        slider.addTarget(self, action: #selector(PlayerViewController.sliderAction(_:)), for: .valueChanged)
                
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        slider.maximumValue = Float(seconds)
        slider.isContinuous = true
        slider.tintColor = UIColor(red: 0.93, green: 0.74, blue: 0.00, alpha: 1.00)
                
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
        if self.player!.currentItem?.status == .readyToPlay {
            let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
            self.slider.value = Float ( time );
        }
                    
        let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp
            if playbackLikelyToKeepUp == false{
                print("IsBuffering")
                self.ButtonPlay.isHidden = true
                        
            } else {
                //stop the activity indicator
                print("Buffering completed")
                self.ButtonPlay.isHidden = false
            }
                    
        }
    }

    @IBAction func playAction(_ sender: Any) {
        
        print("play Button")
            if player?.rate == 0
            {
                player!.play()
                self.ButtonPlay.isHidden = true
                ButtonPlay.setImage(UIImage(systemName: "pause"), for: UIControl.State.normal)
            } else {
                player!.pause()
                ButtonPlay.setImage(UIImage(systemName: "play"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func backPlayAction(_ sender: Any) {
        if player == nil { return }
          if let duration  = player!.currentItem?.duration {
              let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
              let newTime = playerCurrentTime + seekDuration
              if newTime < CMTimeGetSeconds(duration)
              {
                  let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
                  player!.seek(to: selectedTime)
              }
              player?.pause()
              player?.play()
          }
}
    
    @IBAction func forwardPlayAction(_ sender: Any) {
      
        if player == nil { return }
              let playerCurrenTime = CMTimeGetSeconds(player!.currentTime())
              var newTime = playerCurrenTime - seekDuration
              if newTime < 0 { newTime = 0 }
              player?.pause()
              let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
              player?.seek(to: selectedTime)
              player?.play()
}
    
    @IBAction func sliderAction(_ sender: Any) {
        let seconds : Int64 = Int64(slider.value)
          let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
          
          player!.seek(to: targetTime)
          
          if player!.rate == 0
          {
              player?.play()
          }
    }
    
    @objc func finishedPlaying( _ myNotification:NSNotification) {
          ButtonPlay.setImage(UIImage(systemName: "stop"), for: UIControl.State.normal)
      }
}
