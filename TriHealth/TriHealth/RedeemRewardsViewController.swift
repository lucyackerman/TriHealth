//
//  RedeemRewardsViewController.swift
//  TriHealth
//
//  Created by Tembi Karagianes on 5/11/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit

class RedeemRewardsViewController: UIViewController {
    
    //variables
    let jokeArray = ["I went to buy some camouflage trousers the other day, but I couldn’t find any.","The first computer dates back to Adam and Eve. It was an Apple with limited memory, just one byte. And then everything crashed.", "My dad died when we couldn't remember his blood type. As he died, he kept insisting for us to \"be positive,\" but it\'s hard without him.", "I just found out I'm colorblind. The diagnosis came completely out of the purple.", "The future, the present and the past walked into a bar. Things got a little tense.","Just burned 2,000 calories. That's the last time I leave brownies in the oven while I nap.","I was addicted to the hokey pokey... but thankfully, I turned myself around.","To write with a broken pencil is pointless.","For Halloween we dressed up as almonds. Everyone could tell we were nuts.","Did you hear about the kidnapping at school? It's okay. He woke up.","With great reflexes comes great response ability.","R.I.P boiled water. You will be mist.","I ordered 2000 lbs. of chinese soup. It was Won Ton.","I can't believe I got fired from the calendar factory. All I did was take a day off.","I used to be addicted to soap, but I'm clean now.","I wasn't originally going to get a brain transplant, but then I changed my mind.","I'm reading a book about anti-gravity. It's impossible to put down.","What do you call a cow during an earthquake? A milkshake."]
    
    //outlet
    @IBOutlet var textLabel: UITextView!
    
    //actions
    @IBAction func backToRewards(_ sender: UIButton){
        openRewards()
    }
    
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()
        let number = Int(arc4random_uniform(UInt32(jokeArray.count)))
        self.textLabel.text = jokeArray[number]
    }
    //NAVIGATION
    func openRewards()
    {
        //segues to rewards page
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rewardsVC:RewardsViewController = storyboard.instantiateViewController(withIdentifier: "rewards") as! RewardsViewController
        self.present(rewardsVC, animated: true, completion: nil)
    }

}
