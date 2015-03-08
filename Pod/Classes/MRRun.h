//
//  MRRun.h
//  Pods
//
//  Created by Seppo on 3/8/15.
//
//

#import <Foundation/Foundation.h>
#include "mruby.h"

@interface MRRun : NSObject {
    mrb_state* mrb;
}

- (id)run:(NSString*)str;

@end