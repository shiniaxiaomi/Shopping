package com.lyj.shopping.util;


public class StringUtil{

	/**
	 * 返回截取的字符串
	 * @param s 要被截取的字符串 (abcdefgh)
	 * @param beginIndex 开始字符的索引 2 从第2个开始截取
	 * @param endIndex 结束字符的索引 7
	 * @return 截取好的字符串 bcdefg
	 */
	public static String substring(String s,int beginIndex,int endIndex){		
		s=s.substring(beginIndex-1, endIndex);		
		return s;
	}
	
	/**
	 * 返回截取的字符串
	 * @param s 要被截取的字符串 (abcdefgh)
	 * @param beginIndex 开始字符的索引 2 从第2个开始截取
	 * @return 截取好的字符串 bcdefgh
	 */
	public static String firstSubstring(String s,int beginIndex){
		s=s.substring(beginIndex-1);
		return s;
	}
	
	/**
	 * 返回截取的字符串
	 * @param s 要被截取的字符串 (abcdefgh)
	 * @param lastIndex 结束字符的索引 倒数第2个开始截取
	 * @return 截取好的字符串 abcdefg
	 */
	public static String lastSubstring(String s,int lastIndex){
		s=StringUtil.substring(s, 1, s.length()+1-lastIndex);
		return s;
	}
	
	/**
	 * 替换最后的字符
	 * @param s 原字符串 (abbcdefggh)
	 * @param regex 要被替换的字符串 g
	 * @param replacement 替换的字符串 h
	 * @return (abbcdefghh)
	 */
	public static String replaceLast(String s,String regex,String replacement){
		String str="";
		int find=s.lastIndexOf(regex);
		str=s.substring(0, find);
		str+=replacement;
		str+=s.substring(find+1, s.length());
		return str;
	}
	
	/**
	 * 替换最开始的字符
	 * @param s 原字符串 (abbcdefggh)
	 * @param regex 要被替换的字符串 b
	 * @param replacement 替换的字符串 h
	 * @return (ahbcdefggh)
	 */
	public static String replaceFirst(String s,String regex,String replacement){
		s=s.replaceFirst(regex, replacement);
		return s;
	}
	
	/**
	 * 判断字符串是否为空
	 * @param s
	 * @return
	 */
	public static boolean isEmpty(String s){
		if(s!=null && !s.equals("")){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 判断字符串是否不为空
	 * @param s
	 * @return
	 */
	public static boolean isNotEmpty(String s){
		if(s!=null && !s.equals("")){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 吧字符串转行成double类型
	 * @param s
	 * @return
	 */
	public static double changeDouble(String s){	
		return StringUtil.isEmpty(s) ? -1 : Double.parseDouble(s);	
	}
	
	public static int changeInt(String s){	
		return StringUtil.isEmpty(s) ? -1 : Integer.parseInt(s);	
	}
	
	
	
	
	
	
	
	
	public static void main(String[] args) {
		String s="abbcdefggh";
		//s=s.replaceFirst("bc", "");
		//s=StringUtil.lastSubstring("abcdefgh", 2);
		//s=StringUtil.replaceFirst(s, "b", "h");
		//s=StringUtil.replaceLast(s, "g", ")");
		System.out.println(s);
	} 
	
}
