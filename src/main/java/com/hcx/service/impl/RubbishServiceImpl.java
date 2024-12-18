package com.hcx.service.impl;

import com.hcx.bean.Rubbish;
import com.hcx.dao.RubbishMapper;
import com.hcx.service.RubbishService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service(value = "rubbishService")
public class RubbishServiceImpl implements RubbishService {

    @Autowired
    private RubbishMapper rubbishMapper;

    @Override
    public List<Rubbish> selectAll() {
        return rubbishMapper.selectAll();
    }

    @Override
    public int delRubbishByRubbishId(int rubbishId) {
        return rubbishMapper.delByRubbishId(rubbishId);
    }

    @Override
    public int adminChangeNode(int rubbishId, int newNode) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("rubbishId", rubbishId);
        params.put("newNode", newNode);
        params.put("updateDatetime", new Timestamp(System.currentTimeMillis()));
        return rubbishMapper.adminChangeNode(params);
    }

    @Override
    public int countById(int id) {
        return rubbishMapper.countById(id);
    }

    @Override
    public List<Rubbish> selectByUserId(int id) {
        return rubbishMapper.selectByUserId(id);
    }

    @Override
    public int updateRubbish(Rubbish rubbish) {
        return rubbishMapper.updateRubbish(rubbish);
    }

    @Override
    public List<Rubbish> selectByNodeId(int id) {
        return rubbishMapper.selectByNodeId(id);
    }

    @Override
    public int addRubbish(Rubbish rubbish) {
        return rubbishMapper.addRubbish(rubbish);
    }

}
