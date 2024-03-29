/**

* 功能说明:     输入验证

* @author:      vivy <lizhizyan@qq.com>

* @time:        2015-9-25 16:15:30

* @version:     V1.1.0

* @使用方法:        

* <input class="required" type="text" data-valid="isNonEmpty||isEmail" data-error="email不能为空||邮箱格式不正确" id="" /> 

* 1、需要验证的元素都加上【required】样式

* 2、@data-valid     验证规则，验证多个规则中间用【||】隔开，更多验证规则，看rules和rule，后面遇到可继续增加

* 3、@data-error     规则对应的提示信息，一一对应

*

* @js调用方法：

* verifyCheck({

*   formId:'verifyCheck',       <验证formId内class为required的元素

*   onBlur:null,                <被验证元素失去焦点的回调函数>

*   onFocus:null,               <被验证元素获得焦点的回调函数>

*   onChange: null,             <被验证元值改变的回调函数>

*   successTip: true,           <验证通过是否提示>

*   resultTips:null,            <显示提示的方法，参数obj[当前元素],isRight[是否正确提示],value[提示信息]>

*   clearTips:null,             <清除提示的方法，参数obj[当前元素]>    
       
*   code:true                   <是否需要手机号码输入控制验证码及点击验证码倒计时,目前固定手机号码ID为phone,验证码两个标签id分别为time_box，resend,填写验证框id为code>

*   phone:true                  <改变手机号时是否控制验证码>
“email: /^([a-zA-Z0-9]+[_|_|.]?)[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|_|.]?)[a-zA-Z0-9]+.[a-zA-Z]{2,3}$/,” 
* })

* $("#submit-botton").click(function(){        <点击提交按钮时验证> 
*   if(!common.verify.btnClick()) return false;

* })

*

* 详细代码请看register.src.js

*/

eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('(k($){n h,F=Y,E;n j=k(a){a=$.2n(D.1e,a||{});E=a;u(1u D()).16(a)};k D(f){n g={R:/^1(3\\d|5[0-35-9]|8[2L-9]|2H)\\d{8}$/,2f:/^[\\1b-\\1t-1s-Z][\\1b-\\1t-1s-2x-9\\s-,-.]*$/,2r:/^[\\1b-\\1t-1s-Z][\\1b-\\1t-1s-2x-3d]*$/,2o:/^[\\2E-\\2C]+$/,2i:/^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|3w|(8[12])|3l)\\d{4}(((((19|20)((\\d{2}(0[13-9]|1[2w])(0[1-9]|[12]\\d|30))|(\\d{2}(0[2q]|1[1o])31)|(\\d{2}1o(0[1-9]|1\\d|2[0-8]))|(([24][26]|[2p][2g]|0[2c])29)))|3y)\\d{3}(\\d|X|x))|(((\\d{2}(0[13-9]|1[2w])(0[1-9]|[12]\\d|30))|(\\d{2}(0[2q]|1[1o])31)|(\\d{2}1o(0[1-9]|1\\d|2[0-8]))|(([24][26]|[2p][2g]|0[2c])29))\\d{3}))$/,2t:/^[0-9]*$/,s:\'\'};q.23={3v:k(a,b){b=b||" ";m(!a.B)u b},3A:k(a,b,c){c=c||" ";m(a.B<b)u c},2D:k(a,b,c){c=c||" ";m(a.B>b)u c},2K:k(a,b,c){c=c||" ";m(a!==$("#"+b).G())u c},3s:k(a,b,c){c=c||" ";n d=25(b.1h(\'-\')[0]);n e=25(b.1h(\'-\')[1]);m(a.B<d||a.B>e)u c},2B:k(a,b,c){c=c||" ";n r=j.1G(a);m(b>4)b=3;m(r<b)u c},2G:k(a,b){b=b||" ";m(!g.R.O(a))u b},2M:k(a,b){b=b||" ";m(!g.2f.O(a))u b},3b:k(a,b){b=b||" ";m(!g.2t.O(a))u b},3c:k(a,b){b=b||" ";m(!g.2r.O(a))u b},3e:k(a,b){b=b||" ";m(!g.2o.O(a))u b},3h:k(a,b){b=b||" ";m(!g.2i.O(a))u b},3j:k(c,d,e){d=d||" ";n a=$(e).w(\'T:3u\').B,b=$(e).w(\'.P\').B;m(!a&&!b)u d}}};D.1F={16:k(b){q.1H=b;q.2A=$(\'#\'+b.1r).w(\'.1D:1n\');n c=I;n d=q;m(b.2l){$("#17").18(k(){$("#N").M("Y s后可重发");d.15()})}$(\'1k\').P({3i:k(a){d.1I($(q));m(b.R&&$(q).y("1i")==="R")d.1O($(q));b.1P?b.1P($(q)):\'\'},V:k(a){b.1w?b.1w($(q)):$(q).C().w("1x.V").2e(".K").Q("v").2j(".K").H("v")&&$(q).C().w(".1y").H("v")&&$(q).C().w(".W").H("v")},2k:k(a){m(b.R&&$(q).y("1i")==="R")d.1O($(q))},2J:k(a){b.1z?b.1z($(q)):\'\'}},"#"+b.1r+" .1D:1n");$(\'1k\').P("18",".W",k(){n p=$(q).C(),T=p.w("T");T.G("").V()})},1I:k(a){n b=a.y(\'J-K\');m(b===1A)u I;n c=b.1h(\'||\');n d=a.y(\'J-1j\');m(d===1A)d="";n e=d.1h("||");n f=[];1B(n i=0;i<c.B;i++){f.1p({2s:c[i],22:e[i]})};u q.2v(a,f)},2v:k(a,b){n d=q;1B(n i=0,1q;1q=b[i++];){n e=1q.2s.1h(\':\');n f=1q.22;n g=e.3m();e.3n(a.G());e.1p(f);e.1p(a);n c=d.23[g].3r(a,e);m(c){E.1f?E.1f(a,I,c):j.1E(a,I,c);u I}}E.2d?(E.1f?E.1f(a,S):j.1E(a,S)):j.1v(a);u S},15:k(){n a=q;$("#17").M("发送验证码").v();$("#N").M("10 s后可重发").L();m(F===0){27(h);F=Y;n b=/^1([^28])\\d{9}$/;m(!b.O($("#R").G())){$("#N").M("发送验证码")}14{$("#17").L();$("#N").v()}u}$("#N").M(F+" s后可重发");F--;h=2a(k(){a.15()},2b)},1O:k(a){n b=q;m(a.G().B!=11){$("#17").v();$("#N").L();m(F===Y)$("#N").M("发送验证码");$("#1J").G("");q.1H.1K?q.1H.1K($("#1J")):j.1v($("#1J"));u}n c=/^1([^28])\\d{9}$/;m(!c.O(a.G()))u I;m(F===Y){$("#17").L();$("#N").v()}14{$("#17").v();$("#N").L()}}};j.1L=k(c){c=c||E.1r;n d=$("#"+c).w(\'.1D:1n\'),2F=q,U=S,t=1u D(),r=[];$.2I(d,k(a,b){U=t.1I($(b));m(U)r.1p(U)});m(d.B!==r.B)U=I;u U};j.1v=k(a){a.C().w(".1y").H("v");a.C().w(".K").H("v");a.Q("1M")};j.1E=k(a,b,c){a.C().w("1x.V").2e(".K").H("v").2j(".V").Q("v");a.C().w(".W").H("v");a.Q("1M");c=c||"";m(c.B>21)c="<2h>"+c+"</2h>";n o=a.C().w("1x.K");m(!b){o.H("1j");a.H("1M");m($.1N(a.G()).B>0)a.C().w(".W").Q("v")}14{a.C().w(".1y").Q("v")}o.M("").2N(c)};j.2O=k(a){n b=/[\\1b-\\2P]|[\\2Q-\\2R]|[\\2S-\\2T]|[\\2U-\\2V]|[\\2W-\\2X]|[\\2Y-\\2Z]|[\\32-\\33]|[\\34-\\36]|[\\37]|[\\38]/g;m(b.O(a))u a.1g(b).B;14 u 0};j.1G=k(a){n b=0;m(a.1g(/[a-z]/g)){b++}m(a.1g(/[A-Z]/g)){b++}m(a.1g(/[0-9]/g)){b++}m(a.1g(/(.[^a-39-3a-Z])/g)){b++}m(b>4){b=4}m(b===0)u I;u b};D.1e={1r:\'1d\',1P:1l,1w:1l,1z:1l,2d:S,1f:1l,1K:1l,2l:S,R:I};1Q.1d=$.1d=j})(1R);(k($){n f;n g=k(){u(1u D()).16()};k D(a){};D.1F={16:k(){n b=q;$(\'1k\').P({18:k(a){b.1L($(q))}},".3f:1n")},1L:k(a){n c=a.y(\'J-3g\');m(c===1A)u I;n d=$("#"+c),2m=!d.y("1S")?"":d.y("1S"),1a=!d.G()?"":d.G(),1c=d.y("1c")==="1T"?"M":"1T",b=d.C().w("b.3k"),1m=b.B===0?I:S;n s=d.y("1U")?" 1U=\'"+d.y("1U")+"\'":"";s+=d.y("J-K")?" J-K=\'"+d.y("J-K")+"\'":"";s+=d.y("J-1j")?" J-1j=\'"+d.y("J-1j")+"\'":"";s+=d.y("1V")?" 1V=\'"+d.y("1V")+"\'":"";n e=\'<T 3o 1c="\'+1c+\'" 1S="\'+2m+\'" 1a="\'+1a+\'" 1i="\'+c+\'"\'+s+\' />\';m(1c==="M"){m(1m)b.v();d.C().w(".3p-W.W").H("v");d.3q("1i").v();d.1W(e);a.H("1X")}14{d.2u("T").y("1i",c).G(1a).L();m(1m&&$.1N(1a)===""){d.2u("T").v();b.L()}d.3t();a.Q("1X")};$(\'1k\').P("18","#"+c,k(){$(q).C().w(".1X").18();m(1m&&$.1N($(q).G())===""){d.L();b.v()}d.V()})}};D.1e={};1Q.1Y=$.1Y=g})(1R);(k($){n b,F,E;n d=k(a){a=$.2n(D.1e,a||{});E=a;d.1Z();u(1u D()).16()};k D(a){};D.1F={16:k(){F=E.1C;q.15()},15:k(){n a=q;m(F===0){d.1Z();E.1W();F=E.1C;u}F--;E.2y(F);b=2a(k(){a.15()},2b)}};d.1Z=k(){27(b)};D.1e={1C:Y,3x:0,2y:k(c){},1W:k(){}};1Q.2z=$.2z=d})(1R);$(k(){1Y();1d();$(\'1k\').P("2k","#1T",k(){n t=$(q).G(),o=$(q).C().w(".3z");m(t.B>=6){o.L();n l=1d.1G(t);o.w("b i").Q("P");1B(n i=0;i<l;i++){o.w("b i").3B(i).H("P")}}14{o.v()}})});',62,224,'||||||||||||||||||||function||if|var|||this||||return|hide|find||attr|||length|parent|require|opt|timerC|val|addClass|false|data|valid|show|text|time_box|test|on|removeClass|phone|true|input|result|focus|close||60||||||else|_sendVerify|_init|verifyYz|click||value|u4E00|type|verifyCheck|defaults|resultTips|match|split|id|error|body|null|isB|visible|02|push|rule|formId|zA|u9FA5a|new|_clearTips|onFocus|label|blank|onChange|undefined|for|maxTime|required|_resultTips|prototype|pwdStrong|config|formValidator|verifyNo|clearTips|_click|v_error|trim|_change|onBlur|window|jQuery|class|password|name|placeholder|after|hidepwd|togglePwd|_clear|||errorMsg|rules|13579|parseInt||clearTimeout|01269|0229|setTimeout|1000|48|successTip|not|company|048|span|card|siblings|keyup|code|cls|extend|zh|2468|13578|uname|strategy|int|prev|_add|012|Z0|ing|countdown|getInputs|level|u9fa5|maxLength|u4e00|self|isPhone|47|each|change|isRepeat|025|isCompany|append|textChineseLength|u9FA5|u3001|u3002|uFF1A|uFF1F|u300A|u300F|u3010|u3015|u2013|u201D|||uFF01|uFF0E|u3008||u3009|u2026|uffe5|z0|9A|isInt|isUname|9_|isZh|showpwd|eye|isCard|blur|isChecked|placeTextB|91|shift|unshift|readonly|icon|removeAttr|apply|between|remove|checked|isNonEmpty|71|minTime|20000229|strength|minLength|eq'.split('|'),0,{}));