//
//  ContentViewController.h
//  Kelu
//
//  Created by Anil Chopra on 02/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentTableViewCell.h"

@interface ContentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ContentTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
