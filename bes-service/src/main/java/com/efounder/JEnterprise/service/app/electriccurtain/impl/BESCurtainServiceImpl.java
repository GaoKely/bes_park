package com.efounder.JEnterprise.service.app.electriccurtain.impl;

import com.core.common.ISSPReturnObject;
import com.efounder.JEnterprise.common.constants.Constants;
import com.efounder.JEnterprise.common.util.UUIDUtil;
import com.efounder.JEnterprise.initializer.AiPointCache;
import com.efounder.JEnterprise.initializer.AoPointCache;
import com.efounder.JEnterprise.initializer.DiPointCache;
import com.efounder.JEnterprise.initializer.DoPointCache;
import com.efounder.JEnterprise.mapper.app.electriccurtain.BESCurtainMapper;
import com.efounder.JEnterprise.model.app.electriccurtain.BESCurain;
import com.efounder.JEnterprise.model.basedatamanage.enegrycollectionmanage.BESCurtain;
import com.efounder.JEnterprise.model.basedatamanage.eqmanage.BESSbPzStruct;
import com.efounder.JEnterprise.model.basedatamanage.eqmanage.BesAoPoint;
import com.efounder.JEnterprise.model.basedatamanage.eqmanage.BesDoPoint;
import com.efounder.JEnterprise.model.excelres.ExcelError;
import com.efounder.JEnterprise.model.excelres.Pzlj;
import com.efounder.JEnterprise.service.app.electriccurtain.BESCurtainService;
import com.framework.common.utils.ExcelUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author wzx
 * @date 2020-5-12 13:48:58
 */

@Service
public class  BESCurtainServiceImpl implements BESCurtainService {

    @Resource
    private BESCurtainMapper bescurtainMapper;

    @Autowired
    Pzlj pzlj;

    @Autowired
    AoPointCache aoPointCache;

    @Autowired
    AiPointCache aiPointCache;

    @Autowired
    DoPointCache doPointCache;

    @Autowired
    DiPointCache diPointCache;

    /**
     * ??????????????????
     * @param bescurain
     * @return
     */
    @Override
    public ISSPReturnObject create(BESCurain bescurain) {

        ISSPReturnObject returnObject = new ISSPReturnObject();

        if (null == bescurain) {
            returnObject.setStatus("0");
            returnObject.setMsg("???????????????");
            return returnObject;
        }

        String  name        = bescurain.getName();
        String  electriccurtain_address = bescurain.getElectriccurtain_address();

        if (!StringUtils.hasText(name) || !StringUtils.hasText(electriccurtain_address)) {

            returnObject.setStatus("0");
            returnObject.setMsg("???????????????");
            return returnObject;

        }

        try {
            bescurtainMapper.insert(bescurain);

            returnObject.setStatus("1");
            returnObject.setMsg("????????????");

        } catch (Exception e) {

            returnObject.setStatus("0");
            returnObject.setMsg("????????????");

            e.printStackTrace();
        }

        return returnObject;
    }

    /**
     * ??????????????????
     * @param pageSize
     * @param pageNum
     * @param bescurain
     * @return
     */
    @Override
    public PageInfo<Object> getPaging(Integer pageSize, Integer pageNum, BESCurain bescurain) {
        if (pageNum == null){
            pageNum = 1;
        }

        if (pageSize == null) {
            pageSize = Constants.PAGE_SIZE;
        }

        PageHelper.startPage(pageNum, pageSize);
        // ?????????????????????select??????????????????
        List<Object> list = bescurtainMapper.findList(bescurain);
        // ???PageInfo?????????????????????
        PageInfo<Object> page = new PageInfo<>(list);
        return page;
    }

    /**
     * ????????????????????????
     * @param bescurain
     * @return
     */
    @Override
    public ISSPReturnObject query(BESCurain bescurain) {

        ISSPReturnObject isspReturnObject = new ISSPReturnObject();

        try {
            List<Object> list = bescurtainMapper.findList(bescurain);
            isspReturnObject.setData(list);
            isspReturnObject.setStatus("1");
        } catch (Exception e) {
            isspReturnObject.setStatus("0");
            e.printStackTrace();
        }

        return isspReturnObject;
    }

