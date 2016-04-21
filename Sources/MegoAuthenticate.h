//
//  Authenticate.h
//  DummyFramework
//
//  Created by David-iphone on 12/06/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/*!
 * @discussion This Protocol  give callback to Developer if any network or connection errors are occurs .
 * @param It is use to know error type, if Develper miss some Keys Put in .plist.
 @remark Give Error type .
 * @result return Error type
 *
 */

@protocol MegoAuthErrorHandler

/*!
 * @discussion This Deleagte method  give callback to Developer if any network or connection errors are occurs .
 * @param It is use to know error type, if Develper miss some Keys Put in .plist.
 @remark Give Error type .
 * @result return Error type
 *
 */

-(void)MegoAuthErrorHandler:(NSError*)ErrorDescription;

@end


/*!
 @class MegoAuthenticate
 
 @discussion Use this to configure application according to AppID,SecretKEYand DevID and fetch all data from server configured on CMS Panel */


@interface MegoAuthenticate : NSObject

@property (strong, nonatomic) id <MegoAuthErrorHandler> delegate;

/*!
 * @discussion This method  give callback(Send notification) to other Megoframewoks give dynamic Urls and Authentication keys.
 * @param Use to Authenticate and give access to use MegoFrameworks.
  @remark It is must use by Developers to aceess and use other frameworks of Mego .
 * @result Authenticate MegoFrameworks
 *
 */

-(void)Intialize;

/*!
 * @discussion This method
 * @param Use to Authenticate and give access to use MegoFrameworks.
 @remark It is must use by Developers to aceess and use other frameworks of Mego .
 * @result Authenticate MegoFrameworks
 *
 */
-(void)getHistory:(UINavigationController*)navigation;


@end
