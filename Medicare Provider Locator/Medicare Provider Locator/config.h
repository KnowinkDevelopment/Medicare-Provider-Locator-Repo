//
//  config.h
//  KPEnterpriseDemo
//
//  Created by Steve Suranie on 7/1/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#ifndef KPEnterpriseDemo_config_h
#define KPEnterpriseDemo_config_h

#define MPL_PURPLE [UIColor colorWithRed:101.0f/255.0f green:38.0f/255.0f blue:228.0f/255.0f alpha:1.0]
#define MPL_LIGHTBLUE [UIColor colorWithRed:230.0f/255.0f green:238.0f/255.0f blue:250.0f/255.0f alpha:1.0]
#define MPL_BRIGHT_BLUE [UIColor colorWithRed:0.0f/255.0f green:174.0f/255.0f blue:239.0f/255.0f alpha:1.0]
#define MPL_ORANGE [UIColor colorWithRed:255.0f/255.0f green:129.0f/255.0f blue:0.0f/255.0f alpha:1.0]
#define MPL_BLUE [UIColor colorWithRed:2.0f/255.0f green:87.0f/255.0f blue:147.0f/255.0f alpha:1.0]
#define MPL_LIGHTGRAY [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0]

//the iOS of the device
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/*supplier types*/
#define SUPPLIER_TYPES [NSDictionary dictionaryWithObjectsAndKeys: @"Oxygen Supplies and Equipment", @"oxygen_supplies_and_equipment", @"Mail-Order Diabetic Supplies", @"mail_order_diabetic_supplies", @"Enteral Nutrients, Equipment and Supplies", @"enteral_nutrients_equipment_and_supplies", @"CPAP Devices, Respiratory Assist Devices, and Related Supplies and Accessories", @"cpap_devices_respiratory_assist_devices_and_related_supplies_and_accessories", @"Hospital Beds and Related Accessories", @"hospital_beds_and_related_accessories", @"Negative Pressure Wound Therapy Pumps and Related Supplies and Accessories", @"negative_pressure_wound_therapy_pumps_and_related_supplies_and_accessories", @"Walkers and Related Accessories", @"walkers_and_related_accessories", @"Support Surfaces (Group 2 mattresses and overlays)", @"support_surfaces_group_2_mattresses_and_overlays", @"Standard (Power & Manual) Wheelchairs, Scooters, and Related Accessories", @"standard_power_manual_wheelchairs_scooters_and_related_accessories", @"External Infusion Pumps and Supplies", @"external_infusion_pumps_and_supplies", @"General Home Equipment and Related Supplies and Accessories", @"general_home_equipment_and_related_supplies_and_accessories", @"Respiratory Equipment and Related Supplies and Accessories", @"respiratory_equipment_related_supplies_and_accessories", @"Standard Mobility Equipment and Related Accessories", @"standard_mobility_equipment_and_related_accessories", @"Automatic External Defibrillators (AEDS)", @"automatic_external_defibrillators_aeds", @"Commodes, Urinals, & Bedpans", @"commodes_urinals_bedpans", @"Continuous Passive Motion (CPM) Devices", @"continuous_passive_motion_cpm_devices", @"Dynamic Splints", @"dynamic_splints", @"Blood Glucose Monitors & Supplies: Non-Mail Order", @"blood_glucose_monitors_supplies_non_mail_order", @"Blood Glucose Monitors & Supplies: Mail Order", @"blood_glucose_monitors_supplies_mail_order", @"Blood Glucose Monitors: Mail Order", @"blood_glucose_monitors_mail_order", @"Gastric Suction Pumps", @"gastric_suction_pumps", @"Heat & Cold Applications", @"heat_cold_applications", @"Hospital Beds: Electric", @"hospital_beds_electric", @"Hospital Beds: Total Electric & Pediatric", @"hospital_beds_total_electric_pediatric", @"Hospital Beds: Manual", @"hospital_beds_manual", @"Hospital Beds: Manual & Pediatric", @"hospital_beds_manual_pediatric", @"Infrared Heating Pad Systems", @"infrared_heating_pad_systems", @"Infusion Pumps & Supplies: External Infusion", @"infusion_pumps_supplies_external_infusion", @"Infusion Pumps: Implantable & Uninterrupted", @"infusion_pumps_implantable_and_uninterrupted", @"Infusion Pumps & Supplies: Insulin Infusion", @"infusion_pumps_supplies_insulin_infusion", @"Infusion Pumps & Supplies: Implanted Infusion", @"infusion_pumps_supplies_implanted_infusion", @"Negative Pressure Wound Therapy Pumps & Supplies", @"negative_pressure_wound_therapy_pumps_supplies", @"Neuromuscular Electrical Stimulators (NMES)", @"neuromuscular_electrical_stimulators_nmes", @"Osteogenesis Stimulators", @"osteogenesis_stimulators", @"Pneumatic Compression Devices", @"pneumatic_compression_devices", @"Speech Generating Devices", @"speech_generating_devices", @"Support Surfaces: Pressure Reducing Beds, Mattresses, Overlays, & Pads", @"support_surfaces_pressure_reducing_beds_mattresses_overlays_pads", @"Support Surfaces (e.g. Air Fluidized bed)", @"support_surfaces", @"Traction Equipment", @"traction_equipment", @"Transcutaneous Electrical Nerve Stimulators (TENS) Units", @"transcutaneous_electrical_nerve_stimulators_tens_units", @"Ultraviolet Light Devices", @"ultraviolet_light_devices", @"Home Dialysis Equipment & Supplies", @"home_dialysis_equipment_supplies", @"Hemodialysis Equipment & Supplies", @"hemodialysis_equipment_supplies", @"Canes & Crutches", @"canes_crutches", @"Patient Lifts", @"patient_lifts", @"Power Operated Vehicles (Scooters)", @"power_operated_vehicles_scooters", @"Seat Lift Mechanisms", @"seat_lift_mechanisms", @"Walkers", @"walkers", @"Wheelchairs & Accessories: Standard Manual", @"wheelchairs_accessories_standard_manual", @"Wheelchairs & Accessories: Standard Manual (e.g. Pediatrics)", @"wheelchairs_accessories_standard_manual_pediatrics", @"Wheelchairs & Accessories: Standard Power", @"wheelchairs_accessories_standard_power", @"Wheelchairs & Accessories: Standard Power (e.g. Pediatrics and custom cushions)", @"wheelchairs_accessories_standard_power_pediatrics", @"Wheelchairs & Accessories: Complex Rehabilitative Manual", @"wheelchairs_accessories_complex_rehabilitative_manual", @"Wheelchairs & Accessories: Complex Rehabilitative Power", @"wheelchairs_accessories_complex_rehabilitative_power", @"Wheelchairs & Accessories: Complex Rehabilitative Power (e.g. Group 3, Group 4, Group 5)", @"wheelchairs_accessories_complex_rehabilitative_power_e_g_group_3_group_4_group_5", @"Wheelchair Seating/Cushions", @"wheelchair_seating_cushions", @"Wheelchair Seating/Cushions (e.g. skin protecting seat cushions)", @"wheelchair_seating_cushions_skin_protecting", @"Orthoses: Custom Fabricated", @"orthoses_custom_fabricated", @"Orthoses: Prefabricated", @"orthoses_prefabricated", @"Orthoses: Off-the-Shelf", @"orthoses_off_the_shelf", @"Breast Prostheses & Accessories", @"breast_prostheses_accessories", @"Eye Protheses",  @"eye_prostheses",   @"Facial Prostheses", @"facial_prostheses", @"High Frequency Chest Wall Oscillation Devices", @"high_frequency_chest_wall_oscillation_hfcwo_devices", @"Intermittent Positive Pressure Breathing Devices", @"intermittent_positive_pressure_breathing_ippb_devices", @"Intrapulmonary Percussive Ventilation Devices", @"intrapulmonary_percussive_ventilation_devices",  @"Invasive Mechanical Ventilation",  @"invasive_mechanical_ventilation", @"Limb Prostheses", @"limb_prostheses",  @"Mechanical In-Exsufflation Devices", @"mechanical_in_exsufflation_devices ", @"Nebulizer Equipment Supplies", @"nebulizer_equipment_supplies", @"Nebulizer Equipment Ultrasonic and Controlled Dose", @"nebulizer_equipment_ultrasonic_and_controlled_dose ", @"Neurostimulators", @"neurostimulators ",  @"Ocular Prostheses", @"ocular_prostheses", @"Ostomy Supplies", @"ostomy_supplies", @"Oxygen Equipment Supplies", @"oxygen_equipment_supplies", @"Parenteral Nutrients Equipment Supplies", @"parenteral_nutrients_equipment_supplies", @"Prosthetic Lenses Conventional Contact Lenses", @"prosthetic_lenses_conventional_contact_lenses", @"Prosthetic Lenses Conventional Eyeglasses", @"prosthetic_lenses_conventional_eyeglasses ", @"Prosthetic Lenses Prosthetic Cataract Lenses", @"prosthetic_lenses_prosthetic_cataract_lenses ", @"Respiratory Suction Pumps", @"respiratory_suction_pumps ", @"Somatic Prostheses", @"somatic_prostheses", @"Surgical Dressings",  @"surgical_dressings", @"Tracheostomy Supplies", @"tracheostomy_supplies", @"Urological Supplies", @"urological_supplies",  @"Ventilators Accessories Supplies", @"ventilators_accessories_supplies ",  @"Voice Prosthetics", @"voice_prosthetics", nil]

