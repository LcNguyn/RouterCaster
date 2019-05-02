import Foundation
import UIKit

class CustomMarkerView: UIView {
    var img: UIImage!
    var myBorderColor: UIColor!
    
    init(image: UIImage, borderColor: UIColor, tag: Int) {
        super.init(frame: CGRect.init())
        self.img=image
        self.myBorderColor = borderColor
        self.tag = tag
        setupViews()
    }
    
    func setupViews() {
        
        let name = UILabel()
        name.text = "Bella Nguyen"
        name.textAlignment = .center
        name.font = .init(UIFont(name: "Avenir-Book", size: 16)!)
        name.textColor = .black
        name.sizeToFit()
        
        let imgView = UIImageView(image: img)
        imgView.frame=CGRect(x: name.frame.width / 4, y: 20, width: 50, height: 50)
        imgView.layer.cornerRadius = 25
        imgView.layer.borderColor = myBorderColor.cgColor
        imgView.layer.borderWidth=4
        imgView.clipsToBounds=true
        
        let lbl=UILabel(frame: CGRect(x: name.frame.width / 4, y: 65, width: 50, height: 10))
        lbl.text = "▾"
        lbl.font=UIFont.systemFont(ofSize: 24)
        lbl.textColor = myBorderColor
        lbl.textAlignment = .center
        
        self.addSubview(name)
        self.addSubview(imgView)
        self.addSubview(lbl)
        self.frame = .init(x: 0, y: 0, width: name.frame.width, height: 100)
//        name.leftAnchor.constraint(equalTo: super.leftAnchor).isActive = true
//        name.topAnchor.constraint(equalTo: super.topAnchor).isActive = true
//        imgView.centerXAnchor.constraint(equalTo: super.centerXAnchor).isActive = true
//        lbl.centerXAnchor.constraint(equalTo: super.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}









