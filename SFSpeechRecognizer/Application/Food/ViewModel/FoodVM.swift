//
//  FoodVM.swift
//  SFSpeechRecognizer
//
//  Created by lymanny on 26/11/24.
//

class FoodVM {
    
    //MARK: - Variables
    private var allItems: [FoodItem] = []
    var filteredItems: [FoodItem] = []
    
    //MARK: - Function
    func getFoodData() {
        allItems = [
            FoodItem(image: "bossam", name: "보쌈", price: 15),
            FoodItem(image: "naengmyeon", name: "냉면", price: 5),
            FoodItem(image: "budaejjigae", name: "부대찌개", price: 15),
            FoodItem(image: "burger", name: "Burger", price: 5),
            FoodItem(image: "chicken", name: "Chicken", price: 10),
            FoodItem(image: "pizza", name: "Pizza", price: 10),
            FoodItem(image: "spaghetti", name: "Spaghetti", price: 10),
        ]
        filteredItems = allItems
    }

    func search(query: String) {
        filteredItems = allItems.filter { query.lowercased().contains($0.name.lowercased()) }
    }
    
}
