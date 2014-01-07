//
//  RefreshView.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-30.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import "RefreshView.h"
#import "XMLReader.h"
#import "MD5.h"
#import "S.h"
@implementation RefreshView
@synthesize info, connData, mode, cURL, mURL, loc;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self didLoad];
    }
    return self;
}

- (void)didLoad
{
    self.connData = [[NSMutableData alloc] init];
    float icoSize = self.frame.size.width * 0.5;
    UIImageView *logoimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*0.5-icoSize*0.5, self.frame.size.height*0.2, icoSize, icoSize)];
    logoimg.image = [UIImage imageNamed:@"ic_launcher-152.png"];
    info = [[UILabel alloc] initWithFrame:CGRectMake(0, logoimg.frame.origin.y + logoimg.frame.size.height, self.frame.size.width, 20)];
    [self infoShow:NSLocalizedString(@"PrepareUpdate", nil)];
    info.textColor = [UIColor blueColor];
    info.textAlignment = NSTextAlignmentCenter;
    [self addSubview:logoimg];
    [self addSubview:info];
}

- (void)startreload:(NSString*)URL ModeTag:(NSUInteger)mtag Local:(BOOL)local
{
    mode = mtag;
    cURL = URL;
    mURL = [NSString stringWithFormat:@"%@.yashi",[MD5 md5:URL]];
    loc = local;
    
    if (local) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        [fileManager changeCurrentDirectoryPath:[documentDirectory stringByExpandingTildeInPath]];
        NSString *path = [documentDirectory stringByAppendingPathComponent:mURL];
        if ([fileManager fileExistsAtPath:path]) {
            [self infoShow:NSLocalizedString(@"ReadLocal", nil)];
            [MobClick event:@"LoadLocal"];
            self.connData = [NSData dataWithContentsOfFile:path];
            [self connectionDidFinishLoading:nil];
        } else {
            [self startAsyConnection];
        }
    } else {
        [self startAsyConnection];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [self infoShow:NSLocalizedString(@"Retry", nil)];
        [self startAsyConnection];
    } else {
        [self infoShow:NSLocalizedString(@"CancelOperation", nil)];
        //NSArray *cinf = [NSArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:mode],cURL, nil];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"conok" object:cinf];
        [self exit];
    }
}
- (void)startAsyConnection
{
    [self infoShow:NSLocalizedString(@"WaitServer", nil)];
    //第一步：创建URL
    NSURL *url = [NSURL URLWithString:cURL];
    //第二步：创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    //第三步：发送请求
    [MobClick event:@"LoadWeb"];
    [NSURLConnection connectionWithRequest:request delegate:self];
    //接收到服务器回应
}
//服务器响应
- (void)connection:(NSURLConnection *)connection didReceiveReceiveResponse:(NSURLResponse *)response
{
    [self infoShow:NSLocalizedString(@"Downloading", nil)];
    self.connData = [[NSMutableData alloc] init];
}
//接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self infoShow:[NSString stringWithFormat:@"%@.",info.text]];
    [self.connData appendData:data];
}
//接收过程中出错
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [MobClick event:@"LoadWebError"];
    NSString *inf = [NSString stringWithFormat:NSLocalizedString(@"DownloadFailed_message", nil),[error localizedDescription]];
    [self infoShow:inf];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"DownloadFailed_title", nil) message:inf delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:NSLocalizedString(@"Retry", nil), nil];
    [alert show];
}
- (void)dataErr:(NSString*)errinfo
{
    NSString *inf = [NSString stringWithFormat:NSLocalizedString(@"InvalidData_message", nil),errinfo];
    [self infoShow:inf];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"InvalidData_title", nil) message:inf delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles: nil];
    [alert show];
}
//成功接收
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [MobClick event:@"LoadWebOK"];
    [self infoShow:[NSString stringWithFormat:NSLocalizedString(@"SuccessfullyReceivedData", nil),[self.connData length]]];
    NSString *str = [[NSString alloc] initWithData:self.connData encoding:NSUTF8StringEncoding];
    [self infoShow:[NSString stringWithFormat:NSLocalizedString(@"FormattingData", nil),[str length]]];
    NSDictionary *okdata = nil;
    
    [self infoShow:NSLocalizedString(@"TryXML", nil)];
    //将字符串xml转为字典
    NSError *xmlerr = nil;
    NSDictionary *dic = [XMLReader dictionaryForXMLString:str error:&xmlerr];
    if (xmlerr) {
        [self infoShow:[NSString stringWithFormat:NSLocalizedString(@"TryXMLFailed", nil),[xmlerr localizedDescription]]];
        [self infoShow:NSLocalizedString(@"TryJSON", nil)];
        //将json的Data转为字典
        NSError *jsonerr = nil;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:self.connData options:NSJSONReadingMutableContainers error:&jsonerr];
        if (jsonerr) {
            [self infoShow:[NSString stringWithFormat:NSLocalizedString(@"TryJSONFailed", nil),[jsonerr localizedDescription]]];
            [self dataErr:[NSString stringWithFormat:@"%@。%@。",[xmlerr localizedDescription],[jsonerr localizedDescription]]];
        } else {
            [MobClick event:@"ReadJSONok"];
            okdata = jsonDic;
        }
    } else {
        [MobClick event:@"ReadXMLok"];
        okdata = dic;
    }
    if ([okdata count] > 0) {
        [self readData:okdata];
    } else {
        [MobClick event:@"ReadError"];
        [self dataErr:NSLocalizedString(@"InternalParsingError", nil)];
    }
}



