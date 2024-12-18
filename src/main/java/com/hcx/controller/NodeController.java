package com.hcx.controller;

import com.hcx.service.NodeService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.hcx.bean.Node;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/node")
public class NodeController {

    @Resource
    private NodeService nodeService;

    @RequestMapping(value ="findAll", produces="text/html;charset=utf-8")
    @ResponseBody
    public  String selectAll() {
        List<Node> list = nodeService.selectAll();
        JSONArray json = JSONArray.fromObject(list);
        String js = json.toString();
        return "{\"code\":0,\"msg\":\"\",\"count\":"+3+",\"data\":"+js+"}";
    }

    @RequestMapping(value ="delNode", produces="text/html;charset=utf-8")
    @ResponseBody
    public  String delNode(int id) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("msg","1");
        int count = nodeService.delNode(id);
        if(count==1){
            jsonObject.put("result",true);
        }else{
            jsonObject.put("result",false);
        }
        return jsonObject.toString();
    }


    @RequestMapping(value ="AutoUpdateNode" )
    @ResponseBody
    public String AutoUpdateNode(@RequestBody Node node) {
        JSONObject jsonObject = new JSONObject();
        System.out.println("update node:" + node.getId());
        Integer count = nodeService.updateNode(node);
        if(count > 0){
            jsonObject.put("result",true);
            jsonObject.put("msg","Success");
        }else{
            jsonObject.put("result",false);
            jsonObject.put("msg","Failed");
        }
        return jsonObject.toString();
    }

    @RequestMapping(value ="updateNode" )
    @ResponseBody
    public String updateNode(@RequestParam Map<String, String> formData) {
        Node node = new Node();
        int id = Integer.parseInt(formData.get("id"));
        node.setId(id);
        node.setStatus(formData.get("status"));
        node.setJingdu(formData.get("jingdu"));
        node.setWeidu(formData.get("weidu"));
        Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
        node.setUpdatetime(timeStamp.toString());
        JSONObject jsonObject = new JSONObject();
        int count = nodeService.updateNode(node);
        if(count > 0){
            jsonObject.put("result",true);
            jsonObject.put("msg","Success");
        }else{
            jsonObject.put("result",false);
            jsonObject.put("msg","Failed");
        }
        return jsonObject.toString();
    }

    @RequestMapping(value ="addNode", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    @ResponseBody
    public String addNode(@RequestParam Map<String, String> formData) {
        JSONObject jsonObject = new JSONObject();
        Node node = new Node();
        node.setStatus(formData.get("status"));
        node.setJingdu(formData.get("jingdu"));
        node.setWeidu(formData.get("weidu"));
        Timestamp now =  new Timestamp(System.currentTimeMillis());
        System.out.println(now);
        node.setCreatetime(now.toString());
        node.setUpdatetime(now.toString());
        int count = nodeService.addNode(node);
        if(count > 0){
            jsonObject.put("result",true);
            jsonObject.put("msg","Success");
        }else{
            jsonObject.put("result", false);
            jsonObject.put("msg","Failed");
        }
        return jsonObject.toString();
    }



}
