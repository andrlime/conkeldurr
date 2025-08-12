// This file was auto-generated. DO NOT modify this file by hand.
// Generated on 2025-08-11


export const DATASET_NAME: string = "Supplier List";
export let max_items_per_page: number = 12;

export interface Supplier {
	supplier_id: string;
	name: string;
	city: string;
	lead_time_days: number;
	contact_email: string;
};
     
export const suppliers: Array<Supplier> = [
	{ supplier_id: "S-01", name: "FarmFresh Produce", city: "Springfield", lead_time_days: 2., contact_email: "orders@farmfresh.example" },
	{ supplier_id: "S-02", name: "Daily Dairy", city: "Oakridge", lead_time_days: 3., contact_email: "sales@dailydairy.example" },
	{ supplier_id: "S-03", name: "Grain & Bake", city: "Riverside", lead_time_days: 4., contact_email: "hello@grainbake.example" },
	{ supplier_id: "S-04", name: "Roast Roastery", city: "Lakeview", lead_time_days: 2., contact_email: "team@roastroastery.example" }
];
