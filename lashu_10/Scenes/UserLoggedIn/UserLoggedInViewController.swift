//
//  UserLoggedInViewController.swift
//  lashu_10
//
//  Created by Lasha Tavberidze on 03.12.24.
//

import UIKit

class UserLoggedInViewController: UIViewController {
// MARK: Outlets
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var label8: UILabel!
    @IBOutlet weak var imageView9: UIImageView!
    @IBOutlet weak var label9: UILabel!
    @IBOutlet weak var imageView10: UIImageView!
    @IBOutlet weak var label10: UILabel!
    // MARK: Properties
    var user: User?
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserProfile()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
// MARK: Methods
    func setUpUserProfile() {
        configureField(label: label1, imageView: imageView1, text: user?.firstName, symbol: "person")
        configureField(label: label2, imageView: imageView2, text: user?.lastName, symbol: "person.fill")
        configureField(label: label3, imageView: imageView3, text: user?.email, symbol: "envelope.fill")
        configureField(label: label4, imageView: imageView4, text: user?.phoneNumber, symbol: "phone.fill")
        configureField(label: label5, imageView: imageView5, text: user?.address, symbol: "mappin.and.ellipse")
        configureField(label: label6, imageView: imageView6, text:String(user?.age ?? 0), symbol: "calendar")
        configureField(label: label7, imageView: imageView7, text: user?.personalNumber, symbol: "key.fill")
        configureField(label: label8, imageView: imageView8, text: user?.workPlace, symbol: "building.2.fill")
        let maritalStatusText = user?.maritalStatus?.rawValue.capitalized ?? "Not Specified"
        configureField(label: label9, imageView: imageView9, text: maritalStatusText, symbol: "heart.text.square.fill")
        configureField(label: label10, imageView: imageView10, text: "••••••", symbol: "lock.fill")
    }

    private func configureField(label: UILabel, imageView: UIImageView, text: String?, symbol: String) {
        label.text = text ?? "N/A"
        imageView.image = UIImage(systemName: symbol)
        imageView.tintColor = .systemBlue
    }


}
