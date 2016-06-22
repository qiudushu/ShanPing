

#import <Foundation/Foundation.h>


@interface XYWebFecth : NSObject <NSURLConnectionDataDelegate>
{
    id  receiveDelegate;
    SEL doneCallSelector;
    SEL errorCallSelector;
    NSMutableData * receiveData;
    NSURLConnection *connection;
}

+ (void) sendDateToServer:(NSDictionary *)_dic
             withDelegate:(id)_del
          successCallBack:(SEL)_succcall
                errorCall:(SEL)_errorCall;

+ (void) sendDateToServer:(NSString *)url
                   andDic:(NSDictionary *)_dic
             withDelegate:(id)_del
          successCallBack:(SEL)_succcall
                errorCall:(SEL)_errorCall;

+ (NSData *) sendSyncDateToServer:(NSDictionary *)_dic error:(NSError **)err;


- (id) initWithReceiveDelegate:(id) rDelegate
          withCallBackSelector:(SEL) callBackMethod
          withErrorBackSeletor:(SEL) errBackMethod;
- (void) fetchByPOSTWithURL:(NSString *) url PostData:(NSDictionary *) data;
- (NSData *) syncFetchByPOSTWithURL:(NSString *) url PostData:(NSDictionary *) data error:(NSError **)err;
- (void) fetchByGETWithURL:(NSString *)url PostData:(NSDictionary *)data;

@end
