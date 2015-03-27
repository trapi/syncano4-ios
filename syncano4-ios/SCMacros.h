//
//  SCMacros.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//


/*
 * Singleton for .h file
 */

#define AUSINGLETON_FOR_CLASS(classname) \
+ (classname *)shared##classname


/*
 * Singleton for .m file
 */

#define AUSINGLETON_IMPL_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
}
