/**
 * 温控器图标点击事件
 */
var TempListEvent = {};
layui.use(['layer','form'], function(){
    var layer = layui.layer;
    var form = layui.form;
    var tempIconIndex;
    var f_sys_name = "";

    var eventFlag = "";//操作标识
    var snwd = "";//室内温度
    var snwdJd = "";
    var sdwd = "";//室内温度
    var sdwdJd = "";

    var sdwdMap = {}; // Map map = new HashMap();设定温度(精度处理后)
    var sdwdJdMap = {}; // Map map = new HashMap();设定温度
    var snwdMap = {}; // Map map = new HashMap();室内温度(精度处理后)
    var snwdJdMap = {}; // Map map = new HashMap();室内温度

    var settingInfo = "";//设置配置详细信息


    var nodesMapInfo = "";//点位详细信息
    var currentValue="";


    $(document).ready(function () {
        setInterval("TempListEvent.initCurrentTime()", 1000);
    });

    //温控器展示列表点击事件
    TempListEvent.initListSettingEvent = function() {
        /**
         * 初始化记载各个温控器的详细信息
         * @type {HTMLCollectionOf<Element>}
         */
        //start
        var divEle = document.getElementsByClassName("design_div ui-draggable ui-draggable-handle");
        for(var i = 0;i<divEle.length;i++){
            f_sys_name = divEle[i].id;
           if(f_sys_name!="settingsTable"){
               TempListEvent.queryPointInfoEvent("1");
               TempListEvent.initCurrentTime();
           }
        }
        //end
        $(".design_div").unbind('click').click(function () {
            f_sys_name = $(this).attr("data-id");
            if($("#tempSettingWin").find("div:eq(0)").attr("id")!=f_sys_name){
                $("#tempSettingWin").find("div:eq(0)").attr('id',f_sys_name);
            }
            if(f_sys_name){
                //查询关联模块的模块类型
                $.ajax({
                    url: _ctx + "/view/basedatamanage/eqmanage/getRelativeModuleTypeInfo",
                    type    : "post",
                    dataType: 'json',
                    async:false,
                    data : {
                        sysname : f_sys_name
                    },
                    success : function(result) {
                        if(result.status  =="1"){
                            if(result.data == "3"||result.data == "13"){//低配温控器
                                //低配温控器弹框
                                TempListEvent.menuClick();
                                TempListEvent.initCurrentTime();
                            }else if(result.data == "13"){//高配温控器
                                //高配温控器弹框
                                TempListEvent.menuClick();
                                TempListEvent.initCurrentTime();
                            }
                        }
                    }
                });
            }else{
                layer.msg("请先关联点");
            }
        })
    }




    /**
     * 获取当前时间
     */
    TempListEvent.initCurrentTime = function (){
        var divEle = document.getElementsByClassName("design_div ui-draggable ui-draggable-handle");
        for(var i = 0;i<divEle.length;i++){
            f_sys_name = divEle[i].id;
            if(f_sys_name!="settingsTable"){
                var d = new Date();
                var my_hours=d.getHours();
                var my_minutes=d.getMinutes();
                $("#"+f_sys_name).find("p[class='sjInfo']").html(my_hours+":"+my_minutes);
            }
        }

    };

    //查询关联点信息.
    TempListEvent.queryPointInfoEvent = function(flag){
        $.ajax({
            url     : _ctx + '/btnEventController/getModuleState',
            type    : "post",
            dataType: 'json',
            async: false,
            data : {
                sysname : f_sys_name
            },
            success : function(result) {
                if(result.status === '1' ){
                    if(result.data=="1"){//在线
                        $("#"+f_sys_name).find("img[class='statusImg']").css("display","block");
                        $("#"+f_sys_name).find("p[class='status']").css("display","block");
                    }else{
                        $("#"+f_sys_name).find("img[class='statusImg']").css("display","none");
                        $("#"+f_sys_name).find("p[class='status']").css("display","none");
                    }

                }else{
                    layer.msg("操作失败",{icon:2});
                }
            },
            error : function(result) {
                layer.msg("操作失败",{icon:2});
            }
        });


        $.ajax({
            url     : _ctx + '/btnEventController/getTempModuleInfo',
           /* url     : _ctx + '/btnEventController/getTempPointInfo',*/
            type    : "post",
            dataType: 'json',
            async: false,
            data : {
                sysname : f_sys_name
            },
            success : function(result) {
                if(result.status === '1' && result.list){
                    nodesMapInfo = result.list;
                    if(flag=="1"){
                        if(result.list[0]!=null){//开关机
                            if(result.list[0].f_desc == "关机"){//关机
                                $("#"+f_sys_name).find("div[class='settingsChild']").css("display","none");
                            }else if(result.list[0].f_desc == "开机"){//开机
                                $("#"+f_sys_name).find("div[class='settingsChild']").css("display","block");
                            }
                        }
                        if(result.list[1]!=null){//模式1:制冷 2：制热
                            if(result.list[1].f_desc == "制冷"){
                                $("#"+f_sys_name).find("p[class='module']").html(result.list[1].f_desc);
                                $("#"+f_sys_name).find("img[class='moduleImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/cool.png");
                            }else if(result.list[1].f_desc == "制热"){
                                $("#"+f_sys_name).find("p[class='module']").html(result.list[1].f_desc);
                                $("#"+f_sys_name).find("img[class='moduleImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/warm.png");
                            }else{
                                $("#"+f_sys_name).find("p[class='module']").html(result.list[1].f_desc=undefined?"":result.list[1].f_desc);
                            }
                        }
                        if(result.list[2]!=null){//风速
                            /*if(result.list[2].F_DESC == "低速"){
                                $("#"+f_sys_name).find("p[class='fs']").html(result.list[2].F_DESC);
                                $("#"+f_sys_name).find("p[class='moduleType']").html("手动");
                                $("#"+f_sys_name).find("img[class='moduleTypeImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/handModule.png");
                            }else if(result.list[2].F_DESC == "中速"){
                                $("#"+f_sys_name).find("p[class='fs']").html(result.list[2].F_DESC);
                                $("#"+f_sys_name).find("p[class='moduleType']").html("手动");
                                $("#"+f_sys_name).find("img[class='moduleTypeImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/handModule.png");
                            }else if(result.list[2].F_DESC == "高速"){
                                $("#"+f_sys_name).find("p[class='fs']").html(result.list[2].F_DESC);
                                $("#"+f_sys_name).find("p[class='moduleType']").html("手动");
                                $("#"+f_sys_name).find("img[class='moduleTypeImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/handModule.png");
                            }*/if(result.list[2].f_desc == "节能"){
                                $("#"+f_sys_name).find("p[class='fs']").html(result.list[2].f_desc);
                                $("#"+f_sys_name).find("p[class='moduleType']").html("自动");
                                $("#"+f_sys_name).find("img[class='moduleTypeImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/selffModule.png");
                            }else{//高速、低速、中速
                                $("#"+f_sys_name).find("p[class='fs']").html(result.list[2].f_desc);
                                $("#"+f_sys_name).find("p[class='moduleType']").html("手动");
                                $("#"+f_sys_name).find("img[class='moduleTypeImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/handModule.png");
                            }
                        }
                        if(result.list[3]!=null){//锁定
                            if(result.list[3].F_INIT_VAL == "1"||result.list[3].F_INIT_VAL == "2"){//1:全部锁  2:部分锁定
                                $("#"+f_sys_name).find("div[class='sdDiv']").css("display","block");
                            }else{
                                $("#"+f_sys_name).find("div[class='sdDiv']").css("display","none");
                            }
                        }
                        if(result.list[7]!=null){//设定温度
                            if (result.list[7].F_ACCURACY)//精度
                            {
                                sdwd = (result.list[7].F_INIT_VAL)/ (Math.pow(10, (result.list[7].F_ACCURACY)))
                            }else{
                                sdwd = result.list[7].F_INIT_VAL;
                            }
                            sdwdMap[result.list[7].F_SYS_NAME]=sdwd;
                            $("#"+f_sys_name).find("p[class='sdTempInfo']").html(sdwd);
                            $("#"+f_sys_name).find("p[class='sdwd']").html("设定温度");
                            sdwdJd = result.list[7].F_INIT_VAL;
                            sdwdJdMap[result.list[7].F_SYS_NAME]=sdwdJd;
                        }
                        if(result.list[4]!=null){//室内温度
                            if (result.list[4].F_ACCURACY)//精度
                            {
                                snwd = (result.list[4].F_INIT_VAL)/ (Math.pow(10, (result.list[4].F_ACCURACY)))
                            }else{
                                snwd = result.list[4].F_INIT_VAL;
                            }
                            snwdMap[result.list[4].F_SYS_NAME]=snwd;//往map中存值
                            $("#"+f_sys_name).find("p[class='sdTempInfo']").html(snwd);
                            $("#"+f_sys_name).find("p[class='sdwd']").html("室内温度");
                            snwdJd = result.list[4].F_INIT_VAL;
                            snwdJdMap[result.list[4].F_SYS_NAME]=snwdJd;//往map中存值
                        }
                    }

                }else{
                    layer.msg("查询失败",{icon:2});
                }
            },
            error : function(result) {
                layer.msg("查询失败",{icon:2});
            }
        });

    }

    /**
     * 查询设置配置详细信息
     */
    TempListEvent.getTempPointInfo = function(f_sys_name){
        $.ajax({
            url     : _ctx + '/btnEventController/getTempPointInfo',
            type    : "post",
            dataType: 'json',
            async: false,
            data : {
                sysname : f_sys_name
            },
            success : function(result) {
                if(result.status === '1' && result.list){
                    settingInfo = result.list;
                }else{
                    layer.msg("查询失败",{icon:2});
                }
            },
            error : function(result) {
                layer.msg("查询失败",{icon:2});
            }
        });
    }

    /**
     * 设置点击事件
     */
    TempListEvent.menuClick= function(){
        /**
         * 升温
         */
        $("#"+f_sys_name).find("img[class='highImg']").unbind('click').click(function(){

            f_sys_name = $(this).parent().parent().parent().attr("id");
            for(var key in sdwdMap){
                if((f_sys_name+"07") == key){
                    sdwd = sdwdMap[key];
                }
            }
            sdwd ++;
            sdwdJd ++;
            sdwdMap[f_sys_name+"07"]=sdwd;
            sdwdJdMap[f_sys_name+"07"]=sdwdJd;
            $("#"+f_sys_name).find("p[class='sdTempInfo']").html(sdwd);
            $("#"+f_sys_name).find("p[class='sdwd']").html("设定温度");
            eventFlag = "tempType";
            return false;
        });


        /**
         * 降温
         */
        $("#"+f_sys_name).find("img[class='lowImg']").unbind('click').click(function(){
            f_sys_name = $(this).parent().parent().parent().attr("id");
            for(var key in sdwdMap){
                if((f_sys_name+"07") == key){
                    sdwd = sdwdMap[key];
                }
            }
            sdwd --;
            sdwdJd--;
            $("#"+f_sys_name).find("p[class='sdTempInfo']").html(sdwd);
            $("#"+f_sys_name).find("p[class='sdwd']").html("设定温度");
            sdwdMap[f_sys_name+"07"]=sdwd;
            sdwdJdMap[f_sys_name+"07"]=sdwdJd;
            eventFlag = "tempType";
            return false;
        })


        /**
         * 模式改变
         */

        $("#"+f_sys_name).find("img[class='menu']").unbind('click').click(function(){
            f_sys_name = $(this).parent().parent().parent().attr("id");
            for(var key in snwdMap){
                if((f_sys_name+"04") == key){
                    snwd = snwdMap[key];
                }
            }
            $("#"+f_sys_name).find("p[class='sdTempInfo']").html(snwd);
            $("#"+f_sys_name).find("p[class='sdwd']").html("室内温度");
            TempListEvent.getTempPointInfo(f_sys_name+"01");
            if(settingInfo.length>0){
                for(var i = 0;i<settingInfo.length;i++){
                    var currentModule = $("#"+f_sys_name).find("p[class='module']")[0].innerText;
                    if(currentModule == settingInfo[i].F_DESC){
                        if(i==settingInfo.length-1){
                            i=0;
                            if(settingInfo[i].F_DESC=="制热"){
                                $("#"+f_sys_name).find("img[class='moduleImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/warm.png");
                                $("#"+f_sys_name).find("p[class='module']").html(settingInfo[i].F_DESC);
                                currentValue = settingInfo[i].F_INIT_VAL;
                                break;
                            }else if(settingInfo[i].F_DESC=="制冷"){
                                $("#"+f_sys_name).find("img[class='moduleImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/cool.png");
                                $("#"+f_sys_name).find("p[class='module']").html(settingInfo[i].F_DESC);
                                currentValue = settingInfo[i].F_INIT_VAL;
                                break;
                            }else{
                                $("#"+f_sys_name).find("p[class='module']").html(settingInfo[i].F_DESC);
                                currentValue = settingInfo[i].F_INIT_VAL;
                                break;
                            }
                        }else{
                            if(settingInfo[i+1].F_DESC=="制热"){
                                $("#"+f_sys_name).find("img[class='moduleImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/warm.png");
                                $("#"+f_sys_name).find("p[class='module']").html(settingInfo[i+1].F_DESC);
                                currentValue = settingInfo[i].F_INIT_VAL;
                                break;
                            }else if(settingInfo[i+1].F_DESC=="制冷"){
                                $("#"+f_sys_name).find("img[class='moduleImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/cool.png");
                                $("#"+f_sys_name).find("p[class='module']").html(settingInfo[i+1].F_DESC);
                                currentValue = settingInfo[i].F_INIT_VAL;
                                break;
                            }else{
                                $("#"+f_sys_name).find("p[class='module']").html(settingInfo[i+1].F_DESC);
                                currentValue = settingInfo[i].F_INIT_VAL;
                                break;
                            }
                        }

                    }
                }
            }
            eventFlag = "funType";
            return false;
        })


        /**
         * 风速改变
         */

        $("#"+f_sys_name).find("img[class='moduleSel']").unbind('click').click(function(){
            f_sys_name = $(this).parent().parent().parent().attr("id");
            for(var key in snwdMap){
                if((f_sys_name+"04") == key){
                    snwd = snwdMap[key];
                }
            }
            $("#"+f_sys_name).find("p[class='sdTempInfo']").html(snwd);
            $("#"+f_sys_name).find("p[class='sdwd']").html("室内温度");

            TempListEvent.getTempPointInfo(f_sys_name+"02");
            if(settingInfo.length>0){
                for(var i = 0;i<settingInfo.length;i++){
                    var currentFs = $("#"+f_sys_name).find("p[class='fs']")[0].innerText;//高中低风速
                    if(currentFs == settingInfo[i].F_DESC){
                        if(i==settingInfo.length-1){
                            i=0;
                            if(settingInfo[i].F_DESC=="节能"){
                                $("#"+f_sys_name).find("p[class='fs']").html(settingInfo[i].F_DESC);
                                $("#"+f_sys_name).find("p[class='moduleType']").html("自动");
                                $("#"+f_sys_name).find("img[class='moduleTypeImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/selffModule.png");
                                currentValue = settingInfo[i].F_INIT_VAL;
                                break;
                            }else {
                                $("#"+f_sys_name).find("p[class='fs']").html(settingInfo[i].F_DESC);
                                $("#"+f_sys_name).find("p[class='moduleType']").html("手动");
                                $("#"+f_sys_name).find("img[class='moduleTypeImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/handModule.png");
                                currentValue = settingInfo[i].F_INIT_VAL;
                                break;
                            }
                        }else{
                            if(settingInfo[i+1].F_DESC=="节能"){
                                $("#"+f_sys_name).find("p[class='fs']").html(settingInfo[i+1].F_DESC);
                                $("#"+f_sys_name).find("p[class='moduleType']").html("自动");
                                $("#"+f_sys_name).find("img[class='moduleTypeImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/selffModule.png");
                                currentValue = settingInfo[i].F_INIT_VAL;
                                break;
                            }else {
                                $("#"+f_sys_name).find("p[class='fs']").html(settingInfo[i+1].F_DESC);
                                $("#"+f_sys_name).find("p[class='moduleType']").html("手动");
                                $("#"+f_sys_name).find("img[class='moduleTypeImg']").attr("src",""+_ctx+"/static/pageDesign/icon/toolbar/handModule.png");
                                currentValue = settingInfo[i].F_INIT_VAL;
                                break;
                            }
                        }

                    }
                }
            }
            eventFlag = "moduleType";
            return false;
        });

        /**
         *开关机设置（单击）
         * */

        $("#"+f_sys_name).find("img[class='kgj']").unbind('click').click(function(){
            f_sys_name = $(this).parent().parent().parent().attr("id");
            for(var key in snwdMap){
                if((f_sys_name+"04") == key){
                    snwd = snwdMap[key];
                }
            }
            $("#"+f_sys_name).find("p[class='sdTempInfo']").html(snwd);
            $("#"+f_sys_name).find("p[class='sdwd']").html("室内温度");
            if(eventFlag == "moduleType"){//风速+手自动
                TempListEvent.setTemperaturePoint(f_sys_name,f_sys_name+"02",currentValue );
            }else if(eventFlag == "funType"){//制冷制热
                TempListEvent.setTemperaturePoint(f_sys_name,f_sys_name+"01",currentValue);
            }else if(eventFlag == "tempType"){//升降温
                TempListEvent.setTemperaturePoint(f_sys_name,f_sys_name+"07",sdwdJd);
            }
            eventFlag = "";
            return false;
        });

        /**
         * 关机（双击）
         */
        $("#"+f_sys_name).find("img[class='kgj']").dblclick(function(){
            f_sys_name = $(this).parent().parent().parent().attr("id");
            for(var key in snwdMap){
                if((f_sys_name+"04") == key){
                    snwd = snwdMap[key];
                }
            }
            //TempListEvent.queryPointInfoEvent("0");
            TempListEvent.setTemperaturePoint(f_sys_name,nodesMapInfo[0].F_SYS_NAME,"0");//关机
            return false;
        });

    }



    //取消按钮--关闭添加弹窗
    TempListEvent.closeIconSettingWin = function(){
        layer.close(tempIconIndex);
        window.clearTimeout(t1);
    }

    //温控器设置事件，向下位机发送数据
    TempListEvent.setTemperaturePoint = function(f_sysy_name,fSysName,currentVal){
        var fWorkMode = "";
        var f_init_val = "";
       if(currentVal=="开机"){
            f_init_val = "255";
        }else if(currentVal=="关机"){
            f_init_val = "0";
        } else{
            f_init_val = currentVal;
        }
        if($("#"+f_sys_name).find("p[class='fs']")[0].innerText=="节能"){//高速、低速、中速（手动） 节能（自动）
            fWorkMode = "0";//自动
        }else{
            fWorkMode ="1";
        }

        $.ajax({
            url : _ctx + "/api/debugPointInfo",
            type : "post",
            contentType : "application/json; charset=utf-8",
            dataType : "json",
            data : JSON.stringify({
                f_sys_name : fSysName,
                f_work_mode : fWorkMode,
                f_init_val : f_init_val,
            }),
            success : function(result) {
                if(result.status === '0'){
                    if(result.msg){
                        layer.msg(result.msg,{icon:2});
                    }else{
                        layer.msg("执行失败",{icon:2});
                    }
                }else{
                    if(result.msg){
                        layer.msg(result.msg,{icon:1});
                    }else{
                        layer.msg("执行成功",{icon:1});
                    }
                }
            },

        });
    }




});