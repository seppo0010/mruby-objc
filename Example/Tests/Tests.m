//
//  mrubyTests.m
//  mrubyTests
//
//  Created by Sebastian Waisbrot on 03/08/2015.
//  Copyright (c) 2014 Sebastian Waisbrot. All rights reserved.
//

#import "MRRun.h"
#import "MRRange.h"

SpecBegin(InitialSpecs)

static MRRun* mr;
describe(@"mruby types", ^{
    beforeEach(^() {
        mr = [MRRun new];
    });

    it(@"int", ^{
        NSNumber* number = [mr run:@"1 + 2"];
        expect([number intValue]).to.equal(3);
    });

    it(@"true", ^{
        NSNumber* number = [mr run:@"true"];
        expect([number boolValue]).to.equal(TRUE);
    });

    it(@"false", ^{
        NSNumber* number = [mr run:@"false"];
        expect([number boolValue]).to.equal(FALSE);
    });

    it(@"string", ^{
        NSString* str = [mr run:@"'string'"];
        expect(str).to.equal(@"string");
    });

    it(@"symbol", ^{
        NSString* str = [mr run:@":symbol"];
        expect(str).to.equal(@"symbol");
    });

    it(@"double", ^{
        NSNumber* d = [mr run:@"1.23"];
        expect([d doubleValue]).to.equal(1.23);
    });

    it(@"array", ^{
        NSArray* d = [mr run:@"['val1', 'value2']"];
        expect(d).to.equal(@[@"val1", @"value2"]);
    });
    
    it(@"hash", ^{
        NSDictionary* d = [mr run:@"{key: 'value'}"];
        expect(d).to.equal(@{@"key": @"value"});
    });
    
    it(@"range", ^{
        MRRange* range = [mr run:@"1..100"];
        expect([range.begin intValue]).to.equal(1);
        expect([range.end intValue]).to.equal(100);
    });

    it(@"exception", ^{
        BOOL catched = FALSE;
        @try {
            [mr run:@"class MyException < Exception; end; raise MyException"];
        } @catch (NSException* exc) {
            catched = TRUE;
            expect([exc name]).to.contain(@"MyExceptionx");
        }
        expect(catched).to.equal(TRUE);
    });
});

SpecEnd
