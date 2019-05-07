import Foundation
import UIKit

class CustomMarkerView: UIView {
    var name: String!
    var img: UIImage!
    var myBorderColor: UIColor!
    
    init(name: String, image: UIImage, borderColor: UIColor, tag: Int) {
        super.init(frame: CGRect.init())
        self.name = name
        self.img=image
        self.myBorderColor = borderColor
        self.tag = tag
        setupViews()
    }
    
    func setupViews() {
        
        let name = UILabel()
        name.text = self.name
        name.textAlignment = .center
        name.font = .init(UIFont(name: "Avenir-Medium", size: 16)!)
        name.textColor = .black
        name.sizeToFit()
        
        let imgView = UIImageView(image: img)
        imgView.frame=CGRect(x: 0, y: 20, width: 45, height: 45)
//        imgView.center = self.center
        imgView.layer.cornerRadius = 23
        imgView.layer.borderColor = myBorderColor.cgColor
        imgView.layer.borderWidth = 3
        imgView.clipsToBounds=true
        
//        let lbl=UILabel(frame: CGRect(x: name.frame.width / 4, y: 65, width: 50, height: 10))
//        lbl.text = "▾"
//        lbl.font=UIFont.systemFont(ofSize: 24)
//        lbl.textColor = myBorderColor
//        lbl.textAlignment = .center
        
        self.addSubview(name)
        self.addSubview(imgView)
//        self.addSubview(lbl)
//        self.frame = .init(x: 0, y: 0, width: name.frame.width, height: 100)
//        self.sizeToFit()
        
        if (name.frame.width > imgView.frame.width) {
            self.frame = .init(x: 0, y: 0, width: name.frame.width, height: 65)
        } else {
            self.frame = .init(x: 0, y: 0, width: imgView.frame.width, height: 65)
        }
        name.center.x = self.center.x
        imgView.center.x = self.center.x
        
//        name.leftAnchor.constraint(equalTo: super.leftAnchor).isActive = true
//        name.topAnchor.constraint(equalTo: super.topAnchor).isActive = true
//        imgView.centerXAnchor.constraint(equalTo: super.centerXAnchor).isActive = true
//        lbl.centerXAnchor.constraint(equalTo: super.centerXAnchor).isActive = true
//        drawTriangle(size: 12, x: self.frame.midX/2, y: self.frame.midY, up: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}









