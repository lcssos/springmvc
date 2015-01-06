package cn.martin.springmvc.index.service;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;





public class SpringManager implements ISpring {
	
	@Override
	public void getMessage() {
		
//		userDao.save();

		System.out.println("get message");
	}

}
