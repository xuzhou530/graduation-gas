package tcp.util;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class GetBeanFactory {
	
	private static BeanFactory singleton = 
			new ClassPathXmlApplicationContext("context/applicationContext.xml");
	
	private GetBeanFactory(){
		
	}
	
	public static BeanFactory getInstance(){
		return singleton;
	}
}
