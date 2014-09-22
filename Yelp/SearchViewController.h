//
//  SearchViewController.h
//  Yelp
//
//  Created by Jianbao Tao on 9/20/14.
//  Copyright (c) 2014 ___JimTao___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource, UITableViewDelegate>

-(void) createSearchBar;

@end
