import UIKit
import AudioToolbox
import AVFoundation
import Accounts
import Social

class ViewController: UIViewController
{
    //MARK: - Var
    
    var mAudioPlayer: AVAudioPlayer!
    
    //MARK: - Override

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
    
    private func didTapCommonButton()
    {
        playSound()
    }
    
    private func playSound()
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
    
    //MARK: - Twitter
    
    var mAccountStore = ACAccountStore()
    var mAccount: ACAccount?
    
    private func selectTwitterAccount()
    {
        let accountType = mAccountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        let handler: ACAccountStoreRequestAccessCompletionHandler! = {(granted:Bool, error:Error?) in
            
            if error != nil {
                print("error!")
                return
            }
            
            if !granted {
                print("error! Twitterアカウントの利用が許可されていません")
                return
            }
            
            let accounts = self.mAccountStore.accounts(with: accountType) as! [ACAccount]
            if accounts.count == 0 {
                print("error! 設定画面からアカウントを設定してください")
                return
            }
            
            // 取得したアカウントで処理を行う...
            return
        }
        
        mAccountStore.requestAccessToAccounts(with: accountType, options: nil, completion: handler)
        
        // こういう書き方もできる
//        mAccountStore.requestAccessToAccounts(with: accountType, options: nil) { (granted:Bool, error:Error?) in return }
    
    }
    
    //MARK: - IBAction
    
    @IBAction func didTapVibration(_ sender: Any)
    {
        didTapCommonButton()
        
        AudioServicesPlaySystemSound(1003)
        AudioServicesDisposeSystemSoundID(1003)
    }
    
    @IBAction func didTapTwitter(_ sender: Any)
    {
        didTapCommonButton()
        
        selectTwitterAccount();
    }
    
    //MARK: -
}
