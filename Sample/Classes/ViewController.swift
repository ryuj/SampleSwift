import UIKit
import AudioToolbox
import AVFoundation

class ViewController: UIViewController
{
    var mAudioPlayer: AVAudioPlayer!

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Common
    
    func didTapCommonButton()
    {
        playSound()
    }
    
    func playSound()
    {
        let audioPath = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Jump", ofType: "wav")!)
        do
        {
            mAudioPlayer = try AVAudioPlayer(contentsOf: audioPath as URL)
        }
        catch
        {
            print("AVAudioPlayer error")
        }
        
        mAudioPlayer.play()
    }
    
    //MARK: - Vibration
    
    func setupVibrationBtn()
    {
        let btn: UIButton = UIButton()
        btn.frame = CGRect(x:100, y:100, width:100, height:100)
        btn.setTitle("vibration", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        btn.backgroundColor = UIColor.black
        btn.layer.position = CGPoint(x:100, y:100)
        btn.addTarget(self, action: #selector(ViewController.didTapVibration(sender:)), for: .touchUpInside)
        self.view.addSubview(btn)
    }

    @objc func didTapVibration(sender: UIButton)
    {
        AudioServicesPlaySystemSound(1003)
        AudioServicesDisposeSystemSoundID(1003)
        
        playSound()
    }
    
    //MARK: - IBAction
    
    @IBAction func didTapTwitter(_ sender: Any)
    {
        didTapCommonButton()
        
        print("aaa")
    }
    
    @IBAction func didTapVibration(_ sender: Any)
    {
        didTapCommonButton()
        
        AudioServicesPlaySystemSound(1003)
        AudioServicesDisposeSystemSoundID(1003)
    }
    
    //MARK: -
}
