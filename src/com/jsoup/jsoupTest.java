package com.jsoup;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class jsoupTest {
	// https://m.blog.naver.com/PostView.nhn?blogId=occidere&logNo=220851125347&proxyReferer=https%3A%2F%2Fwww.google.co.kr%2F
	private final static String address = "http://www.findip.kr/";
	
	public static void main(String[] args) throws Exception {
		Document doc = Jsoup.connect(address).header("user_Agent", "Mozilla/5.0").get();
//		System.out.println(doc);
		String h1 = doc.select("h1").text(); //h1태그 내용안을 추출
		String h2 = doc.select("h2").eq(1).text(); // 1번째 인덱스에 위치한 h2태그의 내용안을 추출
		Elements contents = doc.select("p"); //p태그의 내용은 여러개이기 떄문에 Elements 객체에 우선 담는다.
		
		System.out.println(h1);
		System.out.println(h2);
		
		//idx = 현재 출력중인 라인이 몇번째 줄인지 나타냄
		int idx = 0;
		//foreach문을 이용하여 출력
		for(Element element : contents){
			if(0<idx && idx<5){
				//<p>태그의 내용만을 추출하기 위해 .text()메서드 사용
				System.out.println(element.text());
			}
			idx++;
		}
	}

}
