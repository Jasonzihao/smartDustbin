package com.hcx.test;

import com.hcx.bean.Orders;
import com.hcx.bean.Rubbish;
import com.hcx.dao.*;
import com.hcx.service.*;
import net.sf.json.JSONArray;
import org.junit.Test;
import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;

/**
 * @Author Ninomiya_Mioto
 * Date on 2021/6/21  14:25
 */
public class JunitTest extends BaseTest {

    @Resource
    private AdminService adminService;
    @Resource
    private AdminMapper adminMapper;
    @Resource
    private UserService userService;
    @Resource
    private UserMapper userMapper;

    @Resource
    private PowerbankService powerbankService;
    @Resource
    private PowerbankMapper powerbankMapper;

    @Resource
    private OrdersService ordersService;
    @Resource
    private OrdersMapper ordersMapper;

    @Resource
    private LocationMapper locationMapper;


    @Resource
    private CupboardMapper cupboardMapper;
    @Resource
    private CupboardService cupboardService;

    @Resource
    private RubbishService rubbishService;


    @Test
    public void test_rubbish_showAll(){
        List<Rubbish> list = rubbishService.selectAll();
        System.out.println("list = " + list);;
        String temp = list.get(0).getRubbishTemperature();
        System.out.println(temp);
        System.out.println(list.get(0).toString());
    }

    @Test
    public void test_rubbish_del(){
        int del = rubbishService.delRubbishByRubbishId(2);
        System.out.println(del);
        if(del == 1){
            System.out.println("del success");
        }
    }

    @Test
    public void test_rubbish_updateNode(){
        int change = rubbishService.adminChangeNode(1, 3);
        System.out.println(change);
        if(change == 1){
            System.out.println("change success");
        }
    }

    @Test
    public void test_rubbish_findRubbishByName(){
        String username = "15696361333";
        int id = userService.selectByPhone(username).getUserId();
        System.out.println("用户ID：" + id);
        int count = rubbishService.countById(id);
        System.out.println("总数量"+ count);
        List<Rubbish> list = rubbishService.selectByUserId(id);
        JSONArray json = JSONArray.fromObject(list);
        String js = json.toString();
        System.out.println(js);
    }

    @Test
    public void test_rubbish_updateRubbish(){
        Rubbish rubbish = new Rubbish();
        rubbish.setRubbishId(13);
        rubbish.setRubbishCapacity("60%");
        rubbish.setRubbishHumidity("60%");
        rubbish.setRubbishTemperature("15");
        rubbish.setRubbishAlcohol("否");
        Timestamp now =  new Timestamp(System.currentTimeMillis());
        rubbish.setRubbishUpdatetime(now.toString());
        System.out.println(now);
        int result = rubbishService.updateRubbish(rubbish);
        System.out.println("result is:" + result);
    }

    @Test
    public void test_rubbish_addRubbish(){
        Rubbish rubbish = new Rubbish();
        rubbish.setRubbishUserid(1);
        rubbish.setRubbishCapacity("65%");
        rubbish.setRubbishHumidity("55%");
        rubbish.setRubbishTemperature("18");
        rubbish.setRubbishAlcohol("是");
        Timestamp now =  new Timestamp(System.currentTimeMillis());
        rubbish.setRubbishUpdatetime(now.toString());
        rubbish.setRubbishCreatetime(now.toString());
        rubbish.setRubbishNodeid(1);
        int i = rubbishService.addRubbish(rubbish);
        System.out.println("i = " + i);
    }


