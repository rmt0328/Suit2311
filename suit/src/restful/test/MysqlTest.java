package restful.test;

import java.util.List;

import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import restful.bean.Result;
import restful.database.EM;
import restful.entity.User;
import restful.test.Cat;

public class MysqlTest {
	public static void main(String args[]) {
		List<Cat> result = EM.getEntityManager()
				.createNamedQuery("Cat.findAll", Cat.class)
				.getResultList();
		for(Cat c:result) {
			System.out.println("id:"+c.getId()+"   code:"+c.getCode()+"   name:"+c.getName());
		}
		/*User user = new User();
		user.setUsername("hhh");
		user.setPassword("11111");
		try {
			User result =  EM.getEntityManager()
					.createNamedQuery("User.findAllByName", User.class).setParameter("name", "%"+user.getUsername()+"%").getSingleResult();
		}catch (NonUniqueResultException e) {
		    // 没有匹配的结果
		    System.out.println("没有找到匹配的用户");
		}*/
		
		
		//System.out.println("id:"+result.getId()+"   code:"+result.getUsername()+"   name:"+result.getNickname());
	}
	
}
