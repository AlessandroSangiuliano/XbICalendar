//
//  XbICalendarTests.m
//

#import <XCTest/XCTest.h>
#import "XBICalendar.h"

@interface XbICalendarTests : XCTestCase

@end

@implementation XbICalendarTests



- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)test_FileMissing
//{
//    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//    NSString *path = [bundle pathForResource:@"test" ofType:@"ics"];
//    XbICFile * file = [[XbICFile alloc] initWithPathname:path];
//    
//    // Need To verify the file was opened
//    
//    [file read];
//    
//    [file save];
//    
//}
//
//- (void)test_2445_ics {
//    
//    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//    NSString *path = [bundle pathForResource:@"2445" ofType:@"ics"];
//    XbICFile * file = [[XbICFile alloc] initWithPathname:path];
//
//    [file read];
//    
//}

- (void)test_invite_ics {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"invite" ofType:@"ics"];
    
    XbICVCalendar * vCalendar =  [XbICVCalendar vCalendarFromFile:path];
    XCTAssertNotNil(vCalendar, @"Initialization");
    XCTAssertTrue([[vCalendar method] isEqualToString:@"REQUEST"], @"Expecting a REQUEST" );
    
    NSArray * events = [vCalendar componentsOfKind:ICAL_VEVENT_COMPONENT];
    XCTAssertEqual(events.count, 1, @"Expecting a single event");
    
    XbICVEvent * event = events[0];
    

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT: 0];
    [dateFormatter setDateFormat:@"yyyyMMdd'T'HHmmss'Z'"];
    
    NSDate * date = [event dateStart];
    NSDate * dateReference = [dateFormatter dateFromString:@"20140502T160000Z"];
    XCTAssertEqualWithAccuracy([date timeIntervalSinceReferenceDate],
                               [dateReference timeIntervalSinceReferenceDate],0.001,@"");
    
    date = [event dateEnd];
    dateReference = [dateFormatter dateFromString:@"20140502T170000Z"];
    XCTAssertEqualWithAccuracy([date timeIntervalSinceReferenceDate],
                               [dateReference timeIntervalSinceReferenceDate],0.001,@"");

    date = [event dateStamp];
    dateReference = [dateFormatter dateFromString:@"20140501T205541Z"];
    XCTAssertEqualWithAccuracy([date timeIntervalSinceReferenceDate],
                               [dateReference timeIntervalSinceReferenceDate],0.001,@"");
    date = [event dateCreated];
    dateReference = [dateFormatter dateFromString:@"20140501T205317Z"];
    XCTAssertEqualWithAccuracy([date timeIntervalSinceReferenceDate],
                               [dateReference timeIntervalSinceReferenceDate],0.001,@"");

    date = [event dateLastModified];
    dateReference = [dateFormatter dateFromString:@"20140501T205540Z"];
    XCTAssertEqualWithAccuracy([date timeIntervalSinceReferenceDate],
                               [dateReference timeIntervalSinceReferenceDate],0.001,@"");

    
    /*
     -(NSTimeZone *) timeZone;
     //-(XbICPerson *) organizer;
     -(NSString *) UID;
     -(NSArray *) Attendees;
     -(NSString *) location;
     -(NSNumber *) sequence;
     -(NSString *) status;
     -(NSString *) confirmed
     */
    NSLog(@"Exit");

}


@end