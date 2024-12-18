package com.hcx.service.impl;

import com.hcx.bean.Node;
import com.hcx.service.NodeService;
import com.hcx.dao.NodeMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
* @author lin
* @description 针对表【node】的数据库操作Service实现
* @createDate 2024-10-23 15:20:43
*/
@Service
public class NodeServiceImpl implements NodeService{

    @Resource
    private NodeMapper nodeMapper;

    @Override
    public List<Node> selectAll() {
        List<Node> nodes = nodeMapper.selectAll();
        List<Node> result = new ArrayList<Node>();
        for (Node node : nodes) {
            if (node != null) {
                if (node.getStatus().equals("1")) {
                    node.setStatus("正常");
                } else {
                    // 处理其他状态值对应的文本
                    node.setStatus("异常");
                }
            }
            result.add(node);
        }
        return result;
    }

    @Override
    public int delNode(int id) {
        int i = nodeMapper.delNodeById(id);
        return i;
    }

    @Override
    public int addNode(Node node) {
        int i = nodeMapper.insertNode(node);
        return i;
    }

    @Override
    public int updateNode(Node node) {
        int i = nodeMapper.updateNodeById(node);
        return i;
    }
}
