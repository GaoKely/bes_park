package com.framework.zcsoft.web;

import com.framework.zcsoft.model.RestHandlerMapping;
import com.google.common.base.Optional;
import com.google.common.base.Strings;
import com.google.common.collect.Lists;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiOperationSort;
import io.swagger.annotations.ApiSort;
import io.swagger.models.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.BeanFactoryUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.ClassUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.mvc.condition.PatternsRequestCondition;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;
import org.springframework.web.util.UriComponents;
import springfox.documentation.annotations.ApiIgnore;
import springfox.documentation.service.Documentation;
import springfox.documentation.service.Tag;
import springfox.documentation.spring.web.DocumentationCache;
import springfox.documentation.spring.web.json.Json;
import springfox.documentation.spring.web.json.JsonSerializer;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.mappers.ServiceModelToSwagger2Mapper;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.*;
import java.util.regex.Pattern;

import static com.google.common.base.Strings.isNullOrEmpty;
import static org.springframework.util.MimeTypeUtils.APPLICATION_JSON_VALUE;
import static springfox.documentation.swagger.common.HostNameProvider.componentsFrom;

/***
 * SwaggerBootstrapUiZ????????????
 * @since:swagger-bootstrap-ui 1.8.5
 * @author <a href="mailto:xiaoymin@foxmail.com">xiaoymin@foxmail.com</a> 
 * 2018/10/11 11:26
 */
@Controller
@ApiIgnore
public class SwaggerBootstrapUiController {

    /***
     * sort????????????
     */
    public static final String DEFAULT_SORT_URL = "/v2/api-docs-ext";

    private static final String HAL_MEDIA_TYPE = "application/hal+json";
    private static final Logger LOGGER = LoggerFactory.getLogger(SwaggerBootstrapUiController.class);
    private final ServiceModelToSwagger2Mapper mapper;
    private final DocumentationCache documentationCache;
    private final JsonSerializer jsonSerializer;
    private final String hostNameOverride;
    /***
     * ????????????mappings
     */
    private List<RestHandlerMapping> globalHandlerMappings=new ArrayList<>();

    private final RequestMethod[] globalRequestMethods={RequestMethod.POST,RequestMethod.GET,RequestMethod.PUT,
            RequestMethod.DELETE,RequestMethod.PATCH,RequestMethod.OPTIONS,RequestMethod.HEAD};


    @Autowired
    public SwaggerBootstrapUiController(Environment environment,
                                        ServiceModelToSwagger2Mapper mapper, DocumentationCache documentationCache, JsonSerializer jsonSerializer) {
        this.mapper = mapper;
        this.documentationCache = documentationCache;
        this.jsonSerializer = jsonSerializer;
        this.hostNameOverride = environment.getProperty(
                "springfox.documentation.swagger.v2.host",
                "DEFAULT");
    }

    @RequestMapping(value = DEFAULT_SORT_URL,
            method = RequestMethod.GET,
            produces = { APPLICATION_JSON_VALUE, HAL_MEDIA_TYPE })
    @ResponseBody
    public ResponseEntity<Json> apiSorts(@RequestParam(value = "group", required = false) String swaggerGroup,HttpServletRequest request) {
        String groupName = Optional.fromNullable(swaggerGroup).or(Docket.DEFAULT_GROUP_NAME);
        Documentation documentation = documentationCache.documentationByGroup(groupName);
        if (documentation == null) {
            LOGGER.warn("Unable to find specification for group {},use default", groupName);
            //return new ResponseEntity<Json>(HttpStatus.NOT_FOUND);
            //??????SpringCloud??????????????????swagger??????????????????Documentation???????????????,??????default???????????????
            documentation=documentationCache.documentationByGroup(Docket.DEFAULT_GROUP_NAME);
            if (documentation==null){
                LOGGER.warn("Unable to find specification for group default");
                return new ResponseEntity<Json>(HttpStatus.NOT_FOUND);
            }
        }
        Swagger swagger = mapper.mapDocumentation(documentation);
        UriComponents uriComponents = componentsFrom(request, swagger.getBasePath());
        swagger.basePath(Strings.isNullOrEmpty(uriComponents.getPath()) ? "/" : uriComponents.getPath());
        if (isNullOrEmpty(swagger.getHost())) {
            swagger.host(hostName(uriComponents));
        }
        SwaggerExt swaggerExt =new SwaggerExt(swagger);
        //swaggerBootstrapUi.setTagSortLists(getSortTag(request,documentation));
        swaggerExt.setSwaggerBootstrapUi(initSwaggerBootstrapUi(request,documentation,swaggerExt));
        // Method ?????????
        return new ResponseEntity<Json>(jsonSerializer.toJson(swaggerExt), HttpStatus.OK);
    }