#define ARR_STATE_NAMES [NSArray arrayWithObjects:@"", @"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", @"Wisconsin", @"Wyoming", nil]

#define ARR_STATE_ABBREVIATIONS [NSArray arrayWithObjects:@"", @"AL", @"AK", @"AZ", @"AR", @"CA", @"CO", @"CT", @"DE", @"FL", @"GA", @"HI", @"ID", @"IL", @"IN", @"IA", @"KS", @"KY", @"LA", @"ME", @"MD", @"MA", @"MI", @"MN", @"MS", @"MO", @"MT", @"NE", @"NV", @"NH", @"NJ", @"NM", @"NY", @"NC", @"ND", @"OH", @"OK", @"OR", @"PA", @"RI", @"SC", @"SD", @"TN", @"TX", @"UT", @"VT", @"VA", @"WA", @"WV", @"WI", @"WY", nil]

#define ARR_ICON_BUTTONS [NSArray arrayWithObjects:@"Map", @"Fav", @"Comment", @"About", @"Web", nil]

#define kDocumentsDirectory [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]

/*SODA API*/

#define kBaseURL @"https://data.medicare.gov/resource/pqp8-xrjv.json"


//#define ARR_SUPPLIER_DEMOGRAPHIC_FIELDS [NSArray arrayWithObjects:@"company_name", @"dba_name", @"address", @"address_2", @"city", @"state", @"zip", @"zip_plus_4", @"phone", nil]

//append ?field=value

/*type defs*/

typedef enum {
    SUPPLIER_PICKER,
    STATE_PICKER,
    
} SEARCH_FIELD_PICKER_TYPE;

typedef enum {
    MAP_ICON,
    FAVORITE_ICON,
    WEB_ICON,
    ABOUT_ICON,
    COMMENT_ICON,
    
} DETAIL_BUTTON_ICON_TYPE;

typedef enum {
    SEARCH_FORM_HELP,
    
} HELP_DISPLAY_TYPE;

#endif
