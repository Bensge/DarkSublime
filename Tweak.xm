#import <AppKit/AppKit.h>
#import <objc/runtime.h>

@interface NSThemeFrame : NSView {
	NSButton *minimizeButton;
	NSButton *closeButton;
	NSButton *zoomButton;
}
- (NSWindow *)window;
- (float)roundedCornerRadius;
- (NSRect)_titlebarTitleRect;
- (void)_drawTitleStringIn:(NSRect)rect withColor:(NSColor *)color;
- (NSColor *)frameHighlightColor;
- (float)_titlebarHeight;
@end

@interface _NSThemeWidget : NSButton
@end

#define IVAR(varname) [self valueForKey:@#varname]



//////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface DarkSublimePlugin : NSObject
@end

@implementation DarkSublimePlugin
@end



void drawDarkBarInRect(NSThemeFrame *self,NSRect rect)
{
	NSRect windowRect = [[self window] frame];
	windowRect.origin = NSMakePoint(0, 0);
	float cornerRadius = [self roundedCornerRadius] - 1; //Quick hack to remove white pixel in top window corners
	[[NSBezierPath bezierPathWithRoundedRect:windowRect xRadius:cornerRadius yRadius:cornerRadius] addClip];
	[[NSBezierPath bezierPathWithRect:rect] addClip];

	CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
	CGContextSetBlendMode(context, kCGBlendModeNormal);
	//[[NSColor colorWithCalibratedRed:16.f/255.f green:17.f/255.f blue:17.f/255.f alpha:1.0] set];
	[[NSColor colorWithCalibratedRed:31.f/255.f green:31.f/255.f blue:31.f/255.f alpha:1.0] set];

	NSString *imagePath = [[NSBundle bundleForClass:DarkSublimePlugin.class] pathForResource:@"status-bar-background" ofType:@"png"];
	NSImage *image = [[NSImage alloc] initWithContentsOfFile:imagePath];
	[image drawInRect:rect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
}





%hook NSThemeFrame

- (void)_drawTitleStringIn:(NSRect)rect withColor:(NSColor *)color
{
	%orig(rect,[NSColor colorWithCalibratedRed:172.f/255.f green:172.f/255.f blue:172.f/255.f alpha:1.0]);
}


- (void)drawRect:(CGRect)rect
{
	%orig;
	/*
	for (_NSThemeWidget *b in @[IVAR(closeButton),IVAR(zoomButton),IVAR(minimizeButton)])
	{
		//NSLog(@"Button: %@",b);
		//Remove white line above buttons.
		//???
		//TODO
	}
	*/
}



- (void)_drawTitleBarBackgroundInClipRect:(CGRect)rect
{	
	//Let original implementation do the clipping
	%orig;
	//Draw our background
	drawDarkBarInRect(self,rect);
	//Redraw shortly, to fix window buttons' white line. This leads to an infinite loop of death.
	/*dispatch_async(dispatch_get_current_queue(),^{
		[self setNeedsDisplay:YES];
	});*/
}

%end


%hook _NSThemeWidget
- (void)drawRect:(CGRect)rect
{
	%orig;
	//Leads to infinite loop of death as well :(
	/*
	dispatch_async(dispatch_get_current_queue(),^{
		[self.superview setNeedsDisplay:YES];
	});
	*/
}
%end


//////////////////////////////////////////////////////////////////////////////////////////////////////////

%ctor {
	//NSLog(@"hi.");
	%init();
}