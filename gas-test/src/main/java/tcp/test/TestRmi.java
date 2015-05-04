package tcp.test;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.young.gas.service.MoneyService;

import tcp.server.TcpServerDataHandler;

public class TestRmi {
	
	public static void main(String[] args) {
	    BeanFactory factory = new ClassPathXmlApplicationContext("context/applicationContext.xml");
	    MoneyService moneyService = (MoneyService)factory.getBean("moneyService");//应用层实例
	    System.out.println(moneyService.listCurrentByCusomerId(1026).getResult());
	}
}
