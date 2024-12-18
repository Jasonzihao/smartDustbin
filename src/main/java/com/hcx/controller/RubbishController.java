package com.hcx.controller;
import com.hcx.bean.Orders;
import com.hcx.bean.Rubbish;
import com.hcx.service.*;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.*;

import static java.time.LocalTime.now;

/**
 * @Author Jason D
 * Date on 2024/10/22 19:46
 */
@Controller
@RequestMapping("/rubbish")
public class RubbishController {
    @Autowired
    RubbishService rubbishService;

    @Autowired
    UserService userService;

    @RequestMapping(value ="findAll", produces="text/html;charset=utf-8")
    public @ResponseBody String findAll(){
        List<Rubbish> list = rubbishService.selectAll();
//      int count = rubbishService.countAll();
        JSONArray json = JSONArray.fromObject(list);
        String js = json.toString();
        String jso="{\"code\":0,\"msg\":\"\",\"count\":"+3+",\"data\":"+js+"}";
        return jso;
    }

    @RequestMapping(value = "delRubbish", produces = "text/html;charset=utf-8")
    @ResponseBody
    public String delRubbish(Integer rubbishId){
        System.out.println("delete rubbish, rubbishID: " + rubbishId);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("msg", "1");
        int del = rubbishService.delRubbishByRubbishId(rubbishId);
        if(del==1){
            jsonObject.put("result", "1");
        }else{
            jsonObject.put("result", "0");
        }
        return jsonObject.toString();
    }

    @RequestMapping(value = "changeNode", produces = "text/html;charset=utf-8")
    @ResponseBody
    public String changeNode(int rubbishId, int newNode){
        System.out.println(rubbishId+" and "+newNode);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("msg", "1");
        System.out.println(newNode);
        if(newNode < 0){
            jsonObject.put("result","0");
            return jsonObject.toString();
        }
        int change = rubbishService.adminChangeNode(rubbishId, newNode);
        System.out.println(change);
        if(change==1){
            jsonObject.put("result","1");
        }else{
            jsonObject.put("result","0");
        }
        return jsonObject.toString();
    }

    @RequestMapping(value = "findRubbishByName", produces = "text/html;charset=utf-8")
    public @ResponseBody String findRubbishByName(String username){
        System.out.println("得到的用户名"+username);
        int id = userService.selectByPhone(username).getUserId();
        int count = rubbishService.countById(id);
        System.out.println("总数量"+ count);
        List<Rubbish> list = rubbishService.selectByUserId(id);
        JSONArray json = JSONArray.fromObject(list);
        String js = json.toString();
        String result ="{\"code\":0,\"msg\":\"\",\"count\":"+count+",\"data\":"+js+"}";
        return result;
    }

    @PostMapping(value = "updateRubbish", produces = "text/html;charset=utf-8")
    @ResponseBody
    public String updateRubbish(@RequestBody Rubbish rubbish){
        System.out.println(rubbish.toString());
        int id = rubbish.getRubbishId();
        System.out.println("更新rubbish:" + id);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("msg", "1");
        int result = rubbishService.updateRubbish(rubbish);
        if(result == 1){
            jsonObject.put("result","1");
        }else{
            jsonObject.put("result","0");
        }
        return jsonObject.toString();
    }

    @RequestMapping(value = "selectByNodeId", produces = "text/html;charset=utf-8")
    @ResponseBody
    public String selectByNodeId(String id){
        System.out.println("id = " + id);
        int rubbishId = Integer.parseInt(id);
        List<Rubbish> list = rubbishService.selectByNodeId(rubbishId);
        JSONArray json = JSONArray.fromObject(list);
        String js = json.toString();
        String jso="{\"code\":0,\"msg\":\"\",\"count\":"+3+",\"data\":"+js+"}";
        return jso;
    }

    @RequestMapping(value = "addRubbish", produces = "text/html;charset=utf-8")
    @ResponseBody
    public String insertRubbish(@RequestParam Map<String, String> formData){
        JSONObject jsonObject = new JSONObject();
        Rubbish rubbish = new Rubbish();
        rubbish.setRubbishHumidity(formData.get("humidity"));
        rubbish.setRubbishTemperature(formData.get("temperature"));
        rubbish.setRubbishCapacity(formData.get("capacity"));
        rubbish.setRubbishUserid(Integer.parseInt(formData.get("userId")));
        rubbish.setRubbishNodeid(Integer.parseInt(formData.get("nodeId")));
        rubbish.setRubbishAlcohol(formData.get("alcohol"));
        Timestamp now =  new Timestamp(System.currentTimeMillis());
        rubbish.setRubbishUpdatetime(now.toString());
        System.out.println(now);
        rubbish.setRubbishUpdatetime(now.toString());
        rubbish.setRubbishCreatetime(now.toString());
        int result = rubbishService.addRubbish(rubbish);
        if(result > 0){
            jsonObject.put("result",true);
            jsonObject.put("msg","Success");
        }else{
            jsonObject.put("result", false);
            jsonObject.put("msg","Failed");
        }
        return jsonObject.toString();
    }

}
