package com.efounder.JEnterprise.service.app.electriccurtain;

import com.core.common.ISSPReturnObject;
import com.efounder.JEnterprise.model.app.electriccurtain.BESCurain;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * @author wzx
 * @date  2020-5-12 14:14:45
 */
public interface BESCurtainService {

    ISSPReturnObject create(BESCurain bescurain);

    PageInfo<Object> getPaging(Integer pageSize, Integer pageNum, BESCurain bescurain);

    ISSPReturnObject query(BESCurain bescurain);

    ISSPReturnObject update(BESCurain bescurain);

    ISSPReturnObject delete(BESCurain bescurain);

    /**
     * 导入excel数据
     * @param request
     * @param multipartFile
     * @return
     * @throws IOException
     */
    ISSPReturnObject impExcel(HttpServletRequest request,
                              @RequestParam(required = false, value = "file") MultipartFile multipartFile) throws IOException;
}
