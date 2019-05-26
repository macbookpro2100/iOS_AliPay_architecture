//
//  DTRipperConstants.h
//  Pods
//
//  Created by 金秋成 on 2017/4/13.
//
//

#ifndef DTRipperConstants_h
#define DTRipperConstants_h

#if DEBUG
#define DTLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define DTLog(format, ...)
#endif




#endif /* DTRipperConstants_h */
