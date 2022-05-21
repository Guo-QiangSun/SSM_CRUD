package com.qiang.bean;

import java.util.HashMap;

/**
 * 通用返回类json
 */
public class Message {
    //状态码 100-成功，200-失败
    private int code;
    //提示信息
    private String msg;
    //用户要返回浏览器的数据
    private HashMap<String, Object> map = new HashMap<>();

    public static Message success() {
        Message message = new Message();
        message.setCode(100);
        message.setMsg("处理成功");
        return message;
    }

    public static Message fail() {
        Message message = new Message();
        message.setCode(200);
        message.setMsg("处理失败");
        return message;
    }

    public Message add(String key, Object value) {
        this.getMap().put(key, value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public HashMap<String, Object> getMap() {
        return map;
    }

    public void setMap(HashMap<String, Object> map) {
        this.map = map;
    }
}
