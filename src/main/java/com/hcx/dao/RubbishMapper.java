package com.hcx.dao;

import com.hcx.bean.OrdersExample;
import com.hcx.bean.Rubbish;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface RubbishMapper {
    List<Rubbish> selectAll();

    int delByRubbishId(int rubbishId);

    int adminChangeNode(Map<String, Object> params);

    int countById(int id);

    List<Rubbish> selectByUserId(int id);

    int updateRubbish(Rubbish rubbish);

    List<Rubbish> selectByNodeId(int id);

    int addRubbish(Rubbish rubbish);
}