    private SwaggerBootstrapUi initSwaggerBootstrapUi(HttpServletRequest request,Documentation documentation,SwaggerExt swaggerExt){
        SwaggerBootstrapUi swaggerBootstrapUi=new SwaggerBootstrapUi();
        WebApplicationContext wc=WebApplicationContextUtils.getWebApplicationContext(request.getServletContext());
        //??????????????????????????????.
        Iterator<Tag> tags=documentation.getTags().iterator();
        //???1.8.7?????????,??????Spring?????????????????????HandleMappings
        if (globalHandlerMappings.size()==0){
            //?????????
            String parentPath="";
            //??????basePath
            if (!StringUtils.isEmpty(swaggerExt.getBasePath())&&!"/".equals(swaggerExt.getBasePath())){
                parentPath+=swaggerExt.getBasePath();
            }
            //????????????????????????????????????????????????????????????????????????
            Map<String, HandlerMapping> requestMappings = BeanFactoryUtils.beansOfTypeIncludingAncestors(wc,HandlerMapping.class,true,false);
            System.out.println("requestMappings"+requestMappings==null);
            if (requestMappings!=null){
                for (HandlerMapping handlerMapping : requestMappings.values()) {
                    if (handlerMapping instanceof RequestMappingHandlerMapping) {
                        RequestMappingHandlerMapping rmhMapping = (RequestMappingHandlerMapping) handlerMapping;
                        Map<RequestMappingInfo, HandlerMethod> handlerMethods = rmhMapping.getHandlerMethods();
                        for (RequestMappingInfo rmi : handlerMethods.keySet()) {
                            PatternsRequestCondition prc = rmi.getPatternsCondition();
                            Set<RequestMethod> restMethods=rmi.getMethodsCondition().getMethods();
                            Set<String> patterns = prc.getPatterns();
                            HandlerMethod handlerMethod = handlerMethods.get(rmi);
                            for (String url : patterns) {
                                Class<?> clazz = ClassUtils.getUserClass(handlerMethod.getBeanType());
                                Method method = ClassUtils.getMostSpecificMethod(handlerMethod.getMethod(),clazz);
                                if (LOGGER.isDebugEnabled()){
                                    LOGGER.debug("url:"+url+"\r\nclass:"+clazz.toString()+"\r\nmethod:"+method.toString());
                                }
                                globalHandlerMappings.add(new RestHandlerMapping(parentPath+url,clazz,method,restMethods));
                            }
                        }
                    }
                }
            }
        }
        //1.8.7
        List<SwaggerBootstrapUiTag> targetTagLists=Lists.newArrayList();
        List<SwaggerBootstrapUiPath> targetPathLists=Lists.newArrayList();
        while (tags.hasNext()) {
            Tag sourceTag = tags.next();
            String tagName = sourceTag.getName();
            //??????order???
            int order=Integer.MAX_VALUE;
            SwaggerBootstrapUiTag tag=new SwaggerBootstrapUiTag(order);
            tag.name(tagName).description(sourceTag.getDescription());
            Api tagApi=null;
            RestHandlerMapping tagMapping=null;
            for (RestHandlerMapping rhm:globalHandlerMappings){
                Api api = rhm.getBeanType().getAnnotation(Api.class);
                if (api!=null){
                    //????????????api????????????tags??????
                    if (api.tags()!=null&&api.tags().length>0){
                        if (Lists.newArrayList(api.tags()).contains(tagName)) {
                            tagApi=api;
                            tagMapping=rhm;
                            createPathInstance(rhm,targetPathLists);
                        }else{
                            ///????????????tags????????????""?????????
                            String firstTag=api.tags()[0];
                            if (StringUtils.isEmpty(firstTag)){
                                if (checkExists(tagName,rhm.getBeanType())){
                                    tagApi=api;
                                    tagMapping=rhm;
                                    createPathInstance(rhm,targetPathLists);
                                }
                            }
                        }
                    }else{
                        //??????tags???????????????,??????value?????????
                        //api-1872-controller
                        //??????@Api(value = "187??????",description = "187?????????????????????",position = 297)?????????
                        //???Springfox-Swagger???,??????value???????????????,?????????Tag???????????????Class?????????
                        //??????????????????????????????name??????
                        if (checkExists(tagName,rhm.getBeanType())){
                            if (!StringUtils.isEmpty(api.value())){
                                tag.name(api.value());
                                //tagName=api.value();
                            }
                            tagApi=api;
                            tagMapping=rhm;
                            createPathInstance(rhm,targetPathLists);
                        }
                    }
                }
            }
            if (tagMapping!=null){
                tag.setOrder(getRestTagOrder(tagMapping.getBeanType(),tagApi));
            }
            targetTagLists.add(tag);
        }
        Collections.sort(targetTagLists, new Comparator<SwaggerBootstrapUiTag>() {
            @Override
            public int compare(SwaggerBootstrapUiTag o1, SwaggerBootstrapUiTag o2) {
                return o1.getOrder().compareTo(o2.getOrder());
            }
        });
        Collections.sort(targetPathLists, new Comparator<SwaggerBootstrapUiPath>() {
            @Override
            public int compare(SwaggerBootstrapUiPath o1, SwaggerBootstrapUiPath o2) {
                return o1.getOrder().compareTo(o2.getOrder());
            }
        });

        swaggerBootstrapUi.setTagSortLists(targetTagLists);
        swaggerBootstrapUi.setPathSortLists(targetPathLists);
        return swaggerBootstrapUi;
    }


