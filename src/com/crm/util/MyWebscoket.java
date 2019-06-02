package com.crm.util;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/webscoket/{name}")
public class MyWebscoket{
	private static Map<String, MyWebscoket> map=new HashMap<>();
	private Session session=null;
	private String name;
	private static int count=0;
	@OnOpen
	public void onopen(@PathParam("name")String name,Session session) {
		System.out.println(session+"session55555555555555555555555555555555555555555555555555555");
		this.session=session;
		this.name=name;
		map.put(name, this);
		count++;
		System.out.println("连接建立了"+name);
	}
	@OnMessage
	public void onmessage(String message) {
		String[] split = message.split(",");
		String formName=split[0];
		String tomName=split[1];
		String content=split[2];
		 for (Map.Entry<String, MyWebscoket> m : map.entrySet()) {
		        System.out.println("key:" + m.getKey() + " value:" + m.getValue());
		 }
		System.out.println(Arrays.toString(split));
		System.out.println(map.containsKey(tomName)+"333333333333333333333333333333333333333");
		if(map.containsKey(tomName)) {
			//在线
			map.get(tomName).session.getAsyncRemote().sendText(content);
		}else {
			//离线消息
		}
	}
	@OnClose
	public void onclose() {
		System.out.println("连接退出了");
		map.remove(name);
		count--;
	}
	@OnError
	public void onerror(Session session,Throwable throwable) {}
}
