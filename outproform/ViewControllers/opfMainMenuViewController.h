//
//  opfMainMenuViewController.h
//  outproform
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <FacebookSDK/FacebookSDK.h>

@interface opfMainMenuViewController : UIViewController <FBLoginViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *viewScroll;
@property (weak, nonatomic) IBOutlet UIControl *viewContent;
@property (weak, nonatomic) IBOutlet FBLoginView *FBloggingOut;

@end
