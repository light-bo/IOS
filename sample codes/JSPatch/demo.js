var strURL = 'interface'
var k_NOTI_SHOWGOODSAMOUNT = 'notify message ...'

require('UIWebView, NSDictionary, NSNumber, AppUtils, NSNotificationCenter, NSString, UserDefaultsUtils')
defineClass('FlashsaleViewController', {
            // replace the addToShoppingCart_withWebView method
            addToShoppingCart_withWebView: function(dic, webView) {
   
   			//use self in the block must be use this statement
			var _self = self;
           
            self.shopHandler().executeAddWithEntity_path_success_failed(null, strURL, block('id obj', function(obj) {
                if(obj) {
                    AppUtils.showTextHUDWithView_Message(_self.view(), '加入购物车成功');
					
					//parse and string format, suggest use JS related functions
                    var tc = parseInt( UserDefaultsUtils.valueWithKey('totalCount') ) || 0;
                    ++tc;
                    
                    var totalCount = NSNumber.numberWithInteger(tc);
                    UserDefaultsUtils.saveValue_forKey(totalCount, 'totalCount');
                    
                    NSNotificationCenter.defaultCenter().postNotificationName_object(k_NOTI_SHOWGOODSAMOUNT, null);
                                                                                            
                    webView.stringByEvaluatingJavaScriptFromString('updateShoppingcartTotalCount('+tc+')');
                }
            }), block('id obj', function(obj) {
               
            

            }));
            
            }//defineClass
});