- (void)readData:(NSDictionary*)dataDic
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    [fileManager changeCurrentDirectoryPath:[documentDirectory stringByExpandingTildeInPath]];
    NSString *path = [documentDirectory stringByAppendingPathComponent:mURL];
    if ([fileManager fileExistsAtPath:path] && loc) {
        
    } else {
        [self infoShow:NSLocalizedString(@"SaveLocalCache", nil)];
        NSMutableData  *writer = [[NSMutableData alloc] init];
        [writer appendData:self.connData];
        [writer writeToFile:path atomically:YES];
    }
    [self infoShow:NSLocalizedString(@"ProcessingData", nil)];
    NSArray *cinf = [NSArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:mode],cURL,dataDic, nil];
    
    if (([cinf count] > 2) && ([[cinf objectAtIndex:0] unsignedIntegerValue] == 1))
    {
        [MobClick event:@"FormatData"];
        [[S s].allinfo removeAllObjects];
        //NSString *cURL = [cinf objectAtIndex:1];
        NSDictionary *info0 = [cinf objectAtIndex:2];
        NSDictionary *emoji = [info0 objectForKey:@"emoji"];
        NSArray *category = [emoji objectForKey:@"category"];
        
        //NSLog(@"category(%d)=%@",[category count], category);
        for (int icate = 0; icate < [category count]; icate++) {
            NSDictionary *cate = [category objectAtIndex:icate];
            NSString *name = [cate objectForKey:@"name"];
            NSArray *entry = [cate objectForKey:@"entry"];
            
            for (int iitem = 0; iitem < [entry count]; iitem++) {
                NSDictionary *item = [entry objectAtIndex:iitem];
                NSString *string = [[item objectForKey:@"string"] objectForKey:@"text"];
                NSString *nameT = [self removeFirstReturn:name removeT:YES];
                NSString *stringT = [self removeFirstReturn:string removeT:YES];
                if ([item count] == 3) {
                    NSString *note = [[item objectForKey:@"note"] objectForKey:@"text"];
                    NSString *noteT = [self removeFirstReturn:note removeT:YES];
                    NSArray *l = [NSArray arrayWithObjects:nameT,noteT,stringT, nil];
                    [[S s].allinfo addObject:l];
                } else {
                    NSArray *l = [NSArray arrayWithObjects:nameT,@"",stringT, nil];
                    [[S s].allinfo addObject:l];
                }
            }
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"conok" object:nil];
    [self exit];
}
- (NSString*)removeFirstReturn:(NSString*)str removeT:(BOOL)rT
{
//    NSLog(@"str=%@",str);
    NSMutableString *oldChar = [NSMutableString string];
    int n = 3;
    int n0 = 0;
    for (int i = 0; i < [str length]; i++) {
        NSString *nowChar = [str substringWithRange:NSMakeRange(i, 1)];
        if ([nowChar isEqualToString:@"\n"]) {
            n0++;
        }
    }
    if (n0 > 3) {
        n--;
    }
    for (int i = 0; i < [str length]; i++) {
        NSString *nowChar = [str substringWithRange:NSMakeRange(i, 1)];
        BOOL okey = YES;
        if ([nowChar isEqualToString:@"\n"] && n > 0) {
            okey = NO;
            [oldChar setString:nowChar];
            n--;
        }
        if ([nowChar isEqualToString:@"\t"]) {
            okey = NO;
            [oldChar setString:nowChar];
        }
        if ([nowChar isEqualToString:@"	"]) {
            okey = NO;
            [oldChar setString:nowChar];
        }
        if (okey) {
            NSMutableString *rstr = [NSMutableString stringWithString:[str substringFromIndex:i]];
//            NSString *delStr = [str substringToIndex:i];
//            NSMutableString *delStrM = [NSMutableString string];
//            int delStart = 0;
//            for (int j = [delStr length]-1; j >= 0; j--) {
//                NSString *nowDelStr = [delStr substringWithRange:NSMakeRange(j, 1)];
//                if ([nowDelStr isEqualToString:@"\t"]) {
//                    [delStrM setString:nowDelStr];
//                    delStart = 1;
//                } else if (delStart == 1) {
//                    break;
//                }
//            }
//            [rstr insertString:delStrM atIndex:0];
            return rstr;
        }
    }
    return @"";
}
- (void)exit
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [MobClick event:@"FormatDataOK"];
        [self removeFromSuperview];
    }];
}
- (void)infoShow:(NSString*)txt
{
//    NSLog(@"[网络]%@",txt);
    info.text = txt;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
