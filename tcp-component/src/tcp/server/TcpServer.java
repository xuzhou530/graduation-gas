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

public interface TcpServer {
	public String getServerIp();
	public void setServerIp(String serverIp);
	
	public int getServerPort();
	public void setServerPort(int serverPort);
	
	public int getBufferSize();
	public void setBufferSize(int bufferSize);
	
    public void setDataHandler(TcpServerDataHandler dataHandler);
    public TcpServerDataHandler getDataHandler();

    // 启动服务器
    public void start();

    // 停止服务器
    public void stop();

    // 向客户端发送消息
    public void send(int connectId, byte[] bytes);
    
    // 向客户端发送消息
    public void send(int connectId, byte[] bytes, int offset, int len);

    // 断开指定的客户端
    public void disconnect(int connectId);
    
    // Server 是否已经启动
    public boolean isStart();
    
    // 查询当前的客户端连接数
    public int getConnectCount();
}