    /***
     * ???????????????tag????????????targetPathLists?????????
     * @param rhm
     * @param targetPathLists
     */
    private void createPathInstance(RestHandlerMapping rhm,List<SwaggerBootstrapUiPath> targetPathLists){
        //??????method?????????null????????????null???????????????7???????????????
        if (rhm.getRequestMethods()==null||rhm.getRequestMethods().size()==0){
            for (RequestMethod requestMethod:globalRequestMethods){
                targetPathLists.add(new SwaggerBootstrapUiPath(rhm.getUrl(),requestMethod.name().toUpperCase(),getRestMethodOrder(rhm.getBeanOfMethod())));
            }
        }else{
            for (RequestMethod requestMethod:rhm.getRequestMethods()){
                targetPathLists.add(new SwaggerBootstrapUiPath(rhm.getUrl(),requestMethod.name().toUpperCase(),getRestMethodOrder(rhm.getBeanOfMethod())));
            }
        }
    }

    /***
     * ??????tag??????
     * @param aClass
     * @param api
     * @return
     */
    private int getRestTagOrder(Class<?> aClass,Api api){
        int order=Integer.MAX_VALUE;
        if (api!=null){
            //????????????api?????????position??????,???????????????0,????????????,????????????apiSort??????,??????????????????,???????????????,?????????apisort??????,?????????:@Api-position>@ApiSort-value
            int post=api.position();
            if (post==0){
                if (aClass!=null){
                    ApiSort annotation = ClassUtils.getUserClass(aClass).getAnnotation(ApiSort.class);
                    if (annotation!=null){
                        order=annotation.value();
                    }
                }
            }else{
                order=post;
            }
        }

        return order;
    }

    /***
     * ????????????????????????
     * @param target
     * @return
     */
    private int getRestMethodOrder(Method target){
        //???????????????Sort???
        int pathOrder=Integer.MAX_VALUE;
        //??????????????????Swagger???@ApiOperation
        ApiOperation apiOperation=target.getAnnotation(ApiOperation.class);
        if (apiOperation!=null){
            //??????@ApiOperation???position???
            if (apiOperation.position()!=0){
                pathOrder=apiOperation.position();
            }else{
                ApiOperationSort apiOperationSort=target.getAnnotation(ApiOperationSort.class);
                if (apiOperationSort!=null){
                    pathOrder=apiOperationSort.value();
                }
            }
        }else{
            //?????????,??????????????????@ApiOperationSort
            ApiOperationSort apiOperationSort=target.getAnnotation(ApiOperationSort.class);
            if (apiOperationSort!=null){
                pathOrder=apiOperationSort.value();
            }
        }
        return pathOrder;
    }



    private boolean checkExists(String tagName,Class<?> aClass){
        boolean flag=false;
        if (!StringUtils.isEmpty(tagName)){
            String regexStr=tagName.replaceAll("\\-",".*?");
            //???className?????????
            Pattern pattern=Pattern.compile(regexStr,Pattern.CASE_INSENSITIVE);
            if (pattern.matcher(aClass.getSimpleName()).matches()){
                //??????
                flag=true;
            }
        }
        return flag;
    }



    private String hostName(UriComponents uriComponents) {
        if ("DEFAULT".equals(hostNameOverride)) {
            String host = uriComponents.getHost();
            int port = uriComponents.getPort();
            if (port > -1) {
                return String.format("%s:%d", host, port);
            }
            return host;
        }
        return hostNameOverride;
    }

}
