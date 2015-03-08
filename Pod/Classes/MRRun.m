//
//  MRRun.m
//  Pods
//
//  Created by Seppo on 3/8/15.
//
//

#import "MRRun.h"
#import "MRRange.h"
#include "mruby/compile.h"
#include "mruby/value.h"
#include "mruby/string.h"
#include "mruby/array.h"
#include "mruby/hash.h"
#include "mruby/range.h"
#include "mruby/error.h"

@implementation MRRun

- (MRRun*) init {
    if (self = [super init]) {
        mrb = mrb_open();
    }
    return self;
}

/*
 enum mrb_vtype {
 MRB_TT_DATA
 */
- (id) mrbToObject:(mrb_value)val {
    enum mrb_vtype t = mrb_type(val);
    switch (t) {
        case MRB_TT_FALSE:
            return [NSNumber numberWithBool:FALSE];

        case MRB_TT_TRUE:
            return [NSNumber numberWithBool:TRUE];

        case MRB_TT_UNDEF:
        case MRB_TT_FREE:
            return [NSNull null];

        case MRB_TT_FLOAT:
            return [NSNumber numberWithDouble:mrb_float(val)];

        case MRB_TT_FIXNUM:
            return [NSNumber numberWithLong:mrb_fixnum(val)];

        case MRB_TT_SYMBOL:
            return [self mrbToObject:mrb_sym2str(mrb, mrb_obj_to_sym(mrb, val))];

        case MRB_TT_STRING:
            return [NSString stringWithCString:mrb_str_to_cstr(mrb, val) encoding:NSUTF8StringEncoding];
            
        case MRB_TT_ARRAY: {
            mrb_int i, len = mrb_ary_len(mrb, val);
            NSMutableArray* array = [NSMutableArray arrayWithCapacity:len];
            for (i = 0; i < len; i++) {
                [array addObject:[self mrbToObject:mrb_ary_ref(mrb, val, i)]];
            }
            return [array copy];
        }

        case MRB_TT_HASH: {
            mrb_value keys = mrb_hash_keys(mrb, val);
            mrb_int i, len = mrb_ary_len(mrb, keys);
            NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:len];
            id key, value;
            mrb_value mrb_key;
            for (i = 0; i < len; i++) {
                mrb_key = mrb_ary_ref(mrb, keys, i);
                key = [self mrbToObject:mrb_key];
                value = [self mrbToObject:mrb_hash_get(mrb, val, mrb_key)];
                [dict setObject:value forKey:key];
            }
            return [dict copy];
        }

        case MRB_TT_RANGE: {
            MRRange* range = [MRRange new];
            range.begin = [self mrbToObject:mrb_range_ptr(val)->edges->beg];
            range.end = [self mrbToObject:mrb_range_ptr(val)->edges->end];
            return range;
        }

        case MRB_TT_DATA:
        case MRB_TT_FIBER:
        case MRB_TT_MAXDEFINE:
        case MRB_TT_FILE:
        case MRB_TT_ENV:
        case MRB_TT_EXCEPTION:
        case MRB_TT_OBJECT:
        case MRB_TT_CPTR:
        case MRB_TT_CLASS:
        case MRB_TT_MODULE:
        case MRB_TT_ICLASS:
        case MRB_TT_SCLASS:
        case MRB_TT_PROC:
        default:
            NSLog(@"Unknown type %d", t); break;
    }
    return [NSNull null];
}

- (id)run:(NSString*)str {
    const char *expr = [str UTF8String];
    size_t len = [str length];
    mrb_value val = mrb_load_nstring(mrb, expr, len);

    if (mrb->exc) {
        id i = [self mrbToObject:mrb_funcall(mrb, mrb_obj_value(mrb->exc), "inspect", 0)];
        id bt = [self mrbToObject:mrb_funcall(mrb, mrb_obj_value(mrb->exc), "backtrace", 0)];
        [NSException raise:i format:@"%@", bt];
    }
    return [self mrbToObject:val];
}

- (void) dealloc {
    mrb_close(mrb);
}

@end