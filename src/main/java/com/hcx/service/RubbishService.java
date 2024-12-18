package com.hcx.service;

import com.hcx.bean.Orders;
import com.hcx.bean.Rubbish;

import java.util.List;

public interface RubbishService {
    List<Rubbish> selectAll();

    int delRubbishByRubbishId(int rubbishId);

    int adminChangeNode(int rubbishId, int newNode);

    int countById(int id);

    List<Rubbish> selectByUserId(int id);

    int updateRubbish(Rubbish rubbish);

    List<Rubbish> selectByNodeId(int id);

    int addRubbish(Rubbish rubbish);
}
