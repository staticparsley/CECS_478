//
//  ChatVC.swift
//  f-Humanity
//
//  Created by Ahmed Al Sadiq on 5/3/17.
//  Copyright © 2017 Ahmed Al Sadiq. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import FirebaseDatabase
import MobileCoreServices
import FirebaseStorage
import FirebaseAuth
import MessageUI


class ChatVC: JSQMessagesViewController{

    @IBOutlet weak var logoutBtn: UIBarButtonItem!
    
    @IBAction func logoutBtn_Click(_ sender: Any) {
        
        //Creating a main storyboard instance
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //Instantiate Navigation Controller
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        
        //Get Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Set Navigation Controller
        appDelegate.window?.rootViewController = loginVC
    }
    
    var messages = [JSQMessage]()
    var avatarDict = [String: JSQMessagesAvatarImage]()
    var messageRef = MFMessageComposeViewController.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = FIRAuth.auth()?.currentUser
        {
            self.senderId = currentUser.uid
            
            if currentUser.isAnonymous == true
            {
                self.senderDisplayName = "anonymous"
            } else
            {
                self.senderDisplayName = "\(currentUser.displayName!)"
            }
            
        }
        
        observeMessages()
    }
    
    func observeUsers(_ id: String)
    {
        FIRDatabase.database().reference().child("users").child(id).observe(.value, with: {
            snapshot in
            if let dict = snapshot.value as? [String: AnyObject]
            {
                let avatarUrl = dict["profileUrl"] as! String
                
                self.setupAvatar(avatarUrl, messageId: id)
            }
        })
        
    }
    
    func setupAvatar(_ url: String, messageId: String)
    {
        if url != "" {
            let fileUrl = URL(string: url)
            let data = try? Data(contentsOf: fileUrl!)
            let image = UIImage(data: data!)
            let userImg = JSQMessagesAvatarImageFactory.avatarImage(with: image, diameter: 30)
            self.avatarDict[messageId] = userImg
            self.collectionView.reloadData()
            
        } else {
            avatarDict[messageId] = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "profileImage"), diameter: 30)
            collectionView.reloadData()
        }
        
    }
    
    func observeMessages() {
        messageRef.(.childAdded, with: { snapshot in
            // print(snapshot.value)
            if let dict = snapshot.value as? [String: AnyObject] {
                let mediaType = dict["MediaType"] as! String
                let senderId = dict["senderId"] as! String
                let senderName = dict["senderName"] as! String
                
                self.observeUsers(senderId)
                switch mediaType {
                    
                case "TEXT":
                    
                    let text = dict["text"] as! String
                    self.messages.append(JSQMessage(senderId: senderId, displayName: senderName, text: text))
                    
                default:
                    print("unknown data type")
                    
                }
                
                self.collectionView.reloadData()
                
            }
        })
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let newMessage = messageRef
        let messageData = ["text": text, "senderId": senderId, "senderName": senderDisplayName, "MediaType": "TEXT"]
        newMessage.setValue(messageData)
        self.finishSendingMessage()
    }
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        if message.senderId == self.senderId {
            
            return bubbleFactory!.outgoingMessagesBubbleImage(with: .orange)
        } else {
            
            return bubbleFactory!.incomingMessagesBubbleImage(with: .green)
            
        }
        
        
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = messages[indexPath.item]
        
        return avatarDict[message.senderId]
        //return JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "profileImage"), diameter: 30)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
