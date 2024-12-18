package com.hcx.service;

import com.hcx.bean.Node;

import java.util.List;

/**
* @author lin
* @description 针对表【node】的数据库操作Service
* @createDate 2024-10-23 15:20:43
*/
public interface NodeService {

    List<Node> selectAll();

    int delNode(int id);


    int addNode(Node node);

    int updateNode(Node node);
}
