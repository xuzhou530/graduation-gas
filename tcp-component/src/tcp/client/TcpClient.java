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

package tcp.client;

public interface TcpClient {
	public String getServerIp();
	public void setServerIp(String serverIp);
	
	public int getServerPort();
	public void setServerPort(int serverPort);
	
	public void setAutoReconnect(boolean autoReconnect);
	public boolean isAutoReconnect();
	
	public int getReconnectInterval();
	public void setReconnectInterval(int reconnectInterval);
	
	public int getBufferSize();
	public void setBufferSize(int bufferSize);
	
	
	public TcpClientDataHandler getDataHandler();
	public void setDataHandler(TcpClientDataHandler tcpClientDataHandler);

	// 连接服务器
    public void connect();

    // 向服务器发送数据
    public void send(byte[] bytes);
    
    // 向服务器发送数据
    public void send(byte[] bytes, int offset, int len);

    // 断开和服务器的连接
    public void disconnect();
    
    // 查询当前的连接状态
    public boolean isConnected();
}
