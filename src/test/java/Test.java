import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by martin on 2015-01-10.
 */
public class Test {

    public void test(){
        ApplicationContext ac = new ClassPathXmlApplicationContext(new String[]{"spring/applicationContext-hibernate.xml"});
    }

}
