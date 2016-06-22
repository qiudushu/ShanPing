

#import "XYWebFecth.h"


@interface XYWebFecth()

@end

@implementation XYWebFecth

- (id)initWithReceiveDelegate:(id)rDelegate withCallBackSelector:(SEL)callBackMethod withErrorBackSeletor:(SEL)errBackMethod
{
    self=[super init];
    if(self)
    {
        receiveDelegate=[rDelegate retain];
        doneCallSelector=callBackMethod;
        errorCallSelector=errBackMethod;
        receiveData=[[NSMutableData alloc] init];
    }
    return self;
}

+ (void) sendDateToServer:(NSDictionary *)_dic
             withDelegate:(id)_del
          successCallBack:(SEL)_succcall
                errorCall:(SEL)_errorCall
{
    [self sendDateToServer:MASTERSERVER
                    andDic:_dic
              withDelegate:_del
           successCallBack:_succcall
                 errorCall:_errorCall];
}

+ (void) sendDateToServer:(NSString *)url
                   andDic:(NSDictionary *)_dic
             withDelegate:(id)_del
          successCallBack:(SEL)_succcall
                errorCall:(SEL)_errorCall
{
    XYWebFecth *webTool=[[XYWebFecth alloc] initWithReceiveDelegate:_del
                                               withCallBackSelector:_succcall
                                               withErrorBackSeletor:_errorCall];
    NSString *serverUrl = url;
    if (serverUrl!=nil) {
        
        if(ISDEBUG) NSLog(@"Send data: %@",_dic);
        
        [webTool fetchByPOSTWithURL:serverUrl PostData:_dic];
    }
    
    [webTool release];
}

+ (NSData *) sendSyncDateToServer:(NSDictionary *)_dic error:(NSError **)err
{
    XYWebFecth *webTool=[[XYWebFecth alloc] init];
    NSString *serverUrl = MASTERSERVER;
    NSData *result;
    if (serverUrl!=nil) {
        
        if(ISDEBUG) NSLog(@"Send sync data: %@",_dic);
        
        result=[webTool syncFetchByPOSTWithURL:serverUrl PostData:_dic error:err];
        
        if(ISDEBUG) NSLog(@"recevie data: %@",[[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding]);
    }
    
    [webTool release];
    return  result;
}

//send post request to the url with data
- (void) fetchByPOSTWithURL:(NSString *) url PostData:(NSDictionary *) data
{
    NSString *requestUrlStr=[[NSString stringWithString:url] lowercaseString];
    NSURL *requestUrl=[NSURL URLWithString:requestUrlStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:requestUrl];
    if(data!=nil)
    {
        [request setHTTPMethod:@"POST"];
        
        NSMutableString * postData =[[NSMutableString alloc] init];
        for (int i=0; i<data.count; i++)
        {
            NSString *keyName=[[data allKeys] objectAtIndex:i];
            NSString *keyValue=[data objectForKey:keyName];
            [postData appendString:[NSString stringWithFormat:@"%@=%@",keyName,keyValue]];
            if(i+1!=data.count)
            {
                [postData appendString:@"&"];
            }
        }
        [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
        [postData release];
    }
    if(ISDEBUG) NSLog(@"request-->%@ \r\n %@",[request allHTTPHeaderFields],[[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]);

    connection=[[NSURLConnection alloc] initWithRequest:request
                                                   delegate:self
                                           startImmediately:YES];
    
    if(!connection)
    {
        NSDictionary * errorInfo=[NSDictionary dictionaryWithObjectsAndKeys:@"Creat connection failed" ,@"errorKey", nil];
        NSError *error=[NSError errorWithDomain:@"com.xzsz" code:100 userInfo:  errorInfo];
        
        [receiveDelegate performSelector:errorCallSelector withObject: error];
    }
}

- (NSData *)syncFetchByPOSTWithURL:(NSString *)url PostData:(NSDictionary *)data error:(NSError **)err
{
    NSString *requestUrlStr=[[NSString stringWithString:url] lowercaseString];
    NSURL *requestUrl=[NSURL URLWithString:requestUrlStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:requestUrl];
    if(data!=nil)
    {
        [request setHTTPMethod:@"POST"];
        
        NSMutableString * postData =[[NSMutableString alloc] init];
        for (int i=0; i<data.count; i++)
        {
            NSString *keyName=[[data allKeys] objectAtIndex:i];
            NSString *keyValue=[data objectForKey:keyName];
            [postData appendString:[NSString stringWithFormat:@"%@=%@",keyName,keyValue]];
            if(i+1!=data.count)
            {
                [postData appendString:@"&"];
            }
        }
        [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
        [postData release];
    }
    if(ISDEBUG) NSLog(@"request-->%@ \r\n %@",[request allHTTPHeaderFields],[[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]);
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:nil error:err];
    
//    NSData *returnData = [NSURLConnection sendAsynchronousRequest:<#(nonnull NSURLRequest *)#> queue:<#(nonnull NSOperationQueue *)#> completionHandler:<#^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError)handler#>];
    return returnData;
}

//send post request to the url with data
- (void) fetchByGETWithURL:(NSString *)url PostData:(NSDictionary *)data
{
    NSString *requestUrlStr=[[NSString stringWithString:url] lowercaseString];

    if(data!=nil)
    {
        requestUrlStr=[requestUrlStr stringByAppendingString:@"?"];
        for (int i=0;i<[data count];i++) {
            requestUrlStr=[requestUrlStr stringByAppendingString:[[data allKeys] objectAtIndex:i]];
            requestUrlStr=[requestUrlStr stringByAppendingString:@"="];
            requestUrlStr=[requestUrlStr stringByAppendingString:[[data allValues] objectAtIndex:i]];
            if(i+1!=[data count])
            {
                requestUrlStr=[requestUrlStr stringByAppendingString:@"&"];
            }
        }
    }
    NSURL *requestUrl=[NSURL URLWithString:requestUrlStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"GET"];
    if(ISDEBUG) NSLog(@"%@ \r\n %@",[request URL],[request allHTTPHeaderFields]);
    connection=[[NSURLConnection alloc] initWithRequest:request
                                               delegate:self
                                       startImmediately:YES];
    if(!connection)
    {
        NSDictionary * errorInfo=[NSDictionary dictionaryWithObjectsAndKeys:@"Creat connection failed" ,@"errorKey", nil];
        NSError *error=[NSError errorWithDomain:@"com.xzsz" code:100 userInfo:  errorInfo];
        
        [receiveDelegate performSelector:errorCallSelector withObject: error];
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receiveData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *reply=[[[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding] autorelease];
    if(ISDEBUG) NSLog(@"finish data:%@",reply);
    [receiveDelegate performSelector:doneCallSelector withObject: reply];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(ISDEBUG) NSLog(@"NSURLCOnnection ERROR!");
    [receiveDelegate performSelector:errorCallSelector withObject:error];
}

- (void) dealloc
{
    [receiveData release];
    [receiveDelegate release];
    receiveDelegate = nil;
    doneCallSelector = NULL;
    errorCallSelector = NULL;
    [connection release];
    [super dealloc];
}
@end
