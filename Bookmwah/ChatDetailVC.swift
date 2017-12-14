//
//  ChatDetailVc.swift
//  Petnod
//
//  Created by admin on 21/03/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import Foundation


@objc class ChatDetailVC: UIViewController ,UITableViewDelegate , UITableViewDataSource, UIGestureRecognizerDelegate, MDGrowingTextViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    let kSCREEN_X = UIScreen.main.bounds.origin.x
    let kSCREEN_Y = UIScreen.main.bounds.origin.y
    let kSCREEN_WIDTH = UIScreen.main.bounds.size.width
    let kSCREEN_HEIGHT = UIScreen.main.bounds.size.height
    
    ////////////// Common Color Code ///////////////
    let colorClear = UIColor.clear
    let colorWhite = UIColor.white
    let colorBlack = UIColor.black
    let colorRed = UIColor.red
    let colorGray = UIColor.gray
    let colorDarkGray = UIColor.darkGray
    let colorLightGray = UIColor.lightGray
    let colorYellow = UIColor.yellow
    let colorGreen = UIColor.green
    let colorCyan = UIColor.cyan
    

    
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var omgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    //@IBOutlet weak var txtmsg: UITextField!
    @IBOutlet weak var lblstrItemStatus: UILabel!
    
    var statusDate = NSDate()
    var strItemCategory : String!
    var strItemName : String!
    var strItemSeller : String!
    var strItemBuyer : String!
    var strItemImg : String!
    var imgProfile : UIImage!
    var strItemStatus : String!
    var strProfilePicture : String!
    var strBuyerProfilePicture : String!
    var strowner_name : String!
    var strBuyer_name : String!
    
    var lastdate  = Date()
    
    var aryUserChatData = NSMutableArray()
    var aryData = NSMutableArray()
    
    var tagtblScroll = 0
    var timer = Timer()
    var timerForLoadChat = Timer()
    var timerForOnlineStatus = Timer()

    var chatImage = UIImage()
    var imagePicker = UIImagePickerController()
    
    //Added by Rahul on 29Mar2017 for new changes
    var strViewComeFrom : String = ""
    var dictInvoiceData = NSMutableDictionary()
    
    @IBOutlet weak var btnCamera = UIButton()
    @IBOutlet weak var btnGallary = UIButton()
    @IBOutlet weak var btnInvoice = UIButton()
    @IBOutlet weak var btnCameraForBuyer = UIButton()
    @IBOutlet weak var btnGallaryForBuyer = UIButton()
    @IBOutlet weak var viewOverlay: UIView!
    @IBOutlet weak var viewForBuyer: UIView!
    @IBOutlet weak var viewForSeller: UIView!
    @IBOutlet weak var sellerViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var buyerViewHeightConst: NSLayoutConstraint!
    
    //For create or cancel invoice
    @IBOutlet weak var viewOverlayForInvoice: UIView!
    @IBOutlet weak var lblHeaderForInvoice = UILabel()
    @IBOutlet weak var lblProductForInvoice = UILabel()
    @IBOutlet weak var lblProductPriceForInvoice = UILabel()
    @IBOutlet weak var lblCurrencyForInvoice = UILabel()
    @IBOutlet weak var txtForOfferPriceForInvoice = UITextField()
    @IBOutlet weak var txtForDescForInvoice = UITextView()
    @IBOutlet weak var btnSendOrCancelInvoice = UIButton()
    
    //Added by Rahul for getting more chat details
    var strItem_Buyer_Id : String!
    var strItem_Seller_Id : String!
    var strItem_Id : String!
    var strItem_Type : String!
    var strItem_Price : String!
    var strItem_P_Name : String!
    var tag_Loder  : Int!

    //Added by Rahul on 3April2017 for growing textview
    @IBOutlet weak var viewForTblView: UIView!
    var commentTextView = MDGrowingTextView()
    var containerView = UIView()
    var btnSendMsg = UIButton()
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        btnSendMsg.isEnabled = false
//        if DeviceType.IS_IPAD {
//            lblName.font = UIFont(name: (lblName.font.fontName), size: 22)!
//            lblstrItemStatus.font = UIFont(name: (lblstrItemStatus.font.fontName), size: 12)!
//        }

        tag_Loder = 1
        tagtblScroll = 1
        lblstrItemStatus.text = ""
        print("strItemCategory: \(strItemCategory)")
        print("strItemName: \(strItemName)")
        print("strItemSeller: \(strItemSeller)")
        print("strItemBuyer: \(strItemBuyer)")
        print("strItemImg: \(strItemImg)")
        print("strItemStatus: \(strItemStatus)")
        print("strProfile: \(strProfilePicture)")
        print("strBuyerProfilePicture: \(strBuyerProfilePicture)")
        print("strmOwner: \(strowner_name)")
        
        //Added by Rahul on 30Mar2017 for chat data
        print("strItem_Seller_Id: \(strItem_Seller_Id)")
        print("strItem_Buyer_Id: \(strItem_Buyer_Id)")
        print("strItem_Id: \(strItem_Id)")
        print("strItem_Price: \(strItem_Price)")
        print("strItem_Type: \(strItem_Type)")
        
        self.tv.dataSource = self
        self.tv.delegate = self
        lblName.text = strItemSeller!
        lblName.text = strowner_name!
        