    /**
     * ????????????????????????
     * */
    @Override
    public ISSPReturnObject update(BESCurain bescurain) {

        ISSPReturnObject returnObject = new ISSPReturnObject();

        if (null == bescurain) {
            returnObject.setStatus("0");
            returnObject.setMsg("???????????????");
            return returnObject;
        }

        Integer id          = bescurain.getId();
        String  name        = bescurain.getName();
        String  clAddress = bescurain.getElectriccurtain_address();

        if (null == id
                || !StringUtils.hasText(name)
                || !StringUtils.hasText(clAddress)
        ) {

            returnObject.setStatus("0");
            returnObject.setMsg("???????????????");
            return returnObject;

        }

        BESCurain acm = new BESCurain();
        acm.setId(id);

        try {
            List<Object> list = bescurtainMapper.findList(acm);

            if (null == list || list.isEmpty()){

                returnObject.setStatus("0");
                returnObject.setMsg("???????????????");
                return returnObject;
            }

        } catch (Exception e) {
            returnObject.setStatus("0");
            e.printStackTrace();
        }

        try {
            bescurtainMapper.update(bescurain);
            returnObject.setStatus("1");
        } catch (Exception e) {
            returnObject.setStatus("0");
            e.printStackTrace();
        }

        return returnObject;
    }

    /**
     * ????????????????????????
     * @param bescurain
     * @return
     */
    @Override
    public ISSPReturnObject delete(BESCurain bescurain) {

        ISSPReturnObject returnObject = new ISSPReturnObject();

        if (null == bescurain) {
            returnObject.setStatus("0");
            returnObject.setMsg("???????????????");
            return returnObject;
        }

        Integer id = bescurain.getId();

        if (null == id) {
            returnObject.setStatus("0");
            returnObject.setMsg("???????????????");
            return returnObject;
        }

        BESCurain chum = new BESCurain();
        chum.setId(id);

        try {
            List<Object> list = bescurtainMapper.findList(chum);

            if (null == list || list.isEmpty()){

                returnObject.setStatus("0");
                returnObject.setMsg("???????????????");
                return returnObject;
            }

        } catch (Exception e) {
            returnObject.setStatus("0");
            e.printStackTrace();
        }


        try {
            bescurtainMapper.delete(id);
            returnObject.setStatus("1");
        } catch (Exception e) {
            returnObject.setStatus("0");
            e.printStackTrace();
        }

        return returnObject;
    }

