package com.lyj.shopping.util;

import java.text.DateFormat;
import java.util.Date;

public class DateUtil {

	public static String getDate(){
		Date date = new Date() ;
		DateFormat time = DateFormat.getDateTimeInstance();
		return time.format(date);
	}
	
	
	
	
}