//        if strowner_name == nsud.value(forKey: "UserName")as! String {
//            lblName.text = strBuyer_name!
//        }
//        let strimg_Product = strProfilePicture
//        omgProfile.sd_setImage(with: URL(string: strimg_Product!), placeholderImage:UIImage(named: "user_default"))
        
        //-------CommentField Load--------//
        self.viewDidLoadExtra()
        self.originalFrame()
        
        //load_Chat_Data()
        
        self.lblstrItemStatus.textColor = UIColor .white
        
        //Added by Rahul on 29Mar2017 for new changes
        viewOverlayForInvoice.isHidden = true
        //
//        txtForOfferPriceForInvoice?.tag = 101
//        txtForOfferPriceForInvoice?.delegate = self
//        txtForOfferPriceForInvoice?.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
//        self.btnSendOrCancelInvoice?.isEnabled = true
        
//        txtForDescForInvoice?.delegate = self
//        txtForDescForInvoice?.layer.borderWidth = 0.5
//        txtForDescForInvoice?.layer.borderColor = colorGray.cgColor
//        txtForDescForInvoice?.layer.cornerRadius = 5
//        txtForDescForInvoice?.layer.masksToBounds = true
//        txtForDescForInvoice?.text = "DESCRIPTION / REMARK"
//        txtForDescForInvoice?.textColor = colorGray
        
        setUpOverlayView()
        
        //
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(taped(_:)))
        tapGesture.cancelsTouchesInView = false
        tv.addGestureRecognizer(tapGesture)
        
       
    }
    
    func taped(_ recognizer: UITapGestureRecognizer) {
        commentTextView.resignFirstResponder()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //Updated by Rahul on 4April2017 for loading view on navigation
          }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
   
        NotificationCenter.default.addObserver(self, selector: #selector(ChatDetailVC.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatDetailVC.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
      //  IQKeyboardManager.shared().isEnableAutoToolbar = false /// by rd
        
        if (self.tag_Loder == 1){
           // self.webViewDidStartLoad()
        }
     //   self.load_Chat_Data()
        //self.timerForLoadChat = Timer.scheduledTimer(timeInterval: 10.0 , target: self, selector: #selector(self.load_Chat_Data), userInfo: nil, repeats: true);
  }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
       // IQKeyboardManager.shared().isEnableAutoToolbar = true /// by rd
    }
    
    func keyboardWillHide(_ sender: Notification) {
        if (sender as NSNotification).userInfo != nil {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.originalFrame()
            })
        }
    }
    func keyboardWillShow(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                
                if commentTextView.isFirstResponder() {
                   // IQKeyboardManager.shared().isEnableAutoToolbar = false
                    containerView.frame = CGRect(x:0, y:kSCREEN_HEIGHT-(keyboardHeight+54), width: kSCREEN_WIDTH, height: 54)
                    containerView.translatesAutoresizingMaskIntoConstraints = true;
                    
                    //
                    let h : CGFloat = kSCREEN_HEIGHT-(keyboardHeight+64+54)
                    tv.frame = CGRect(x:0, y:0, width: kSCREEN_WIDTH, height: h)
                    
                    if aryUserChatData.count > 0 {
                        //Tableview Scroll to top
                        let indexPath = NSIndexPath(row: self.aryUserChatData.count - 1, section: 0)
                        self.tv.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
                    }
                    
                    UIView.animate(withDuration: 0.25, animations: { () -> Void in
                        self.view.layoutIfNeeded()
                    })
                } else {
                   //  IQKeyboardManager.shared().isEnableAutoToolbar = true  /// by rd
                }
            }
        }
    }
    
    // MARK:- MDGrowingTextView Delegate
    // ***********----------*************
    // MARK:-
    func originalFrame()
    {
        let lblFrameHeight:CGFloat  = 54
        containerView.frame = CGRect.init(x: 0, y: kSCREEN_HEIGHT - lblFrameHeight ,width: kSCREEN_WIDTH ,height: lblFrameHeight)
        
        commentTextView.frame = CGRect.init(x:10, y:10, width: kSCREEN_WIDTH-70 , height: 34)
        
        btnSendMsg.frame = CGRect(x: kSCREEN_WIDTH-55, y: 10, width: 50, height: 34)
        
        let h : CGFloat = kSCREEN_HEIGHT-(lblFrameHeight+64)
        tv.frame = CGRect(x:0, y:0, width: kSCREEN_WIDTH, height: h)
    }
    
    public func growingTextViewDidBeginEditing(_ growingTextView: MDGrowingTextView!) {
        //self.table.isUserInteractionEnabled = false
    }
    
    public func growingTextViewDidEndEditing(_ growingTextView: MDGrowingTextView!) {
        //self.table.isUserInteractionEnabled = true
    }
    
    public func growingTextView(_ growingTextView: MDGrowingTextView, willChangeHeight height: Float) {
        
        ////// textView Frame //////
        let diff = CGFloat(growingTextView.frame.size.height) - CGFloat(height);
        var r: CGRect = containerView.frame
        r.size.height -= diff
        r.origin.y += diff
        containerView.frame = r
        
        ////// send btn Frame //////
        var rSend: CGRect = btnSendMsg.frame
        rSend.origin.y = containerView.frame.height-44;
        btnSendMsg.frame = rSend
        
        let h : CGFloat = viewForTblView.frame.height - (216 + containerView.frame.height)
        tv.frame = CGRect(x:0, y:0, width: kSCREEN_WIDTH, height: h)
        
        if aryUserChatData.count > 0 {
            //Tableview Scroll to top
            let indexPath = NSIndexPath(row: self.aryUserChatData.count - 1, section: 0)
            self.tv.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
        }
    }
    
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print(touches)
        
        self.view!.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    //MARK:- viewDidLoadExtra
    //MARK:-
    func viewDidLoadExtra() {
        
        self.view!.addSubview(containerView)
        
        // textView.textColor = [WebService colorWithHexString:@"#dddddd"];
        
       // containerView.backgroundColor = WebService.color(withHexString: "ebebeb")
        
       // containerView.backgroundColor = hexStringToUIColor(hex: "658C67")//
        commentTextView.isScrollable = false
        commentTextView.maxNumberOfLines = 4
        commentTextView.font = UIFont(name: "Helvetica", size: 15)
        commentTextView.delegate = self
        commentTextView.layer.borderColor = colorGray.cgColor
        commentTextView.layer.borderWidth = 0.5
        commentTextView.layer.cornerRadius = 5
        commentTextView.layer.masksToBounds = true
        commentTextView.placeholder = "Message..."
        commentTextView.autoresizingMask = .flexibleWidth
        commentTextView.backgroundColor = colorWhite
        
        btnSendMsg.setImage(UIImage(named: "send"), for: UIControlState.normal)
        btnSendMsg.backgroundColor = colorClear// hexStringToUIColor(hex: "385241")
        btnSendMsg.addTarget(self, action:#selector(ChatDetailVC.btnSendMsgClicked(_:)), for: UIControlEvents.touchUpInside)
        
        containerView.addSubview(commentTextView)
        containerView.addSubview(btnSendMsg)
        
        self.view.bringSubview(toFront: viewOverlay)
        self.view.bringSubview(toFront: viewOverlayForInvoice)
    }
    
    func setUpOverlayView() {
        self.viewOverlay?.isHidden = true
        
//        setupButton(button: btnCamera!)
//        setupButton(button: btnGallary!)
//        setupButton(button: btnInvoice!)
//        setupButton(button: btnCameraForBuyer!)
//        setupButton(button: btnGallaryForBuyer!)
        btnCamera?.addTarget(self, action: #selector(self.openCamera), for: .touchUpInside)
        btnGallary?.addTarget(self, action: #selector(self.openGallary), for: .touchUpInside)
       // btnInvoice?.addTarget(self, action: #selector(self.generateOrCancelInvoice), for: .touchUpInside)
        //
        btnCameraForBuyer?.addTarget(self, action: #selector(self.openCamera), for: .touchUpInside)
        btnGallaryForBuyer?.addTarget(self, action: #selector(self.openGallary), for: .touchUpInside)
        
        sellerViewHeightConst.constant = 0.0
        buyerViewHeightConst.constant = 0.0
        
        //End editing of view
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
//        tapGesture.cancelsTouchesInView = false
//        view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Button actions
    @IBAction func actionBack(_ sender: AnyObject) {
        self.view.endEditing(true)
        self.timer.invalidate()
        self.timerForLoadChat.invalidate()
        self.timerForOnlineStatus.invalidate()
        self.dismiss(animated: false, completion: nil)
    }
    
    //@IBAction func actionSend(_ sender: AnyObject) {
    func btnSendMsgClicked(_ sender: AnyObject) {
        if self.aryUserChatData.count == 0 {
            //setUp_Parse_ChatUserTbl()
        } else {
            //Added by Rahul on 3April2017 for not sending blank msg
            let msg = commentTextView.text
            if msg != nil {
                let strMsg = commentTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                if strMsg != "" {
                   // self.sendMessagedataToserver()
                }
            }
        }
    }
    
    //
    @IBAction func btnMore(_ sender : AnyObject) {
        commentTextView.resignFirstResponder()
        let strType = self.strViewComeFrom.uppercased()
        if strType == "SELLER" {
           // self.getInvoiceStatus()
        } else {
            updateView("3")
        }
    }
    
    @IBAction func btnCrossClicked(_ sender: AnyObject)
    {
        //Added by Rahul on 10April2017 for removing text when cancelled or data is send
        txtForOfferPriceForInvoice?.text = ""
        txtForDescForInvoice?.text = "DESCRIPTION / REMARK"
        txtForDescForInvoice?.textColor = colorGray
        self.createView(viewPopUp: viewOverlayForInvoice)
    }
    
   
    //MARK:- Image picker
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(imagePicker, animated: true, completion: nil)
        }
//        else
//        {
//            ///////////////////
//            let popup = PopupDialog(title: "", message: "Your device doesn't support camera." , buttonAlignment: .horizontal, transitionStyle: .zoomIn, gestureDismissal: false) {
//                print("Completed")
//            }
//            
//            // Create second button
//            let btnOk = DefaultButton(title: "OK") {
//            }
//            btnOk.backgroundColor = colorLightGreenText
//            btnOk.titleFont = UIFont.init(name: "Calibri", size: 18)
//            btnOk.titleColor = colorWhite
//            
//            // Add buttons to dialog
//            popup.addButtons([btnOk])
//            
//            // Present dialog
//            DispatchQueue.main.async {
//                var hostVC = UIApplication.shared.keyWindow?.rootViewController
//                while let next = hostVC?.presentedViewController {
//                    hostVC = next
//                }
//                hostVC?.present(popup, animated: true, completion: nil)
//            }
//        }
    }
    
    func openGallary()
    {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        //imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //
    
    func updateView(_ invoiceStatus: String) {
        self.viewOverlay?.backgroundColor =  colorDarkGray.withAlphaComponent(0.5)
        
        self.sellerViewHeightConst.constant = 100.0
        self.buyerViewHeightConst.constant = 100.0
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        self.viewOverlay?.isHidden = false
        
        //invoiceStatus = 1: show all 3 buttons with cancel invoice option
        //invoiceStatus = 2: show all 3 buttons with generate invoice option
        //invoiceStatus = 3: show only 2 buttons without invoice button
        //invoiceStatus = 4: show only 2 buttons without invoice button
        if invoiceStatus == "1" {
            self.viewForSeller.isHidden = false
            self.viewForBuyer.isHidden = true
            self.btnInvoice?.setTitle("CANCEL INVOICE", for: .normal)
            self.btnInvoice?.setImage(UIImage(named: "iconCancelInvoice"), for: .normal)
            self.btnInvoice?.tag = 101
        } else if invoiceStatus == "2" {
            self.viewForSeller.isHidden = false
            self.viewForBuyer.isHidden = true
            self.btnInvoice?.setTitle("GENERATE INVOICE", for: .normal)
            self.btnInvoice?.setImage(UIImage(named: "iconGenerateInvoice"), for: .normal)
            self.btnInvoice?.tag = 102
        } else if invoiceStatus == "4" {
            self.viewForBuyer.isHidden = false
            self.viewForSeller.isHidden = true
        } else {
            self.viewForBuyer.isHidden = false
            self.viewForSeller.isHidden = true
        }
    }
    
    
    // MARK:-- createView  With Animation methode --
    
    func createView(viewPopUp: UIView) {
        
        if (viewPopUp.isHidden == true){
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
            viewPopUp.isHidden = false;
            viewPopUp.backgroundColor =  colorDarkGray.withAlphaComponent(0.5)
            
            viewPopUp.transform = CGAffineTransform(scaleX: 0.01, y: 0.01);
            UIView.animate(withDuration: 0.25 ,
                           animations: {
                            viewPopUp.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                            viewPopUp.alpha = 1
                },
                           completion: { finish in
                            
                            UIView.animate(withDuration: 0.15){
                                viewPopUp.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                                UIView.animate(withDuration: 0.15){
                                    viewPopUp.transform = CGAffineTransform.identity
                                }
                            }
            })
            
        }else{
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            UIView.animate(withDuration: 0.1 ,
                           animations: {
                            viewPopUp.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                            
                },
                           completion: { finish in
                            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
                                viewPopUp.alpha = 0.0
                                viewPopUp.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                                }, completion: { (finished) in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        viewPopUp.alpha = 0.0
                                        }, completion: { (finished) in
                                            viewPopUp.isHidden = true;
                                    })
                            })
            })
        }
    }
    
    //--------------------------------//
    
    
    
       func scrollToBottom(animated:Bool) {
        
        if  aryUserChatData.count != 0 {
            let indexpath = IndexPath(row: self.aryUserChatData.count-1, section: 0)
            self.tv.scrollToRow(at: indexpath, at: UITableViewScrollPosition.bottom, animated: animated)
            
        }
    }
    
    func show_FullStoryImage(gesture : UITapGestureRecognizer){
        
        let tappedImage = gesture.view as! UIImageView
        
        UUImageAvatarBrowser.showImage(forZoomView: self, withImage: tappedImage)
        
    }
    
    
    //----------------------------------------/-/
    //MARK:- UITableView Delegate Methods
    //MARK:-
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        
        return 1
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return aryUserChatData.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(index)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let image  : String = ((self.aryUserChatData[indexPath.row] as AnyObject).value(forKey: "image")! as? String)!
        
        let message  : String = ((self.aryUserChatData[indexPath.row] as AnyObject).value(forKey: "message")! as? String)!
        
        //let maxLabelSize: CGSize = CGSize(width: tv.frame.size.width/2+10, height: CGFloat(9999))
        let maxLabelSize: CGSize = CGSize(width: tv.frame.size.width-80, height: CGFloat(9999))
        let contentNSString = message as NSString
        let expectedLabelSize = contentNSString.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)], context: nil)
        
        if image.characters.count != 0 {
            return 140
        }else{
            return expectedLabelSize.size.height + 40
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        var strtime = String()
        aryData = NSMutableArray()
        aryData = aryUserChatData.mutableCopy() as! NSMutableArray
        
        cell = tv.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        print(aryUserChatData.object(at: indexPath.row))
        
        for view1: UIView in cell.contentView.subviews {
            if (view1 is UIImageView) {
                let imgView = (view1 as! UIImageView)
                imgView.removeFromSuperview()
            }
            if (view1 is UILabel) {
                let lbl = (view1 as! UILabel)
                lbl.removeFromSuperview()
            }
        }
        
        let message  : String = ((self.aryUserChatData[indexPath.row] as AnyObject).value(forKey: "message")! as? String)!
        
        let image  : String = ((self.aryUserChatData[indexPath.row] as AnyObject).value(forKey: "image")! as? String)!
        
        let senderName  : String = ((self.aryUserChatData[indexPath.row] as AnyObject).value(forKey: "sender")! as? String)!
        
        //let dateP = (self.aryUserChatData[indexPath.row] as AnyObject).value(forKey: "createdAt") as? Date
        let dateP = (self.aryUserChatData[indexPath.row] as AnyObject).value(forKey: "msgCreatedDate") as? Date
        if dateP == nil {
            strtime = "Just now"
        }else{
            //strtime = timeAgoSince(dateP!)
        }
        
        print(strtime)
        
        let lbl_msg = UILabel()
        let img_msg = UIImageView()
        let lbl_time = UILabel()
        lbl_time.font = lbl_time.font.withSize(12)
        lbl_time.textColor =  UIColor .gray
        //let maxLabelSize: CGSize = CGSize(width: tv.frame.size.width/2+10, height: CGFloat(9999))
        let maxLabelSize: CGSize = CGSize(width: tv.frame.size.width-80, height: CGFloat(9999))
        let contentNSString = message as NSString
        let expectedLabelSize = contentNSString.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)], context: nil)
        print("height\(expectedLabelSize.size.height)")
        lbl_msg.lineBreakMode = .byWordWrapping
        lbl_msg.text = message as String?
        lbl_msg.numberOfLines = 0
        lbl_msg.translatesAutoresizingMaskIntoConstraints = true
        
        let img = UIImageView()
        
        //-----------------View in my side --------------///
        
      // if senderName == nsud.value(forKey: "User_email_id")as! String {
