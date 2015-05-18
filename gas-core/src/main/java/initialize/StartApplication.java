package initialize;

import org.springframework.beans.factory.BeanFactory;

public class StartApplication {
	public static void main(String[] args){
		BeanFactory factory = GetBeanFactory.getInstance();
	}
}
