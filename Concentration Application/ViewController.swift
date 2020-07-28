//  -----------------------------------------------------------------------------
//  ViewController.swift
//  Concentration Application
//
//  Created by Prince Pattanayanon on 04/07/2020.
//  Copyright © 2020 CAF Industries. All rights reserved.
//  -----------------------------------------------------------------------------


//  -----------------------------------------------------------------------------
import UIKit
//  -----------------------------------------------------------------------------
class ViewController: UIViewController {
    // --------------------------------------------------------------------------
    // Emoji Themes
    lazy var Theme = EmojiTheme.count.random
    
    var EmojiTheme :[[String]] = [
        ["🎩","💍","👑","👜","🦢","🍾","🥂","🏎","🛩","🚁","🛥","🏰","💵","💷","💎","💰","⚜️"],
        ["🍕","🌭","🍗","🍟","🥩","🥞","🍱","🍤","🥮","🍧","🥡"],
        ["⚽️","⚾️","🏐","🎱","🏀","🥎","🏉","🏈","🎾","🏓","🪁","🏏","🥊","🛹","🎣","🪂"],
        ["🎺","🎻","🎤","🎹","🎧","🎼","🎷","🪕","🎸","🥁"],
        ["🍏","🍎","🍊","🍋","🍐","🍌","🍓","🍇","🍉","🍈","🍒","🍑","🥭","🍍","🥥","🍆","🍅","🥝","🥑","🥦","🥬"],
        ["🏳️‍🌈","🇦🇺","🇧🇧","🇨🇦","🇨🇳","🇫🇷","🇩🇪","🇬🇧","🏴󠁧󠁢󠁥󠁮󠁧󠁿","🇺🇸","🇨🇭"],
        ["👮🏾‍♂️","👷🏾‍♂️","💂🏼‍♂️","🕵🏼‍♀️","👩🏽‍⚕️","👩🏼‍🌾","👩🏽‍🍳","👩🏻‍🎤","👨🏼‍🏭","👩🏽‍🔬","👩🏽‍🎨","🤵🏻","👨🏽‍🚀","👨🏽‍✈️"],
        ["😈","👻","☠️","🎃","🧟‍♂️","🧛‍♂️","🦇","🍫","🧙🏿‍♂️"],
        ["🦑","🐙","🦐","🦞","🦀","🐡","🐠","🐟","🐬","🐳","🐊","🦈","🐋","🦕","🦖"]
    ]
    
    //EmojiTheme.append(["🦓","🦏","🐃","🐏","🦍","🐪","🐂","🐑","🦧","🐫","🐄","🦙","🐘","🦒","🐎","🐐","🐕‍🦺","🐈","🦌","🐖","🦘","🦛","🐆"])
    
    var Emoji = [Int:String]()
    
    lazy var EmojiChoices = EmojiTheme[Theme]
    // --------------------------------------------------------------------------

    lazy var game = Concentration(numberOfCardsPairs: (CardsButton.count+1)/2)

    var FlipsCount = 0{
        didSet{
            FlipsCountLabel.text = "Flips : \(FlipsCount)"
        }
    }
    
    var Score = 0{
        didSet{
            ScoreLabel.text = "Score : \(Score)"
        }
    }
    
    @IBOutlet weak var FlipsCountLabel: UILabel!
    @IBOutlet var CardsButton: [UIButton]!
    @IBOutlet weak var ScoreLabel: UILabel!
    
    // --------------------------------------------------------------------------
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = CardsButton.firstIndex(of: sender){
            
            UIView.transition(with: CardsButton[cardNumber],
                              duration: 0.7,
                              options: [.transitionFlipFromRight],
                              animations: {self.game.chooseCard(at: cardNumber)})
            updateViewFromModel()
        }
    }
    
    
    // --------------------------------------------------------------------------
    @IBAction func newGame(_ sender: UIButton) {
        game = Concentration(numberOfCardsPairs: (CardsButton.count+1)/2)
        updateViewFromModel()
        EmojiChoices = EmojiTheme[Int(arc4random_uniform(UInt32(8)))]
    }
    // --------------------------------------------------------------------------
    func updateViewFromModel(){
        FlipsCount = game.FlipCount
        Score = game.Score
        
        for index in CardsButton.indices {
            
            let button = CardsButton[index]
            var card = game.cards[index]
            
            if (card.isFaceUp) {
                button.setTitle(Emoji(for:card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9961728454, green: 0.9902502894, blue: 1, alpha: 0.7981057363)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9978986382, green: 0.6313685179, blue: 0.1261521876, alpha: 1)
                if card.isMatched {
                    UIView.transition(with: button,
                                      duration: 0.7,
                                      options: [],
                                      animations: {
                                        button.backgroundColor = #colorLiteral(red: 0.9241966605, green: 1, blue: 0.8690645099, alpha: 0.1098833476)
                                        button.transform = CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
                                        
                                        },
                                      completion: {_ in
                                        button.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)})
                }
            }
            
        }
    }
    // --------------------------------------------------------------------------
    

    
    // --------------------------------------------------------------------------
    func Emoji(for card : Card) -> String{
        
        if Emoji[card.identifer] == nil, EmojiChoices.count > 0 {
            Emoji[card.identifer] = EmojiChoices.remove(at: EmojiChoices.count.random)
        }
        
        return Emoji[card.identifer] ?? "?"
    }
    // --------------------------------------------------------------------------

}

extension Int {
    var random:Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        }
        return 0
    }
}
//  -----------------------------------------------------------------------------