    @Test
    public void test01(){
        //mapper层测试

//        System.out.println(adminMapper.selectByPrimaryKey(1).getAdminId());
//        System.out.println(adminMapper.findByAccount("admin").getAdminId());
//            System.out.println(ordersMapper.selectByPrimaryKey(1).getOrderId());
//        System.out.println(powerbankMapper.countByExample(null));
//        System.out.println(locationMapper.countByExample(null));
        System.out.println(powerbankMapper.selectOne(1).getPobkId());
    }
    @Test
    public void test02() throws ParseException {
        //service层测试
//        System.out.println(adminService.login("admin","123456"));//true
//        System.out.println(adminService.selectById(1).getAdminId());//1

//        List<Admin> list = adminService.selectByAccount("admin");
//        for(Admin users : list){
//            System.out.println(users.getAdminAccount());
//        }
//        System.out.println(userService.selectByPhone("17520098429").getUserAlias());
//        List<User> list=userService.selectAll();
//        for(User users:list){
//            System.out.println(users.getUserAlias());
//        }
//        System.out.println(userService.login("16626713429","123456"));
//        System.out.println(powerbankService.countByCupId(1));
//        System.out.println(ordersService.selectByUserId(2));
//        System.out.println(ordersService.selectAll());
//        System.out.println(userService.selectByPhone("17520098429").getUserId());
//        System.out.println(ordersService.countById(1));
//        List<Orders> list=ordersService.selectByUserId(1);
//        for (Orders order:list){
//            System.out.println(order.getOrderCreatetime());
//        }
//        Log log=new Log(1l,"查询","com.hcx","123456");
//        log.setCreateDate(new Date());
//        logService.save(log);
//        System.out.println(cupboardService.findAvailable(1));
//        System.out.println(powerbankService.lentStatus(5));
//        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
//        String date=simpleDateFormat.format(new Date());
//        System.out.println(date);
//        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
//        System.out.println(df.format(new Date()));// new Date()为获取当前系统时间
//        System.out.println(cupboardService.lentupdate(1));
//        System.out.println(ordersService.countReturnOrder(1));
//        List<Orders> list=ordersService.selectNotReturn(1);
//        for (Orders order:list){
//            System.out.println(order.getOrderCreatetime());
//        }
//        System.out.println(powerbankService.avaliStatus(1,5));
//        System.out.println(cupboardService.avaliUpdate(1));
//        System.out.println(ordersService.calOrder(10));
//        System.out.println(ordersService.selectByOrderId(44).getOrderCost());
//        System.out.println(userService.deduct(1,10));
//        System.out.println(ordersService.payOrder(4));
//        System.out.println(userService.addMoney("17520098429",12));
//        System.out.println(ordersService.delOrderByOrderId(44));
//        System.out.println(ordersService.adminChangeCost(48,5));
//        System.out.println(cupboardService.putUpdate(1));
//        System.out.println(cupboardService.recycleUpdate(1));
//        System.out.println(powerbankService.putUpdate(1));
//        System.out.println(powerbankService.recycleUpdate(17));
        System.out.println(userService.register("123456","123456","test"));
    }

    @Test
    public void test3() throws ParseException {
        String time1= "2021-06-25 15:18:14";
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date1 = formatter.parse(time1);
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time2=simpleDateFormat.format(new Date());
        Date date2=formatter.parse(time2);
        int dif=dateDiff(date1,date2);
        System.out.println(dif);

    }

    private int dateDiff(Date date1, Date date2) {
        Calendar cal1 = Calendar.getInstance();

        Calendar cal2 = Calendar.getInstance();

        cal1.setTime(date1);

        cal2.setTime(date2);

        long ldate1 = date1.getTime() + cal1.get(Calendar.ZONE_OFFSET) + cal1.get(Calendar.DST_OFFSET);

        long ldate2 = date2.getTime() + cal2.get(Calendar.ZONE_OFFSET) + cal2.get(Calendar.DST_OFFSET);

// Use integer calculation, truncate the decimals

        int hr1 = (int) (ldate1 / 3600000); // 60*60*1000

        int hr2 = (int) (ldate2 / 3600000);

//        int days1 = hr1 / 24;
//
//        int days2 = hr2 / 24;
//
//        int dateDiff = days1 - days2;
        int dateDiff=hr2-hr1;

        return dateDiff;
    }

}
