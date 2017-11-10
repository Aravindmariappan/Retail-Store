//
//  SampleInputs.h
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#ifndef SampleInputs_h
#define SampleInputs_h

#define DefaultCart @{kCartID:@"123456789"}

#define CategoryElectronics @{kCategoryName:@"Electronics", kCategoryDecription:@"Electronic Goods", kCategoryID:@"111111"}
#define CategoryFurniture @{kCategoryName:@"Furniture",  kCategoryDecription:@"Furniture Goods",  kCategoryID:@"222222"}

#define ItemTable @{kItemName:@"Table" ,kItemDescription:@"Wooden Table", kItemID:@"2222221" ,kItemImageName:@"table", kItemPrice:@"100", kCategoryID:@"222222" }
#define ItemChair @{kItemName:@"Chair", kItemDescription:@"Wooden Chair", kItemID:@"2222222", kItemImageName:@"chair", kItemPrice:@"70", kCategoryID:@"222222"}
#define ItemAlmirah @{kItemName:@"Almirah",   kItemDescription:@"Wooden Almirah",   kItemID:@"2222223",   kItemImageName:@"almirah",   kItemPrice:@"75",   kCategoryID:@"222222"}
#define ItemMWOven @{kItemName:@"Microwave oven",  kItemDescription:@"Electroic Microwave oven",  kItemID:@"1111111",  kItemImageName:@"mwOwen",  kItemPrice:@"200",  kCategoryID:@"111111"}
#define ItemTV @{kItemName:@"Television", kItemDescription:@"Electroic Television", kItemID:@"1111112", kItemImageName:@"tv", kItemPrice:@"110", kCategoryID:@"111111"}
#define ItemVacuumCleaner @{kItemName:@"Vacuum Cleaner",  kItemDescription:@"Electronic Vacuum Cleaner",  kItemID:@"1111113", kItemImageName:@"vacuumCleaner",  kItemPrice:@"120",  kCategoryID:@"111111"}

#define SampleInputCategories @[CategoryFurniture,CategoryElectronics]
#define SampleInputItems @[ItemTV, ItemMWOven, ItemVacuumCleaner, ItemTable, ItemChair, ItemAlmirah]

#endif /* SampleInputs_h */
