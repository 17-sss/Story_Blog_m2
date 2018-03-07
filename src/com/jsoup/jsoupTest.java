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
		String h1 = doc.select("h1").text(); //h1�±� ������� ����
		String h2 = doc.select("h2").eq(1).text(); // 1��° �ε����� ��ġ�� h2�±��� ������� ����
		Elements contents = doc.select("p"); //p�±��� ������ �������̱� ������ Elements ��ü�� �켱 ��´�.
		
		System.out.println(h1);
		System.out.println(h2);
		
		//idx = ���� ������� ������ ���° ������ ��Ÿ��
		int idx = 0;
		//foreach���� �̿��Ͽ� ���
		for(Element element : contents){
			if(0<idx && idx<5){
				//<p>�±��� ���븸�� �����ϱ� ���� .text()�޼��� ���
				System.out.println(element.text());
			}
			idx++;
		}
	}

}
