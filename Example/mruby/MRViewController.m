//
//  MRViewController.m
//  mruby
//
//  Created by Sebastian Waisbrot on 03/08/2015.
//  Copyright (c) 2014 Sebastian Waisbrot. All rights reserved.
//

#import "MRViewController.h"
#import "MRRun.h"

@interface MRViewController ()

@end

@implementation MRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    code.text = @"def myFunc\n\t1 + 2\nend\nmyFunc";
    response.text = @"";
    [code becomeFirstResponder];
}

- (IBAction)run {
    response.text = [[[MRRun new] run:code.text] description];
    [code resignFirstResponder];
}

@end