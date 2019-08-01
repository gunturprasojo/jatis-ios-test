## Jatis-iOS
<p align="center">
  <img src ="https://github.com/gunturprasojo/Jatis-iOS/blob/master/Example/Jatis-iOS/Images.xcassets/jatis.imageset/lgJatis%403x.png" />
</p>


## Requirements
* iOS 10.2 (Minimum) - iOS 12.2 (Recommended)
* Swift 4.2
* XCode 10

## Installation
Jatis-iOS is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:
```ruby
pod 'Jatis-iOS' , '0.2.3.3'
```

## Feature
* Banner
* Shadow
* Textfield

## Overview
* [Advanced API](https://github.com/gunturprasojo/Jatis-iOS/blob/master/Example/Jatis-iOS/ViewController.swift)

## How To Use
### 1. Import API :
```swift
import Jatis_iOS
```

### 2. Adding banner : 
```swift
let jatisBanner = JatisBanner()
firstBannerView.layoutIfNeeded()
        jatisBanner.images = images
        jatisBanner._id = _id
        jatisBanner.aspectRatio = 9/16
        jatisBanner.animate = true
        jatisBanner.cornerRadius = 20
        jatisBanner.size = firstBannerView.bounds.size
        jatisBanner.animationInterval = 3.0
        jatisBanner.reloadBanner()
        firstBannerView.addSubview(jatisBanner)
        firstBannerView.addRoundShadow(fillColor: .white, cornerRadius: 20, 
                    shadowColor: .black, shadowOpacity: 0.9, shadowOffSet: CGSize(width: 4, height: 5), 
                    shadowRadius: 15, scale: 1)
        jatisBanner.tag = 1
        jatisBanner.delegate = self
        self.firstBannerView.addSubview(jatisBanner)
```

### 3. Adding shadow : 
```swift
firstBannerView.addRoundShadow(fillColor: .white,
                             cornerRadius: 50,
                             shadowColor: .black,
                             shadowOpacity: 0.8,
                             shadowOffSet: CGSize(width: -5, height: 2),
                             shadowRadius: 5,
                             scale: 1)
```

### 4. Action Handling (If Image Clicked)
```swift
extension ViewController : JatisBannerProtocol {
    func didSelectBanner(_ data: String, tagBanner  : Int) {
        print("\(data) & \(tagBanner)")
    }
}
```

### 5. Adding TextField
```swift
@IBOutlet var textFieldView: UIView!
@IBOutlet var labelView: UILabel!
  
override func viewDidLoad() {
    super.viewDidLoad()
    self.generateTextFieldView()
}
    

func generateTextFieldView(){
      var usernameTextfield = JatisTextField()
      usernameView.layoutIfNeeded()
      usernameTextfield.tagTextfield = 1
      usernameTextfield.textPlaceholder = "Username"
      usernameTextfield.size = usernameView.bounds.size
      usernameTextfield.fontPlaceholder = UIFont(name: "Futura", size: 14)!
      usernameTextfield.textColor = .darkText
      usernameTextfield.doneButtonColor = .blue
      usernameTextfield.placeHolderBeforeColor = .lightGray
      usernameTextfield.labelPlaceholder.textAlignment = .left
      usernameTextfield.textField.textAlignment = .left
      usernameTextfield.delegate = self
      usernameTextfield.setJatisTextField()
      usernameView.addSubview(usernameTextfield)
}
```


### 6. Adding Pop Up Table
```swift

class TablePopUpViewController: UIViewController {
    let popUpTable = JatisPopUpTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actShowTable(_ sender: Any) {
        popUpTable.parentSize = self.view.frame.size
        popUpTable.tableSize = CGSize(width: 300, height: 300)
        popUpTable.center = self.view.center
        popUpTable.strings = ["a","b","c"]
        popUpTable.title = "aaa"
        popUpTable.maximumDisplayedCell = 3
        popUpTable.formatPopUp()
        popUpTable.delegate = self
        self.view.addSubview(popUpTable)
    }
}

extension TablePopUpViewController: JatisPopUpTableProtocol {
    func didSelect(_ data: String, row : Int) {
        print(data)
        self.popUpTable.removeFromSuperview()
    }
}

```


### 7. Adding TextView
```swift

class TextViewVC: UIViewController {
    @IBOutlet var txView1: UIView!
    @IBOutlet var txView2: UIView!
    
    let textView1 = JatisTextView()
    let textView2 = JatisTextView()
    
    var stringUsername : String = ""
    var stringPassword : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateTextView()
        // Do any additional setup after loading the view.
    }
    
    func generateTextView(){
        
        txView1.layoutIfNeeded()
        textView1.tagTextView = 1
        textView1.textPlaceholder = "Username"
        textView1.size = txView1.bounds.size
        textView1.fontPlaceholder = UIFont(name: "Futura", size: 10)!
        textView1.textColor = .darkText
        textView1.doneButtonColor = .orange
        textView1.placeHolderBeforeColor = .lightGray
        textView1.delegate = self
        textView1.borderStyle = .none
        textView1.isUnderlined = true
        self.textView1.backgroundColor = .darkGray
        textView1.setJatisTextView()
        txView1.addSubview(textView1)
        
        txView2.layoutIfNeeded()
        textView2.tagTextView = 2
        textView2.textPlaceholder = "Password"
        textView2.size = txView2.bounds.size
        textView2.fontPlaceholder = UIFont(name: "Futura", size: 10)!
        textView2.textColor = .darkText
        textView2.doneButtonColor = .orange
        textView2.placeHolderBeforeColor = .lightGray
        textView2.delegate = self
        textView2.labelPlaceholder.textAlignment = .center
        textView2.textView.textAlignment = .center
        self.textView2.backgroundColor = .darkGray
        textView2.setJatisTextView()
        txView2.addSubview(textView2)
    }

}

extension TextViewVC : JatisTextViewProtocol {
    func didJatisTextViewBeginEditing(_ data: String, tagTextView: Int) {
        print("did begin : \(data)")
    }
    
    func didJatisTextViewEndEditing(_ data: String, tagTextView: Int) {
         print("did end : \(data)")
    }
    
    func didJatisTextViewChange(_ data: String, tagTextView: Int) {
         print("did change : \(data)")
    }
    
    func didJatisTextViewShouldEnd(_ data: String, tagTextView: Int) -> Bool {
         print("did begin : \(data)")
        if tagTextView == 1 {
            return data.lowercased().contains("first") || data == ""
        }
        return true
    }
    
    
}


```


### 8. Action Handling TextField
```swift
extension ViewController : JatisTextFieldProtocol {
   func didJatisTextBeginEditing(_ data: String, tagTextField: Int) {
      
    }
    
    func didJatisTextEndEditing(_ data: String, tagTextField: Int) {
      
    }
    
    func didJatisTextChange(_ data: String, tagTextField: Int) {
       
    }
}
```


GIF Demo
==========
<p align="center">
  <img src ="https://github.com/gunturprasojo/Jatis-iOS/blob/master/Example/Jatis-iOS/demo.gif" 
       width="279" height="570"/>
</p>


## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Author

Guntur Budi, guntur.prasojo@jatis.com

## License

Jatis-iOS is available under the MIT license. See the LICENSE file for more info.
