// This file was auto-generated. DO NOT modify this file by hand.
// Generated on 2025-08-11


export const DATASET_NAME: string = "Lunch Menu";
export const SALES_TAX_RATE: number = 0.1025;
export let max_items_per_page: number = 12;

export interface MenuItem {
	id: string;
	name: string;
	category: string;
	price_usd: number;
	calories: number;
};
     
export const menu: Array<MenuItem> = [
	{ id: "M-101", name: "Margherita Pizza", category: "Entree", price_usd: 10.5, calories: 720. },
	{ id: "M-102", name: "Grilled Chicken Salad", category: "Entree", price_usd: 9., calories: 410. },
	{ id: "M-103", name: "Tomato Soup", category: "Starter", price_usd: 4.5, calories: 180. },
	{ id: "M-104", name: "Garlic Bread", category: "Side", price_usd: 3., calories: 250. },
	{ id: "M-105", name: "Cold Brew", category: "Coffee", price_usd: 3.5, calories: 5. },
	{ id: "M-106", name: "Blueberry Muffin", category: "Dessert", price_usd: 2.8, calories: 390. }
];
