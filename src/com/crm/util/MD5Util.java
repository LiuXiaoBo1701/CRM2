package com.crm.util;

import java.security.MessageDigest;

public class MD5Util {

	public static String getPwd(String pwd) {
		try {
			// 创建加密对象
			MessageDigest digest = MessageDigest.getInstance("md5");
			// 调用加密对象的方法，加密的动作已经完成
			byte[] bs = digest.digest(pwd.getBytes());
			// 接下来，我们要对加密后的结果，进行优化，按照Oracle的优化思路走
			// Oracle的优化思路：
			// 第一步，将数据全部转换成正数：
			String hexString = "";
			for (byte b : bs) { 
				// 第一步，将数据全部转换成正数：
				int temp = b & 255;
				// 第二步，将所有的数据转换成16进制的形式
				// 注意：转换的时候注意if正数>=0&&<16，那么如果使用Integer.toHexString()，可能会造成缺少位数
				// 因此，需要对temp进行判断
				if (temp >= 0 && temp < 16) {
					// 符合条件，手动补上一个“0”
					hexString = hexString + "0" + Integer.toHexString(temp);
				} else {
					hexString = hexString + Integer.toHexString(temp);
				}
			}
			return hexString;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "失败";
	}
}
