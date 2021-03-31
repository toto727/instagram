//
//  CommentViewController.swift
//  Instagram
//
//  Created by 永嶋瞬 on 2021/03/29.
//add

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    var postData: PostData!

    @IBOutlet weak var commentTextView: UITextView!
    
    @IBAction func commentButton(_ sender: Any) {
        print("コメント投稿ボタンが押されました")
        
        if let commentUserName = Auth.auth().currentUser?.displayName{
    
            var updateCommentTextArray:FieldValue
            if commentTextView.text == ""{
                print("コメント欄が空白です")
                SVProgressHUD.showError(withStatus: "コメントが入っていません")
                return
            }else{
                let comment = "\(commentUserName):\(self.commentTextView.text!)"
                updateCommentTextArray = FieldValue.arrayUnion([comment])
            }
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
                postRef.updateData(["comments":updateCommentTextArray])
            SVProgressHUD.showSuccess(withStatus: "コメント投稿しました")
        }
        
        // 画面を閉じてタブ画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func commentCanselButton(_ sender: Any) {
        // 画面を閉じてタブ画面に戻る
        print("コメントをキャンセルしました")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentTextView.layer.borderColor = UIColor.black.cgColor
        commentTextView.layer.borderWidth = 1
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