//            //--------------Handel Image Chat--------------///
//            
        if senderName != nil {
        
            if image.characters.count != 0 {
//                
                img.frame = CGRect(x: CGFloat(self.tv.frame.size.width - 100 - 30), y: CGFloat(27), width: 120, height: 110)
                img.image = SWNinePatchImageFactory.createResizableNinePatchImage(UIImage(named:"right_chat.9")!)
               // img_msg.setImageWith(URL(string: image), usingActivityIndicatorStyle: .gray)
                img_msg.frame =  CGRect(x: CGFloat(self.tv.frame.size.width - 100 - 27), y: CGFloat(31), width: 107 , height: 102)
                img_msg.contentMode = .scaleToFill
                
                ////------ time Message frame -----------
                
                //lbl_time.frame = CGRect(x: tv.frame.size.width-img_msg.frame.size.width-28, y: 5, width: CGFloat(135), height: 15)
                lbl_time.frame = CGRect(x: 10, y: 5, width: kSCREEN_WIDTH-20, height: 20)
                lbl_time.text = strtime
                lbl_time.backgroundColor = colorClear
                lbl_time.textAlignment = .right
                
                //------SetMediaImage-----
                let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action:  #selector(ChatDetailVC.show_FullStoryImage))
                tapGesture.numberOfTapsRequired = 1;
                tapGesture.delegate = self
                img_msg.isUserInteractionEnabled = true
                img_msg.addGestureRecognizer(tapGesture)
                cell.contentView.addSubview(img)
                cell.contentView.addSubview(img_msg)
                cell.contentView.addSubview(lbl_time)
            }
                //--------------Handel Message Chat--------------///
                
            else{
                
                img.frame = CGRect(x: CGFloat(self.tv.frame.size.width - (expectedLabelSize.size.width) - 30), y: CGFloat(27), width: CGFloat((expectedLabelSize.size.width + 20)), height: CGFloat((expectedLabelSize.size.height + 10)))
                img.image = SWNinePatchImageFactory.createResizableNinePatchImage(UIImage(named:"right_chat.9")!)
                lbl_msg.frame = CGRect(x:tv.frame.size.width-expectedLabelSize.size.width - 27, y: CGFloat(27), width: CGFloat((expectedLabelSize.size.width)), height: CGFloat((expectedLabelSize.size.height)))
                lbl_msg.textAlignment = .right
                lbl_msg.center = img.center
                lbl_msg.textColor = UIColor.white
                lbl_msg.font = UIFont.systemFont(ofSize: 15.0)
                
                ////------ time Message frame -----------
                
                /*if (lbl_msg.text?.characters.count)! < 13 {
                 lbl_time.frame = CGRect(x: CGFloat(tv.frame.size.width - expectedLabelSize.size.width - 140), y: CGFloat(5), width: CGFloat(expectedLabelSize.size.width + 130), height: CGFloat(20))
                 lbl_time.textAlignment = .right
                 }
                 else {
                 lbl_time.frame = CGRect(x: CGFloat(tv.frame.size.width - expectedLabelSize.size.width - 30), y: CGFloat(5), width: CGFloat(expectedLabelSize.size.width + 30), height: CGFloat(20))
                 lbl_time.textAlignment = .left
                 }
                 lbl_time.text = strtime
                 lbl_time.backgroundColor = colorClear*/
                
                lbl_time.frame = CGRect(x: 10, y: 5, width: kSCREEN_WIDTH-20, height: 20)
                lbl_time.text = strtime
                lbl_time.backgroundColor = colorClear
                lbl_time.textAlignment = .right
                
                cell.contentView.addSubview(img)
                cell.contentView.addSubview(lbl_msg)
                cell.contentView.addSubview(lbl_time)
            }
       }
            //--------------View other  side --------------///
            
        else{
            
            //--------------Handel image Chat--------------///
            
            if image.characters.count != 0 {
                img.image = SWNinePatchImageFactory.createResizableNinePatchImage(UIImage(named:"left_chat.9")!)
               // img_msg.setImageWith(URL(string: image), usingActivityIndicatorStyle: .gray)
                img.frame = CGRect(x:10, y: CGFloat(27), width: CGFloat((100 + 20)), height: CGFloat((100 + 10)))
                img_msg.frame = CGRect(x:20, y: CGFloat(31), width: 105, height: 102 )
                img_msg.contentMode = .scaleToFill
                
                //                lbl_time.text = strtime
                //                lbl_time.frame = CGRect(x: 45, y: 5, width: CGFloat(160), height: 20)
                //                lbl_msg.textAlignment = .right
                //                lbl_time.backgroundColor = colorClear
                
                lbl_time.frame = CGRect(x: 10, y: 5, width: kSCREEN_WIDTH-20, height: 20)
                lbl_time.text = strtime
                lbl_time.backgroundColor = colorClear
                lbl_time.textAlignment = .left
                
                //------SetMediaImage-----
                let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action:  #selector(ChatDetailVC.show_FullStoryImage))
                tapGesture.numberOfTapsRequired = 1;
                tapGesture.delegate = self
                img_msg.isUserInteractionEnabled = true
                img_msg.addGestureRecognizer(tapGesture)
                cell.contentView.addSubview(img)
                cell.contentView.addSubview(img_msg)
                cell.contentView.addSubview(lbl_time)
            }
                
                //--------------Handel Message Chat--------------///
            else{
                
                img.image = SWNinePatchImageFactory.createResizableNinePatchImage(UIImage(named:"left_chat.9")!)
                img.frame = CGRect(x:10, y: CGFloat(27), width: CGFloat((expectedLabelSize.size.width + 20)), height: CGFloat((expectedLabelSize.size.height + 10)))
                lbl_msg.frame = CGRect(x:8, y: CGFloat(27), width: CGFloat((expectedLabelSize.size.width)), height: CGFloat((expectedLabelSize.size.height)))
                lbl_msg.textAlignment = .left
                lbl_msg.center = img.center
                lbl_msg.textColor = UIColor.gray
                lbl_msg.font = UIFont.systemFont(ofSize: 15.0)
                
                
                //------ time Message frame -----------
                /*if (lbl_msg.text?.characters.count)! < 13 {
                 lbl_time.frame = CGRect(x: 10, y: 5, width: CGFloat(expectedLabelSize.size.width + 130), height: 20)
                 lbl_time.textAlignment = .left
                 }
                 else {
                 lbl_time.frame = CGRect(x: 10, y: 5, width: CGFloat(expectedLabelSize.size.width + 20), height: 20)
                 lbl_time.textAlignment = .right
                 }
                 lbl_time.text = strtime
                 lbl_time.backgroundColor = colorClear*/
                
                lbl_time.frame = CGRect(x: 10, y: 5, width: kSCREEN_WIDTH-20, height: 20)
                lbl_time.text = strtime
                lbl_time.backgroundColor = colorClear
                lbl_time.textAlignment = .left
                
                cell.contentView.addSubview(img)
                cell.contentView.addSubview(lbl_msg)
                cell.contentView.addSubview(lbl_time)
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        //        if indexPath.row % 2 == 0 {
        //            cell.backgroundColor = colorYellow
        //        } else {
        //            cell.backgroundColor = colorCyan
        //        }
        
        return cell
    }
    
//    //MARK:------------MBProgressHUD-----------------
//    func webViewDidStartLoad() {
//        let HUD =  MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow, animated: true)
//        HUD?.labelText = "Loading..."
//        HUD?.dimBackground = true
//    }
//    
//    func webViewDidFinishLoad() {
//        _ =  MBProgressHUD.hide(for: UIApplication.shared.keyWindow, animated: true)
//    }
    
  //  }
}

