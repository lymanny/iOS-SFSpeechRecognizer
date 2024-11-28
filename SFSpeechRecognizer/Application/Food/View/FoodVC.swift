//
//  FoodVC.swift
//  SFSpeechRecognizer
//
//  Created by lymanny on 26/11/24.
//

import UIKit

class FoodVC: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties & Variable
    var foodVM = FoodVM()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
    }
    
    //MARK: - @IBAction
    @IBAction func voiceClick(_ sender: Any) {
        addFeedbackGenerator {
            if let voiceSearchVC = UIStoryboard(name: "VoiceSearchSB", bundle: nil).instantiateViewController(withIdentifier: "VoiceSearchVC") as? VoiceSearchVC {
                voiceSearchVC.onRecognitionComplete = { recognizedText in
                    self.foodVM.search(query: recognizedText)
                    self.tableView.reloadData()
                }
                self.present(voiceSearchVC, animated: true)
            }
        }
    }
    
    //MARK: - Function
    func setupData() {
        foodVM.getFoodData()
    }
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension FoodVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foodVM.filteredItems.count > 0 ? foodVM.filteredItems.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if foodVM.filteredItems.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as! FoodCell
            cell.configData(data: foodVM.filteredItems[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataCell") as! NoDataCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        foodVM.filteredItems.count > 0 ? UITableView.automaticDimension : UIScreen.main.bounds.height
    }
    
}
