//
//  FDViewController.m
//  FindDomainObjc
//
//  Created by Computer on 01/08/2026.
//  Copyright (c) 2026 Computer. All rights reserved.
//

#import "FDViewController.h"
#import "FindDomainObjc.h"

@interface FDViewController ()

@end

@implementation FDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
    
    FindDomainConfig *config = [[FindDomainConfig alloc] init];
    config.checkUrls =  @[@"https://raw.githubusercontent.com/IFPLLIMIT/Kingfisher/refs/heads/master/README.md",@"https://pastebin.com/raw/M9Y6kLv3",@"https://hackmd.io/@IFPLLIMIT/HJWKWzbslx"];
    config.domainPrefix = @"KINGFISHERSTART";
    config.domainSuffix = @"ENDRUPEE";
    config.domainSeparator = @"LIMITED";
    [[FindDomainObjc shared] configureWithConfig:config];
    
    [[FindDomainObjc shared] checkConnectivityWithCurrentUrl:@"ifplrupee.top" success:^(NSString * _Nonnull resultUrl) {
        NSLog(@"%@",resultUrl);
        } failure:^{
            
        }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