//MARK: - Textfield Delegates
//MARK: -
extension ChatDetailVC: UITextFieldDelegate  {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textChanged(_ sender:UITextField) {
        if sender.tag == 101 {
            let strValue = txtForOfferPriceForInvoice?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            if strValue != "" {
                //self.btnSendOrCancelInvoice?.isEnabled = true
            } else {
               // self.btnSendOrCancelInvoice?.isEnabled = false
            }
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        
        if textField == txtForOfferPriceForInvoice {
            
            let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
            
            let components = string.components(separatedBy: inverseSet)
            
            let filtered = components.joined(separator: "")
            
            if filtered == string {
                return true
            } else {
                if string == "." {
                    let countdots = textField.text!.components(separatedBy:".").count - 1
                    if countdots == 0 {
                        return true
                    }else{
                        if countdots > 0 && string == "." {
                            return false
                        } else {
                            return true
                        }
                    }
                }else{
                    return false
                }
            }
        } else {
            return true
        }
    }
}

//MARK: - TextView Delegates
//MARK: -
extension ChatDetailVC: UITextViewDelegate {
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView == txtForDescForInvoice {
//            if (txtForDescForInvoice?.text == "DESCRIPTION / REMARK")
//            {
//                txtForDescForInvoice!.text = nil
//                txtForDescForInvoice!.textColor = colorBlack
//            }
//        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
//        if textView == txtForDescForInvoice {
//            if txtForDescForInvoice!.text.isEmpty
//            {
//                let strDesc = txtForDescForInvoice?.text.trimmingCharacters(in: .whitespacesAndNewlines)
//                if strDesc == "" {
//                    txtForDescForInvoice!.text = "DESCRIPTION / REMARK"
//                    txtForDescForInvoice!.textColor = colorGray
//                }
//            }
//        }
        textView.resignFirstResponder()
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentCharacterCount = textView.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
//        if textView == txtForDescForInvoice {
//            let newLength = currentCharacterCount + text.characters.count - range.length
//            return newLength <= 200
//        } else {
            let strMsg = self.commentTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            if strMsg != "" {
                btnSendMsg.isEnabled = true
            } else {
                self.commentTextView.text = ""
                btnSendMsg.isEnabled = false
            }
        //}
        return true
    }
}

