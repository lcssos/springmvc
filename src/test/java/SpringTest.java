import cn.martin.springmvc.admin.entity.User;
import cn.martin.springmvc.admin.service.IUserService;
import org.junit.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by martin on 2015-01-10.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/applicationContext-hibernate.xml"})
public class SpringTest {

    @Resource(name = "userService")
    private IUserService userService;

    @Test
    public void Test(){
        List<User> list = userService.findAll();

    }
}
