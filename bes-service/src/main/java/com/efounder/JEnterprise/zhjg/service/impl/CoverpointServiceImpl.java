package com.efounder.JEnterprise.zhjg.service.impl;

import com.core.common.ISSPReturnObject;
import com.efounder.JEnterprise.common.constants.Constants;
import com.efounder.JEnterprise.zhjg.dao.CoverpointDao;
import com.efounder.JEnterprise.zhjg.entity.CoverpointEntity;
import com.efounder.JEnterprise.zhjg.service.CoverpointService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service("coverpointService")
public class CoverpointServiceImpl implements CoverpointService {
    @Autowired
    private CoverpointDao dao;

    @Override
    public PageInfo<CoverpointEntity> getSearch(String keywords, Integer pageNum) {
        if (pageNum == null)
            pageNum = 1;
        PageHelper.startPage(pageNum, Constants.PAGE_SIZE);
        List<CoverpointEntity> list = dao.getSearch(keywords);
        PageInfo<CoverpointEntity> page = new PageInfo<CoverpointEntity>(list);
        return page;
    }

    /**
    * 新增
    */
    @Override
    public ISSPReturnObject add(CoverpointEntity dto) {
        ISSPReturnObject returnObject = new ISSPReturnObject();
        try {
            boolean flag = dao.add(dto);
            if (flag) {
                returnObject.setStatus("1");//1.成功
                returnObject.setMsg("添加成功");
            } else {
                returnObject.setStatus("0");//0.失败
                returnObject.setMsg("添加失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setStatus("0");
            returnObject.setMsg("数据异常！请重新输入");
        }
        return returnObject;
    }

    /**
    * 修改
    */
    @Override
    public ISSPReturnObject update(CoverpointEntity dto) {
        ISSPReturnObject returnObject = new ISSPReturnObject();
        try {
            int count = dao.update(dto);
            if (count > 0) {
                returnObject.setMsg("编辑成功");
                returnObject.setStatus("1");
            } else {
                returnObject.setMsg("编辑失败");
                returnObject.setStatus("0");
            }
        } catch (Exception e) {
            returnObject.setMsg("编辑失败");
            returnObject.setStatus("0");
        }
        return returnObject;
    }

    /**
    * 删除
    */
    @Override
    public ISSPReturnObject delete(String id) {
        ISSPReturnObject returnObject = new ISSPReturnObject();
        try {
            int count = dao.delete(id);
            if (count > 0) {
                returnObject.setStatus("1");
                returnObject.setMsg("删除成功");
            } else {
                returnObject.setStatus("0");
                returnObject.setMsg("删除失败");
            }
        } catch (Exception e) {
            returnObject.setStatus("0");
            returnObject.setMsg("删除失败");
        }
        return returnObject;
    }

    /**
    * 根据id查询具体参数
    */
    @Override
    public CoverpointEntity getSearchById(String id) {
        return dao.getSearchById(id);
    }
}