/*
  控件尺寸 
 */

// 1.Dock上条目的尺寸
#define kDockItemW 100  //Dock中Item的宽度
#define kDockItemH 80  //Dock中Item的高度

// 2.日志输出宏定义
#ifdef DEBUG
// 调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
// 发布状态
#define MyLog(...)
#endif

// 3.通知名称
// 城市改变的通知
#define kCityChangeNote @"city_change"
// 城市的key
#define kCityKey @"city"

// 4.全局背景色
#define kGlobalBg [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]]