    /**
     * ??????????????????????????????
     */
    @Override
    public ISSPReturnObject impExcel(HttpServletRequest request,
                                     @RequestParam(required = false, value = "file") MultipartFile multipartFile) throws IOException {
        ISSPReturnObject returnObject = new ISSPReturnObject();
        String fold = request.getParameter("fold");
        String dayFold = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String realPath = pzlj.getUploadPath();// ??????????????????????????????
        // ????????????????????????request
        // ????????????file??????
        if (multipartFile != null) {
            if (multipartFile.getSize() != 0L) {
                // ??????????????????
                String pictureFile_name = multipartFile.getOriginalFilename();
                // uuid
                String UUID = UUIDUtil.getRandom32BeginTimePK();
                // ???????????????
                String wjmc_url = UUID + pictureFile_name.substring(pictureFile_name.lastIndexOf("."));
                // ????????????
                String fileUrl = realPath + "/" + fold + "/" + dayFold + "/" + wjmc_url;
                // ????????????
                File uploadPic = new File(fileUrl);
                if (!uploadPic.getParentFile().exists()) {
                    uploadPic.getParentFile().mkdirs();// ??????????????????
                    uploadPic.createNewFile();// ????????????
                }
                // ??????????????????
//                multipartFile.transferTo(uploadPic);
                //?????????????????????
                OutputStream out = new FileOutputStream(uploadPic);
                out.write(multipartFile.getBytes());
                // ????????????????????????
                FileInputStream fis = null;
                try {
                    fis = new FileInputStream(fileUrl);
                    ExcelUtil<BESCurtain> util = new ExcelUtil<>(BESCurtain.class);
                    List<BESCurtain> list = util.importExcel("??????????????????", fis);// ??????excel,???????????????list
                    // ????????????????????????
                    List<ExcelError> excelErrors = new ArrayList<>();

                    for(int i = 0 ;i < list.size(); i++)
                    {
                        boolean flag = true; //???????????????????????????
                        BESCurtain besCurtain = list.get(i);
                        String errMsg = "";
                        //??????????????????
                        if(besCurtain.getName() == null || besCurtain.getName().equals(""))
                        {
                            errMsg = "??????????????????,";
                            flag = false;
                        }
                        //??????????????????
                        if(besCurtain.getCurtainAddress() == null || besCurtain.getCurtainAddress().equals("")) {
                            errMsg += "??????????????????,";
                            flag = false;
                        }
                        //????????????
                        if (besCurtain.getCurtainSwitchSystem() != null && !"".equals(besCurtain.getCurtainSwitchSystem())){
                            //???????????????AO???DO
                            //?????????????????????????????????
                            BesDoPoint besDoPoint = doPointCache.getCachedElementBySysNameOld(besCurtain.getCurtainSwitchSystem());
                            if (besDoPoint == null){
                                BesAoPoint besAoPoint = aoPointCache.getCachedElementBySysNameOld(besCurtain.getCurtainSwitchSystem());
                                if (besAoPoint == null){
                                    errMsg += "??????????????????,";
                                    flag = false;
                                } else {
                                    besCurtain.setCurtainSwitchSystem(besAoPoint.getfSysName());
                                    besCurtain.setCurtainSwitch(besAoPoint.getfNickName());
                                }
                            } else {
                                besCurtain.setCurtainSwitchSystem(besDoPoint.getfSysName());
                                besCurtain.setCurtainSwitch(besDoPoint.getfNickName());
                            }
                        }
                        //??????????????????
                        if (besCurtain.getCurtainKdkzSystem() != null && !"".equals(besCurtain.getCurtainKdkzSystem())){
                            //?????????????????????AO???DO
                            //?????????????????????????????????
                            BesDoPoint besDoPoint = doPointCache.getCachedElementBySysNameOld(besCurtain.getCurtainKdkzSystem());
                            if (besDoPoint == null){
                                BesAoPoint besAoPoint = aoPointCache.getCachedElementBySysNameOld(besCurtain.getCurtainKdkzSystem());
                                if (besAoPoint == null){
                                    errMsg += "????????????????????????,";
                                    flag = false;
                                } else {
                                    besCurtain.setCurtainKdkzSystem(besAoPoint.getfSysName());
                                    besCurtain.setCurtainKdkz(besAoPoint.getfNickName());
                                }
                            } else {
                                besCurtain.setCurtainKdkzSystem(besDoPoint.getfSysName());
                                besCurtain.setCurtainKdkz(besDoPoint.getfNickName());
                            }
                        }
                        //??????????????????
                        if (besCurtain.getCurtainStopSystem() != null && !"".equals(besCurtain.getCurtainStopSystem())){
                            //?????????????????????AO???DO
                            //?????????????????????????????????
                            BesDoPoint besDoPoint = doPointCache.getCachedElementBySysNameOld(besCurtain.getCurtainStopSystem());
                            if (besDoPoint == null){
                                BesAoPoint besAoPoint = aoPointCache.getCachedElementBySysNameOld(besCurtain.getCurtainStopSystem());
                                if (besAoPoint == null){
                                    errMsg += "????????????????????????,";
                                    flag = false;
                                } else {
                                    besCurtain.setCurtainStopSystem(besAoPoint.getfSysName());
                                    besCurtain.setCurtainStop(besAoPoint.getfNickName());
                                }
                            } else {
                                besCurtain.setCurtainStopSystem(besDoPoint.getfSysName());
                                besCurtain.setCurtainStop(besDoPoint.getfNickName());
                            }
                        }

                        if (!flag) {
                            errMsg = errMsg.substring(0, errMsg.length() - 1);
                            ExcelError excelError = new ExcelError();
                            excelError.setRow((i+2)+"");
                            excelError.setErrorMsg(errMsg);
                            excelErrors.add(excelError);
                        }
                    }
                    if(excelErrors.size() > 0)
                    {
                        returnObject.setMsg("?????????????????????????????????????????????excel???????????????");
                        returnObject.setStatus("2");
                        returnObject.setList(excelErrors);
                        return returnObject;
                    }
                    else
                    {
                        boolean inportflag = false;
                        for (BESCurtain besCurtain :list) {
                            try {
                                inportflag = bescurtainMapper.insertCurtain(besCurtain);
                            } catch (Exception e) {
                                returnObject.setMsg("???????????????");
                                returnObject.setStatus("0");
                                e.printStackTrace();
                            }
                        }
                        if(inportflag){
                            returnObject.setMsg("???????????????");
                            returnObject.setStatus("1");
                        }else{
                            returnObject.setMsg("???????????????");
                            returnObject.setStatus("0");
                        }
                    }
                }  catch (FileNotFoundException e) {
                    returnObject.setStatus("0");
                    returnObject.setMsg("???????????????");
                    e.printStackTrace();
                } catch (NullPointerException e) {
                    returnObject.setStatus("0");
                    returnObject.setMsg("???????????????");
                    e.printStackTrace();
                }
            }
        } else {
            returnObject.setMsg("?????????????????????");
            returnObject.setStatus("0");
        }
        return returnObject;
    }

}
