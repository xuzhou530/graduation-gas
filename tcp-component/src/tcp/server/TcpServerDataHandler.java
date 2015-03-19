/*
 * Source code of the book of Thinking in Java Component Design
 * 中文书名：Java 组件设计
 * 作者: 孔德生
 * Email: kshark2008@gmail.com
 * Date: 2008-12
 * Copyright 2008-2010
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package tcp.server;

public interface TcpServerDataHandler {
	/**
	 * Socket服务端组件通知应用层，有客户端连接上来了
	 * @param connectId 连接唯一标识
	 * @param ip 客户端的Ip
	 * @param port 客户端的端口号
	 */
	public void onConnect(int connectId, String ip, int port);

	/**
	 * Socket服务端组件通知应用层，有客户端断连
	 * @param connectId 连接唯一标识
	 * @param ip 客户端的Ip
	 * @param port 客户端的端口号
	 */
	public void onDisconnect(int connectId, String ip, int port);

	/**
	 * Socket服务端组件接收到数据后，递交应用层进行包边界识别。
	 * @param connectId 连接唯一标识
	 * @param bytes Socket服务端组件接收到的所有数据，可能不够一个完整的数据包，也可能包含多个数据包
	 * @param byteCount bytes数组中的有效字节数
	 * @return 如果应用层能识别bytes中至少包含一个完整数据包，则返回第一个数据包的长度。
	 * Socket组件会根据返回的长度，将第一包切出来，然后回调onReceiveMsg方法。
	 *         如果不足一个完整的数据包，应用层必须返回-1
	 */ 
	public int slice(int connectId, byte[] bytes, int byteCount);

	/**
	 * Socket组件回调此方法，通知应用层收到了一个完整的数据包
	 * @param connectId 连接唯一标识
	 * @param bytes 存放数据的缓冲区 
	 * @param byteCount 一个完整数据包的长度
	 * Socket组件通过调用slice方法，判断是否有完整的数据包。如有，则回调onReceiveMsg。
	 */
	public void onReceiveMsg(int connectId, byte[] bytes, int byteCount);

	/**
	 * Socket组件通知应用层，消息已经成功发送
	 * @param connectId 连接唯一标识
	 * @param bytes 数据缓冲区
	 * @param byteCount 成功发送的一个完整数据包长度
	 */
	public void onSendMsg(int connectId, byte[] bytes, int byteCount);

}
