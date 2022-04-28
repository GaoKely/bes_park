package com.efounder.JEnterprise.zhjg.service.impl;

import com.core.common.ISSPReturnObject;
import com.efounder.JEnterprise.common.constants.Constants;
import com.efounder.JEnterprise.zhjg.dao.WarnInfoDao;
import com.efounder.JEnterprise.zhjg.entity.WarnInfoEntity;
import com.efounder.JEnterprise.zhjg.service.WarnInfoService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Service
public class WarnInfoServiceImpl implements WarnInfoService {

    @Resource
    private WarnInfoDao dao;
//    @Autowired
//    private ISebDynamicAgreeHandleService dynamicAgreeHandleService;

    @Override
    public PageInfo<WarnInfoEntity> getSearch(String warnid,String beginTime,String endTime, Integer pageNum) {
        if (pageNum == null)
            pageNum = 1;
        PageHelper.startPage(pageNum, Constants.PAGE_SIZE);
        List<WarnInfoEntity> list = dao.getSearch(warnid,beginTime,endTime);
        PageInfo<WarnInfoEntity> page = new PageInfo<WarnInfoEntity>(list);
        return page;
    }

    /**
    * 新增
    */
    @Override
    public ISSPReturnObject add(WarnInfoEntity dto) {
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
    public ISSPReturnObject update(WarnInfoEntity dto) {
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
    public WarnInfoEntity getSearchById(String id) {
        return dao.getSearchById(id);
    }

    /**
     * 清空历史数据
     */
    @Override
    public ISSPReturnObject clean() {
        ISSPReturnObject returnObject = new ISSPReturnObject();
        try {
            int count = dao.clean();
            if (count > 0) {
                returnObject.setStatus("1");
                returnObject.setMsg("清空历史数据成功");
            } else {
                returnObject.setStatus("0");
                returnObject.setMsg("清空历史数据失败");
            }
        } catch (Exception e) {
            returnObject.setStatus("0");
            returnObject.setMsg("系操作异常");
        }
        return returnObject;
    }

//    /**
//     * @Description: 保存实时报警数据
//     *
//     */
//    @Override
//    public void saveRealWarn() throws Exception{
//        SebWarnRecord warn = new SebWarnRecord();
//        List<Map<String,String>> RealWarn = dynamicAgreeHandleService.GetRealWarn(warn);
//        // pin装sql
//        StringBuilder sb = new StringBuilder();
//        if(RealWarn.size()>0){
//            for(Map<String,String> map : RealWarn){
//                sb.append("('").append(map.get("DeviceId")).append("',").append(map.get("warnid")).append(",'")
//                        .append(map.get("warntype")).append("','").append(map.get("warnMsg"))
//                        .append("')").append(",");
//            }
//            String pin = sb.toString().substring(0,sb.toString().length()-1);
//            //插入数据库
//            dao.insertRealWarn(pin);
//        }
//
//    }
}