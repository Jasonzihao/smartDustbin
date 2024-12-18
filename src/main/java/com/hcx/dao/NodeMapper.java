package com.hcx.dao;

import com.hcx.bean.Node;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author lin
* @description 针对表【node】的数据库操作Mapper
* @createDate 2024-10-23 15:20:43
*
*/
public interface NodeMapper {
    List<Node> selectAll();

    int delNodeById(int id);


    int insertNode(Node node);

    int updateNodeById(Node node);
}
