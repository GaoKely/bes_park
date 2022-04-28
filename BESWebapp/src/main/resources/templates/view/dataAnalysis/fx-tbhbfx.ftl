<#--
描述： 分项用能同比环比分析（时间）
作者： liuzhen
-->
<style>

    /*.tbhbfhFiHead{*/
        /*!*background-color: #042D4B !important;*!*/
        /*border: 2px solid #c1c1c1 !important;*/
        /*white-space: nowrap;*/
    /*}*/

    /*.tbhbfhFix{*/
        /*border: 2px solid #366C90 !important;*/
		/*white-space: nowrap;*/
    /*}*/
    thead th {
        text-align: center;
    }

  tbody td {
    text-align: center;
    vertical-align: middle;
  }

  .search_tbhbfx_div_style {
    display: flex;
    align-items: center;
    margin-right: 3vh;
    float: right;
    white-space: nowrap;
    text-overflow: ellipsis;
    padding: 7px 0px 1px 0px;
  }

  .search_tbhbfx_style {
    width: 100%;
    position: relative;
  }

</style>
<!-- tab样式 -->
<link href="${ctx}/static/css/sjfx_tabs.css" rel="stylesheet">
<ul id="tbhbfx_Tab" class="nav tabs tsys"></ul>
<!-- 分项树模块start -->
<div id="tbhbfx_div" class="leftarea information_left" id="leftsubitemconf">
  <div id="tbhbfx_con" class="information-model">
		<span class="tree_Subtitle">
			<i class="fa fa-share-alt" aria-hidden="true"></i>&nbsp;筛选条件>>>
		</span>
  </div>
  <div class="search_tbhbfx_style">

    <div class="search_tbhbfx_div_style">
      <span class="zl_sxtj_span">对比形式:</span>
      <div style="display: inline-block;" id="tbhbfx_compare_group"></div>
    </div>

    <div class="search_tbhbfx_div_style">
      <span class="zl_sxtj_span">日期范围:</span>
      <div style="display: inline-block;" id="tbhbfx_group"></div>
    </div>


    <div class="search_tbhbfx_div_style">
      <span class="zl_sxtj_span">本期起始:</span>
      <input id="tbhbfx_start_time" class="input-datecheck"
             onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',firstDayOfWeek:1,readOnly:true,onpicked:dataannlysis_fx_tbhbfx.compareChange})">
    </div>


    <div class="search_tbhbfx_div_style">
      <span class="zl_sxtj_span">本期终止:</span>
      <input id="tbhbfx_end_time" class="input-datecheck"
             onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',firstDayOfWeek:1,readOnly:true,onpicked:dataannlysis_fx_tbhbfx.compareChange})">
    </div>


    <div class="search_tbhbfx_div_style">
      <span class="zl_sxtj_span">同期起始:</span>
      <input id="tbhbfx_sametime_start_time" class="input-datecheck"
             onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',readOnly:true,onpicked:dataannlysis_fx_tbhbfx.compareChange})">
    </div>


    <div class="search_tbhbfx_div_style">
      <span class="zl_sxtj_span">同期终止:</span>
      <input id="tbhbfx_sametime_end_time" class="input-datecheck"
             onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',firstDayOfWeek:1,readOnly:true})">
    </div>
    <div class="search_tbhbfx_div_style">
      <span class="zl_sxtj_span">图标类型:</span>
      <div id="tbhbfx_table_group"></div>
    </div>
    <div class="search_tbhbfx_div_style">
      <span class="zl_sxtj_span">时间颗粒度:</span>
      <div style="display: inline-block;" id="tbhbfx_time_group"></div>
    </div>


    <div style="display: none" class="search_tbhbfx_div_style">
      <span class="zl_sxtj_span">单位换算:</span>
      <div style="display: inline-block;" id="tbhbfx_dw_group"></div>

    </div>
    <div class="search_tbhbfx_div_style"><span class="zl_sxtj_span">请选分项>>> </span>
      <input type="text" style="visibility: hidden;" class="input-datecheck">
      <label style="cursor: pointer;right: 3vh;display: flex;position: absolute;">
        <input id="tbhbfxCascade" type="checkbox" checked="checked" value="1">是否级联
      </label>
    </div>

  </div>

  <div id="tree_tbhbfx"
       style="overflow-y: auto;overflow-x: auto;width: 100%;border-top:1px solid #007ABA;"></div>
  <div id="tbhbfx_bottom"
       style="height:5%!important;position: absolute;width:100%;bottom: 0;">
    <div style="float: right;padding-top: 0.6vh;padding-right: 2vh;">
      <button type="button" style="width:5vw" class="btn btn-sm btn-primary no-margins toLeft"
              onclick="dataannlysis_fx_tbhbfx.getHourTableData()">
        <i class="fa fa-spinner"></i>&nbsp;加载数据
      </button>
      <button type="button" class="btn btn-sm btn-primary no-margins toLeft"
              onclick="dataannlysis_fx_tbhbfx.reset()">
        <i class="fa fa-refresh"></i>&nbsp;重置
      </button>

    </div>
  </div>
</div>
<!-- 分项树模块end -->

<!-- 右侧内容模块start -->
<div class="information_right">
  <div class="information_size" style="height:50%">
    <!-- echarts图表 -->
    <div class="information-model">
			<span class="tree_Subtitle">统计分析>>>
			</span>
    </div>
    <div id="tbhbfx_chart" style="width: 95%; height: 90%;"></div>
  </div>

  <div class="information_size " style="height:50%">
    <div class="information-model" style="height:3.3vh">
			<span class="tree_Subtitle">数据展示>>>
			</span>
        <#--打印按钮-->
      <a href="javascript:void(-1);" onclick="dataannlysis_fx_tbhbfx.print()" class="btn btn-primary toLeft">
        <i class="fa fa-print" style="margin-top: 2.5px;margin-left: 2px;" aria-hidden="true"></i>&nbsp;打印
      </a>
    </div>
    <table id="tbhbfxTable" class="table table-bordered"
           style="white-space: nowrap;  overflow-x: scroll; -webkit-overflow-scrolling: touch;">
      <thead>
      <tr id="tbhbfxday" class="header_color">
      </tr>
      </thead>
      <tbody id='tbhbfx_body'>
      </tbody>
    </table>
  </div>
</div>
<!-- 右侧内容模块模块end -->

<!-- 时间范围工具 -->
<script src="${ctx}/static/js/time_range.js"></script>

<script type="text/javascript">
  ;
  var dataannlysis_fx_tbhbfx = (function ($, window, document, undefined) {

    var _fnybh = '';//能源类型
    var _ctx = '${ctx}';
    var type = "0";//对比形式
    var qstjfx_time_group = "1";//时间类型
    var tableType = "";//图标类型
    var qstjfx_dw_group = "0";//单位换算类型
    var cascadeType = true;//是否级联
    var isFistSelect = true;
    var checkedGnbh = [];//单选框选中的节点
    var timeRange = '2';

		var checkNodes = [];//选中的节点数组
		var deWhetherToManClick = true;//判断是否手动点击树节点

    $(function () {
      var tbhbfx_group_id = ['0', '1', '2',  '3', '4', '5', '6', '7', '8', '9', '10'];
      var tbhbfx_group_val = ['本日', '本周', '本月',  '本季', '本年', '上天', '上周', '上月', '上季', '上年', '自定义'];
      tbhbfx_group_select('#tbhbfx_group', tbhbfx_group_id, tbhbfx_group_val);

      var tbhbfx_dw_group_id = ['0', '1', '2', '3', '4', '5', '6', '7'];
      var tbhbfx_dw_group_val = ['总能耗(Kwh)', '二氧环碳(ppm)', '总金额(元)', '耗煤量(吨)', '人均能耗(Kwh)', '人均金额(元)', '单位面积能耗(Kwh)', '单位面积金额(元)'];
      tbhbfx_dw_group_select('#tbhbfx_dw_group', tbhbfx_dw_group_id, tbhbfx_dw_group_val);

      var tb_idArray = ['bar', 'line'];
      var tb_valArray = ['柱状图', '曲线图'];
      tblx_select(tb_idArray, tb_valArray);

      var tbhbfx_time_group_id = ['1', '0', '2', '3'];
      var tbhbfx_time_group_val = ['日', '时', '月', '年'];
      tbhbfx_time_group_select('#tbhbfx_time_group', tbhbfx_time_group_id, tbhbfx_time_group_val);

      var tbhbfx_compare_group_id = ['0', '1'];
      var tbhbfx_compare_group_val = ['同比', '环比'];
      tbhbfx_compare_group_select('#tbhbfx_compare_group', tbhbfx_compare_group_id, tbhbfx_compare_group_val);

      $('#tbhbfx_sametime_start_time').attr('disabled', 'disabled');
      $('#tbhbfx_sametime_end_time').attr('disabled', 'disabled');
      $("#tbhbfx_sametime_start_time,#tbhbfx_sametime_end_time").removeAttr("cursor").css("cursor", "not-allowed");

      getTabs();
      // qstjfx_tree(cascadeType, isFistSelect, checkedGnbh);
      getHeight();
    });

    //实例化日期范围selected
    function tbhbfx_group_select(id, idArray, valArray) {
      //选择电表下拉列表 空间选择
      $(id).ISSPSpinnerBox({
        width: '9vw',//下拉列表宽度
        height: '2.9vh',//下拉列表高度
        margLeft: '0px',//margin-left属性
        isHasData: true,
        idArray: idArray,//id
        valArray: valArray,//txt
        isNoSelectedText: false, //是否设置未选中提示文本
        callBack: timeChange,
        liveSearch: false
      });
    }


    //实例化单位换算selected
    function tbhbfx_dw_group_select(id, idArray, valArray) {
      //选择电表下拉列表 空间选择
      $(id).ISSPSpinnerBox({
        width: '9vw',//下拉列表宽度
        height: '2.9vh',//下拉列表高度
        margLeft: '0px',//margin-left属性
        isHasData: true,
        idArray: idArray,//id
        valArray: valArray,//txt
        isNoSelectedText: false, //是否设置未选中提示文本
        callBack: dwChange,
        liveSearch: false

      });
    }

    function getHeight() {
      //获取左侧高度
      var allheight = $("#tbhbfx_div").height();//总高度
      var tbhbfx_con = $("#tbhbfx_con").height();
      var num = $(".search_tbhbfx_div_style").length;
      var bottom = $("#tbhbfx_bottom").height();
      var tj = $(".search_tbhbfx_div_style").outerHeight() - 1.2;
      var s = allheight - (num * tj) - bottom - tbhbfx_con;
      $("#tree_tbhbfx").height(s);
    }

    //实例化时间颗粒度selected
    function tbhbfx_time_group_select(id, idArray, valArray) {
      //选择电表下拉列表 空间选择
      $(id).ISSPSpinnerBox({
        width: '9vw',//下拉列表宽度
        height: '2.9vh',//下拉列表高度
        margLeft: '0px',//margin-left属性
        isHasData: true,
        idArray: idArray,//id
        valArray: valArray,//txt
        isNoSelectedText: false, //是否设置未选中提示文本
        callBack: timeUnitChange,
        liveSearch: false
      });
    }

    //图标初始化selected
    function tblx_select(tb_idArray, tb_valArray) {
      $("#tbhbfx_table_group").ISSPSpinnerBox({
        width: '9vw',//下拉列表宽度
        height: '2.9vh',//下拉列表高度
        margLeft: '0%',//margin-left属性
        isHasData: true,
        idArray: tb_idArray,//id
        valArray: tb_valArray,//txt
        isNoSelectedText: false, //是否设置未选中提示文本
        callBack: tbChange,  //自定义事件
        liveSearch: false
      });
    }

		//图表改变事件
    function tbChange(sp) {
      tableType = sp.id;//每次改变赋值给tableType
    }

    //实例化对比形式selected
    function tbhbfx_compare_group_select(id, idArray, valArray) {
      //选择电表下拉列表 空间选择
      $(id).ISSPSpinnerBox({
        width: '9vw',//下拉列表宽度
        height: '2.9vh',//下拉列表高度
        margLeft: '0px',//margin-left属性
        isHasData: true,
        idArray: idArray,//id
        valArray: valArray,//txt
        isNoSelectedText: false, //是否设置未选中提示文本
        callBack: compareUnitChange,
        liveSearch: false
      });
    }


    //时间单位改变方法
    function timeUnitChange(sp) {
      qstjfx_time_group = sp.id;
    }

    //单位换算改变方法
    function dwChange(sp) {
      qstjfx_dw_group = sp.id;
    }

    //对比形式改变方法
    function compareUnitChange(sp) {
      type = sp.id;
			if (timeRange === "2") {//本月
				let time = getCurrentMonth();
				compareChange(time[0],time[1]);
			} else {
				let bqstart = $("#tbhbfx_start_time").val();
				let bqend = $("#tbhbfx_end_time").val();
				bqstart = parserDate(bqstart);
				bqend = parserDate(bqend);
				bqend = new Date(bqend.getTime()  + 12*60*59*1000);
				compareChange(bqstart, bqend);
			}
      // compareChange();
    }
		//将字符串格式时间转换成date类型
		function parserDate(date) {
			var t = Date.parse(date);
			if (!isNaN(t)) {
				return new Date(Date.parse(date.replace(/-/g, "/")));
			} else {
				return new Date();
			}
		}

    //实现日期范围和时间颗粒相关联
    function timeChange(sp) {
      $("#tbhbfx_start_time,#tbhbfx_end_time").removeAttr("cursor").css("cursor", "not-allowed");
      var range = sp.id;
      timeRange = sp.id;
      $('#tbhbfx_start_time').attr('disabled', 'disabled');
      $('#tbhbfx_end_time').attr('disabled', 'disabled');
      switch (range) {
        case '0':
          var today = getCurrentDate();
          $('#tbhbfx_start_time').val(getFormatDate(today));
          $('#tbhbfx_end_time').val(getFormatDate(today));
					let starttime = getCurrentDate();//当前日期
					let endtime = getCurrentDate();//当前日期
					compareChange(starttime, endtime);
          break;
        case '1':
          // var thisWeek = getCurrentWeek();
          // $('#tbhbfx_start_time').val(getFormatDate(thisWeek[0]));
          // $('#tbhbfx_end_time').val(getFormatDate(thisWeek[1]));

					var thisWeek = getCurrentWeek();
					$('#tbhbfx_start_time').val(getFormatDate(thisWeek[0]));
					$('#tbhbfx_end_time').val(getFormatDate(thisWeek[1]));
					let weakstart = thisWeek[0] - (thisWeek[0].getHours() * 60 * 60 * 1000 + thisWeek[0].getMinutes() * 60 * 1000 + thisWeek[0].getSeconds() * 1000);
					weakstart = new Date(weakstart);
					compareChange(weakstart, thisWeek[1]);
          break;

        case '2':
          var thismouth = getCurrentMonth();
          $('#tbhbfx_start_time').val(getFormatDate(thismouth[0]));
          $('#tbhbfx_end_time').val(getFormatDate(thismouth[1]));
					compareChange(thismouth[0], thismouth[1]);
          break;

        case '3':
          var thisSeason = getCurrentSeason();
          $('#tbhbfx_start_time').val(getFormatDate(thisSeason[0]));
          $('#tbhbfx_end_time').val(getFormatDate(thisSeason[1]));
					compareChange(thisSeason[0], thisSeason[1]);
          break;

        case '4':
          var thisYear = getCurrentYear();
          $('#tbhbfx_start_time').val(getFormatDate(thisYear[0]));
          $('#tbhbfx_end_time').val(getFormatDate(thisYear[1]));
					compareChange(thisYear[0], thisYear[1]);
          break;

        case '5':
          // var lastDay = getPreviousDate();
          // $('#tbhbfx_start_time').val(getFormatDate(lastDay));
          // $('#tbhbfx_end_time').val(getFormatDate(lastDay));

					let todaystart =  getPreviousDate();
					let lastdaystart = getPreviousDate();
					$('#tbhbfx_start_time').val(getFormatDate(todaystart));
					$('#tbhbfx_end_time').val(getFormatDate(lastdaystart));
					compareChange(todaystart, lastdaystart);
          break;

        case '6':
          // var lastWeek = getPreviousWeek();
          // $('#tbhbfx_start_time').val(getFormatDate(lastWeek[0]));
          // $('#tbhbfx_end_time').val(getFormatDate(lastWeek[1]));
					var lastWeek = getPreviousWeek();
					$('#tbhbfx_start_time').val(getFormatDate(lastWeek[0]));
					$('#tbhbfx_end_time').val(getFormatDate(lastWeek[1]));

					let lastweakstart = lastWeek[0] - (lastWeek[0].getHours() * 60 * 60 * 1000 + lastWeek[0].getMinutes() * 60 * 1000 + lastWeek[0].getSeconds() * 1000);
					lastweakstart = new Date(lastweakstart);
					let lastweakend = lastWeek[1] - (lastWeek[1].getHours() * 60 * 60 * 1000 + lastWeek[1].getMinutes() * 60 * 1000 + lastWeek[1].getSeconds() * 1000);
					lastweakend = new Date(lastweakend + 23 * 59 * 59 * 1000);
					compareChange(lastweakstart, lastweakend);
          break;

        case '7':
          var lastMouth = getPreviousMonth();
          $('#tbhbfx_start_time').val(getFormatDate(lastMouth[0]));
          $('#tbhbfx_end_time').val(getFormatDate(lastMouth[1]));
					compareChange(lastMouth[0], lastMouth[1]);
          break;

        case '8':
          var lastSeason = getPreviousSeason();
          $('#tbhbfx_start_time').val(getFormatDate(lastSeason[0]));
          $('#tbhbfx_end_time').val(getFormatDate(lastSeason[1]));
					compareChange(lastSeason[0], lastSeason[1]);
          break;

        case '9':
          var lastYear = getPreviousYear();
          $('#tbhbfx_start_time').val(getFormatDate(lastYear[0]));
          $('#tbhbfx_end_time').val(getFormatDate(lastYear[1]));
					compareChange(lastYear[0], lastYear[1]);
          break;
        case '10':
          $("#tbhbfx_start_time,#tbhbfx_end_time").css("cursor", "default");
          $('#tbhbfx_start_time').attr('disabled', false);
          $('#tbhbfx_end_time').attr('disabled', false);
          break;
      }
      // compareChange();

    }

    //对比形式变化
    function compareChange(start, end) {

			//1. 同比状态
			if (type == '0') {//同比
				if (start != null) {
					start.setFullYear(start.getFullYear() - 1);
				}
				if (end != null) {
					end.setFullYear(end.getFullYear() - 1);
				}
				$("#tbhbfx_sametime_start_time").val(getFormatDate(start));
				$("#tbhbfx_sametime_end_time").val(getFormatDate(end));

			} else if (type == '1') {//环比
				if (start != null && end != null) {

					if (start.getTime() == end.getTime()) {
						start.setTime(start.getTime() - 24 * 60 * 60 * 1000);
						end.setTime(start.getTime());
					} else {

						if (timeRange == "3") {
							let lastSeason = getPreviousSeason();
							start = lastSeason[0];
							end = lastSeason[1];
						} else if (timeRange == "4") {
							start.setFullYear(start.getFullYear() - 1);
							end.setFullYear(end.getFullYear() - 1);
						} else if (timeRange == "7") {
							let lastTwoMonth = getPreviousTwoMonth();
							start = lastTwoMonth[0];
							end = lastTwoMonth[1];
						} else if (timeRange == "8") {
							let lastTwoSeason = getPreviousTwoSeason();
							start = lastTwoSeason[0];
							end = lastTwoSeason[1];
						} else if (timeRange == "9") {
							let lastTwoSeason = getTwoPreviousYear();
							start = lastTwoSeason[0];
							end = lastTwoSeason[1];
						}  else if(timeRange === "1" || timeRange === "6"){
                            //本周、上周
                            end.setTime(start.getTime() - 24 * 60 * 60 * 1000);
                            start.setTime(start.getTime() - 7 * 24 * 60 * 60 * 1000);
                        }else if(timeRange === "2"){
						    //本月
							end.setTime(start.getTime() - 24 * 60 * 60 * 1000);
                            start.setMonth(start.getMonth() - 1);
							//var t = 2 * start.getTime() - end.getTime();
							// start.setTime(t);
						}else if(timeRange === "0" || timeRange === "5"){
                            //本日、上日
                            start.setDate(start.getDate() - 1);
                            end.setDate(end.getDate() - 1);
                        }

					}
					$("#tbhbfx_sametime_start_time").val(getFormatDate(start));
					$("#tbhbfx_sametime_end_time").val(getFormatDate(end));
				}
			} else {//自定义
				var startCustom = $("#tbhbfx_sametime_start_time").val();
				if (start != null && end != null && startCustom != null) {
					var t = startCustom.getTime() + end.getTime() - start.getTime();
					$("#tbhbfx_sametime_end_time").val(t);
					$("#tbhbfx_sametime_end_time").val(getFormatDate(end));
				}
			}

     /* tbhbfx_start_time = $('#tbhbfx_start_time').val();//本期开始时间
      tbhbfx_end_time = $('#tbhbfx_end_time').val();//本期结束时间
      var start = new Date(tbhbfx_start_time);
      var end = new Date(tbhbfx_end_time);
      // 同比分析
      if (type == 0) {
        start.setFullYear(start.getFullYear() - 1);
        $('#tbhbfx_sametime_start_time').val(getFormatDate(start));
        end.setFullYear(end.getFullYear() - 1);
        $('#tbhbfx_sametime_end_time').val(getFormatDate(end));
      }
      // 环比分析
      if (type == 1) {
        var t = 2 * start.getTime() - end.getTime();

        if (start.getTime() == end.getTime()) {
          start
              .setTime(start.getTime() - 24 * 60 * 60
                  * 1000);
          end.setTime(start.getTime());
        } else {
          end.setTime(start.getTime());
          start.setTime(t);
        }
        $('#tbhbfx_sametime_start_time').val(getFormatDate(start));
        $('#tbhbfx_sametime_end_time').val(getFormatDate(end));
      }
      //自定义
      if (type == 2) {
        var startCustom = new Date($('#tbhbfx_sametime_start_time').val());
        var t = startCustom.getTime() + end.getTime()
            - start.getTime();
        end.setTime(t);
        $('#tbhbfx_sametime_end_time').val(getFormatDate(end));
        $('#tbhbfx_sametime_start_time').attr('disabled', false);
        $("#tbhbfx_sametime_start_time").css("cursor", "default");
      }*/

    }


    //获取tab页
    function getTabs() {
      $.ajax({
        type: "post",
        url: "${ctx}/view/basedatamanage/energyinformation/getenrrgylist",
        dataType: "json",
        async: false,
        data: ({
          f_yqbh: '0000'
        }),
        success: function (result) {

          if (result.hasOwnProperty("list")) {//判断result返回结果是否包含list
            if (result.list.length > 0) {//如果包含判断是否长度大于0
              _fnybh = result.list[0].fnybh;//默认能源类型
              for (var i = 0; i < result.list.length; i++) {
                var treeNode = result.list[i];
                if (i == 0) {
                  $("#tbhbfx_Tab").append("<li class='active nocancel' ><a  data-toggle='tab' href='#'  data='" + treeNode.fnybh + "'>" + treeNode.fnymc + "</a></li>");
                } else {
                  $("#tbhbfx_Tab").append("<li ><a  data-toggle='tab' href='#'   data='" + treeNode.fnybh + "'>" + treeNode.fnymc + "</a></li>");
                }
              }
							qstjfx_tree(cascadeType, false, checkedGnbh);
            }
            //点击tab,支路树变化
            $("#tbhbfx_Tab a").click(function () {
              $(this.parentNode).addClass("nocancel").siblings("li").removeClass("nocancel");
              _fnybh = $(this).attr("data");
              $('#tree_tbhbfx').treeview('uncheckAll', {silent: true});
              qstjfx_tree(cascadeType, false, checkedGnbh);
              var dom = document.getElementById("tbhbfx_chart");
              var myChart = echarts.init(dom, "light");
              myChart.clear();
              $('#tbhbfxTable').fixedThead('destroy');//销毁
              $('#tbhbfxday').html("");
              $('#tbhbfx_body').html("");
            });
          }
        },
        error: function (nodeData) {
          swal(nodeData.msg, "", "error");
        }
      });
    }

    //是否级联 点击事件
    $("#tbhbfxCascade").click(function () {
      if ($('#tbhbfxCascade').is(':checked')) {
        cascadeType = true;
        isFistSelect = false;
				deWhetherToManClick = true;
        //处理点击是否级联复选框时，先获取所有被选的复选框
        checkedGnbh = [];
        checkedGnbh = $('#tree_tbhbfx').treeview('getChecked');
        // qstjfx_tree(cascadeType, isFistSelect, checkedGnbh);
      } else {
        cascadeType = false;
        isFistSelect = false;
				deWhetherToManClick = false;
        //处理点击是否级联复选框时，先获取所有被选的复选框
        checkedGnbh = [];
        checkedGnbh = $('#tree_tbhbfx').treeview('getChecked');
        // qstjfx_tree(cascadeType, isFistSelect, checkedGnbh);
      }
    });


    //生成分项名称树
    function qstjfx_tree(cascadeType, isFistSelect, checkedGnbh) {
      $.ajax({
        type: "post",
        url: "${ctx}/view/basedatamanage/energyinformation/subitem_treegrid",
        dataType: "json",
        async: false,
        data: ({
          fNybh: _fnybh
        }),
        success: function (result) {
          //初始加载根节点
          if (result.hasOwnProperty("list")) {//判断result返回结果是否包含list
            if (result.list.length > 0) {//如果包含判断是否长度大于0
              $('#tree_tbhbfx').treeview({
								data: result.list,         // 数据源
								highlightSelected: true,    //是否高亮选中
								levels: 2,
								enableLinks: true,//必须在节点属性给出href属性
								wrapNodeText: true,
								color: "#4a4747",
								showCheckbox: true,
								// hierarchicalCheck: cascadeType,//级联勾选
								propagateCheckEvent: true,
								onNodeChecked: function (event, nodeData) {//选中方法
									//级联的情况下,选中时默认将子节点和父节点选中（级联的情况下,不级联的时候默认选中选择的节点）
									if (deWhetherToManClick) {
										deWhetherToManClick = false;//判断是否手动点击树节点(点击过后首先设置为false)
										nodeChecked(nodeData);
									}
								},
								onNodeUnchecked: function (event, nodeData) {//取消方法
									if (deWhetherToManClick) {
										deWhetherToManClick = false;//判断是否手动点击树节点(点击过后首先设置为false)
										unnodeChecked(nodeData);
									}
								},
              });
              /*if (isFistSelect == true) {
                var firstNode = $("#tree_tbhbfx").treeview('findNodes', [result.list[0].id, 'id']);
                var node = $("#tree_tbhbfx").treeview('findNodes', [firstNode[0].id, 'id']);
                $('#tree_tbhbfx').treeview('checkNode', [node, {silent: false}]);
                for (var i = 3; i < node.length; i++) {
                  var uncheckNode = $("#tree_tbhbfx").treeview('findNodes', [node[i].id, 'id']);
                  $('#tree_tbhbfx').treeview('uncheckNode', [uncheckNode, {silent: false}]);
                }
              }
              //点击不级联时，父级取消勾选
              if (cascadeType == false) {
                var chechedNodes = [];
                for (var i = 0; i < checkedGnbh.length; i++) {
                  if (checkedGnbh[i].level != 1 && checkedGnbh[i].level != 2) {
                    var cNode = $('#tree_tbhbfx').treeview('findNodes', [checkedGnbh[i].id, 'id']);
                    var parentNode = $('#tree_tbhbfx').treeview('findNodes', [checkedGnbh[i].pid, 'id']);
                    chechedNodes.push(cNode);
                    $("#tree_tbhbfx").treeview('uncheckNode', [parentNode, {silent: true}]);

                  }
                }
                for (var i = 0; i < chechedNodes.length; i++) {
                  $("#tree_tbhbfx").treeview('checkNode', [chechedNodes[i], {silent: true}]);
                }

              }

              //点击级联时，父级恢复勾选
              if (cascadeType == true && isFistSelect == false) {
                for (var i = 0; i < checkedGnbh.length; i++) {
                  $("#tree_tbhbfx").treeview('checkNode', [checkedGnbh[i], {silent: true}]);
                  var parentNode = $('#tree_tbhbfx').treeview('findNodes', [checkedGnbh[i].pid, 'id']);
                  $("#tree_tbhbfx").treeview('checkNode', [parentNode, {silent: true}]);
                  var ppnode = $('#tree_tbhbfx').treeview('findNodes', [parentNode[0].pid, 'id']);
                  $("#tree_tbhbfx").treeview('checkNode', [ppnode[0], {silent: true}]);
                }

                var nodes = [];
                //去除联动勾选的数据

                var cancleChecks = $('#tree_tbhbfx').treeview('getChecked');

                for (var i = 0; i < cancleChecks.length; i++) {
                  var obj = cancleChecks[i];
                  var oid = obj.id;
                  var isExist = false;
                  for (var j = 0; j < checkedGnbh.length; j++) {
                    var aj = checkedGnbh[j];
                    var nid = aj.id;
                    if (nid == oid || obj.level == 1 || obj.level == 2) {
                      isExist = true;
                      break;
                    }
                  }
                  if (!isExist) {
                    nodes.push(obj);
                  }
                }
                for (var i = 0; i < nodes.length; i++) {
                  $("#tree_tbhbfx").treeview('uncheckNode', [nodes[i], {silent: true}]);
                }

              }*/

            }
          } else {
            swal({
              title : '当前能源下暂无支路配置!',// 展示的标题
              text : "",// 内容
              type : "warning",
              showCloseButton : false, // 展示关闭按钮
              allowOutsideClick : false,
              showConfirmButton : false,
              timer : 1000
            });
            $('#tree_tbhbfx').treeview({
              data: "[]",
            });
          }
        },
        error: function (nodeData) {
          swal(nodeData.msg, "", "error");
        }
      });
    }

		//选中方法
		function nodeChecked(nodeData) {
			let childNodes = [];//选中节点的子节点集合
			checkNodes.length = 0;//清空选中的节点的数组

			//获取设备树所有节点
			let allNodes = $("#tree_tbhbfx").treeview('getNodes');

			if (cascadeType) {//级联
				//获取所有选中的节点
				checkNodes = $("#tree_tbhbfx").treeview('getChecked');
				//获取父节点
				let fatherNodeId = nodeData.pid;
				allNodes.forEach((node,i) => {
					if (node.nodeTreeId == fatherNodeId) {
						fatherNodeId = node;
						fatherNodes(fatherNodeId,allNodes);
					}
				})

				//获取子节点(如果有的话)
				if (Array.isArray(nodeData.nodes)) {
					childNodes = nodeData.nodes;
					childNodesFunction(childNodes,allNodes);
				}

				checkNodes.forEach((node,i) =>{
					$('#tree_tbhbfx').treeview('checkNode', [node, {silent: false}]);
				})
			}
			deWhetherToManClick = true;//判断是否手动点击树节点(点击的逻辑走完后,设置成true)
		}

		//获取父节点集合，将父节点集合放到选中的节点集合里面
		function fatherNodes(fatherNodeId,allNodes) {
			checkNodes.push(fatherNodeId);
			let result = [];
			let obj = {};
			for(var i =0; i<checkNodes.length; i++){
				if(!obj[checkNodes[i].nodeTreeId]){
					result.push(checkNodes[i]);
					obj[checkNodes[i].nodeTreeId] = true;
				}
			}
			checkNodes = result;
			//判断父节点是否含有父节点
			if (typeof fatherNodeId.pid != 'undefined') {//有的话,递归
				allNodes.forEach((node,i) => {
					if (node.nodeTreeId == fatherNodeId.pid) {
						fatherNodeId = node;
						fatherNodes(fatherNodeId,allNodes);
					}
				})
			}
		}

		//获取子节点集合，将子节点集合放到选中的节点集合里面
		function childNodesFunction(childNodes,allNodes) {
			//遍历子节点集合,判断子节点中是否含有子节点
			childNodes.forEach((childNode,i) => {
				checkNodes.push(childNode);
				if (Array.isArray(childNode.nodes)) {
					childNodesFunction(childNode.nodes,allNodes);
				}
			})
			let result = [];
			let obj = {};
			for(var i =0; i<checkNodes.length; i++){
				if(!obj[checkNodes[i].nodeTreeId]){
					result.push(checkNodes[i]);
					obj[checkNodes[i].nodeTreeId] = true;
				}
			}
			checkNodes = result;
		}

		//取消方法
		function unnodeChecked(nodeData) {

			let childNodes = [];//选中节点的子节点集合
			checkNodes.length = 0;//清空选中的节点的数组

			//获取设备树所有节点
			let allNodes = $("#tree_tbhbfx").treeview('getNodes');

			if (cascadeType) {//级联
				//获取所有选中的节点
				checkNodes = $("#tree_tbhbfx").treeview('getChecked');
				//获取父节点
				let fatherNodeId = nodeData.pid;
				allNodes.forEach((node,i) => {
					if (node.nodeTreeId == fatherNodeId) {
						fatherNodeId = node;
						unfatherNodes(fatherNodeId,allNodes);
					}
				})

				//获取子节点(如果有的话)
				if (Array.isArray(nodeData.nodes)) {
					childNodes = nodeData.nodes;
					unchildNodesFunction(childNodes,allNodes);
				}

				checkNodes.forEach((node,i) =>{
					$('#tree_tbhbfx').treeview('checkNode', [node, {silent: false}]);
				})
			}
			deWhetherToManClick = true;//判断是否手动点击树节点(点击的逻辑走完后,设置成true)
		}

		//获取父节点集合
		function unfatherNodes(fatherNodeId,allNodes) {
			checkNodes.splice(fatherNodeId);
			$('#tree_tbhbfx').treeview('uncheckNode', [fatherNodeId, {silent: true}]);
			//判断父节点是否含有父节点
			if (typeof fatherNodeId.pid != 'undefined') {//有的话,递归
				allNodes.forEach((node,i) => {
					if (node.nodeTreeId == fatherNodeId.pid) {
						fatherNodeId = node;
						unfatherNodes(fatherNodeId,allNodes);
					}
				})
			}
		}

		//获取子节点集合
		function unchildNodesFunction(childNodes,allNodes) {
			//遍历子节点集合,判断子节点中是否含有子节点
			childNodes.forEach((childNode,i) => {
				checkNodes.splice(childNode);
				$('#tree_tbhbfx').treeview('uncheckNode', [childNode, {silent: true}]);
				// checkNodes.push(childNode);
				if (Array.isArray(childNode.nodes)) {
					unchildNodesFunction(childNode.nodes,allNodes);
				}
			})
		}

		function time_csh() {

			//填加默认时间  先判断对比形式
			// var time = getCurrentDate();//获取当前时间
			// var qntime = getPreviouDate();//去年当前时间
			if (type == '0') {//同比

				//获取当天0点的时间戳
				let start = new Date(new Date(new Date().toLocaleDateString()).getTime());
				//获取现在的时间
				let time = getCurrentDate();//当前日期
				$('#tbhbfx_start_time').val(getFormatDate(start));
				$('#tbhbfx_end_time').val(getFormatDate(time));


				// var week = getCurrentWeek();
				// $('#zl_tbhbfxdw_bq_start_time').val(getFormatDate(week[0]));
				// $('#zl_tbhbfxdw_bq_end_time').val(getFormatDate(week[1]));
				compareChange(start, time);
				$("#tbhbfx_start_time,#tbhbfx_end_time").removeAttr("cursor").css("cursor", "not-allowed");
			}
		}
    return {
      //对比形式变化
      compareChange: function () {
				let bqstart = $("#tbhbfx_start_time").val();
				let bqend = $("#tbhbfx_end_time").val();
				bqstart = parserDate(bqstart);
				bqend = parserDate(bqend);
				if (type == '0') {//同比
					bqstart.setFullYear(bqstart.getFullYear() - 1);
					bqend.setFullYear(bqend.getFullYear() - 1);
				} else if (type == '1') {//环比
					bqstart.setFullYear(bqstart.getFullYear() - 1);
					bqend.setFullYear(bqend.getFullYear() - 1);
				}
				$("#tbhbfx_sametime_start_time").val(getFormatDate(bqstart));
				$("#tbhbfx_sametime_end_time").val(getFormatDate(bqend));

       /* tbhbfx_start_time = $('#tbhbfx_start_time').val();//本期开始时间
        tbhbfx_end_time = $('#tbhbfx_end_time').val();//本期结束时间
        var start = new Date(tbhbfx_start_time);
        var end = new Date(tbhbfx_end_time);
        // 同比分析
        if (type == 0) {
          start.setFullYear(start.getFullYear() - 1);
          $('#tbhbfx_sametime_start_time').val(getFormatDate(start));
          end.setFullYear(end.getFullYear() - 1);
          $('#tbhbfx_sametime_end_time').val(getFormatDate(end));

        }
        // 环比分析
        if (type == 1) {
          var t = 2 * start.getTime() - end.getTime();

          if (start.getTime() == end.getTime()) {
            start
                .setTime(start.getTime() - 24 * 60 * 60
                    * 1000);
            end.setTime(start.getTime());
          } else {
            end.setTime(start.getTime());
            start.setTime(t);
          }
          $('#tbhbfx_sametime_start_time').val(getFormatDate(start));
          $('#tbhbfx_sametime_end_time').val(getFormatDate(end));
        }
        //自定义
        if (type == 2) {
          var startCustom = new Date($('#tbhbfx_sametime_start_time').val());
          var t = startCustom.getTime() + end.getTime()
              - start.getTime();
          end.setTime(t);
          $('#tbhbfx_sametime_end_time').val(getFormatDate(end));
          $('#tbhbfx_sametime_start_time').attr('disabled', false);

        }*/

      },
      //当时间单位为时时获取数据
      getHourTableData: function () {
        var dom = document.getElementById("tbhbfx_chart");
        var myChart = echarts.init(dom, "light");
        myChart.clear();
        $('#tbhbfxday').html("");
        $('#tbhbfx_body').html("");
        var qstjfx_start_time = $('#tbhbfx_start_time').val();//开始时间
        var qstjfx_end_time = $('#tbhbfx_end_time').val();//结束时间
        var checkedGnbh = $('#tree_tbhbfx').treeview('getChecked');
        var ftbhb_sametime_start = $('#tbhbfx_sametime_start_time').val();//同期开始时间
        var ftbhb_sametime_end = $('#tbhbfx_sametime_end_time').val();//同期结束时间
        //获取选中的树节点
        var checkedGnbh = $('#tree_tbhbfx').treeview('getChecked');
        var allTime = [];//存取所有时间
        var series = []; //echarts列表
        var seriesMap = {};//echarts数据map
        var seriesData = [];//echarts具体每个支路数据
        var chartXdata = [];//charts图表横坐标
        var x_unit = "";//echarts横坐标单位
        var y_unit = "";//echarts纵坐标单位
        //事假判断空和合法性处理
        if (!timeFormat()) {
          return;
        }
        //判断左边树的复选框
        var nodetreeIds = [];
        var nodeNames = [];
        for (var i = 0; i < checkedGnbh.length; i++) {
          var nodetreeId = checkedGnbh[i].nodeTreeId;
          nodetreeIds.push(nodetreeId);

        }
        if (nodetreeIds.length == 0) {
          swal({
            title : '当前未选择支路!',// 展示的标题
            text : "",// 内容
            type : "warning",
            showCloseButton : false, // 展示关闭按钮
            allowOutsideClick : false,
            showConfirmButton : false,
            timer : 1000
          });
          return;
        }

        $.ajax({
          type: "post",
          url: "${ctx}/view/dataAnalysis/getTbhbSubitemData",
          dataType: "json",
          async: true,
          traditional: true,
          data: ({
            "fType": qstjfx_time_group,
            "fCjsj_start": qstjfx_start_time,
            "fCjsj_end": qstjfx_end_time,
            "ftbhb_sametime_start": ftbhb_sametime_start,
            "ftbhb_sametime_end": ftbhb_sametime_end,
            "fFxbhs": nodetreeIds
          }),
          beforeSend: function () {
            showLoad();
          },
          success: function (result) {
            if (result.hasOwnProperty("map")
                && result.map.time.length > 0) {
              $('#tbhbfxTable').fixedThead('destroy');//销毁

              //获取所有分项名称，echarts使用
              var fxNames = result.map['brach'];
              for (var i = 0; i < fxNames.length; i++) {
                nodeNames.push(fxNames[i].fFxmc + "本期");
                nodeNames.push(fxNames[i].fFxmc + "同期");

              }
              //拼接表头时间
              var time = result.map['time'];
              var qstjfxdaydata = "<th  class='tbhbfhFiHead' style='width:20%' colspan='2' >名称</th>";
              for (var i = 0; i < time.length; i++) {
                if (qstjfx_time_group == '0') {
                  x_unit = "时";
                  qstjfxdaydata += "<th  class='tbhbfhFiHead'>" +
                      time[i].fCjsj.substring(5, 13) + "</th>";
                  chartXdata.push(time[i].fCjsj.substring(5, 13).split(" ")[1]);
                }

                if (qstjfx_time_group == '1') {
                  x_unit = "天";
                  qstjfxdaydata += "<th  class='tbhbfhFiHead'>" +
                      time[i].fCjsj.substring(0, 10) + "</th>";
                  chartXdata.push(time[i].fCjsj.substring(0, 10).split("-")[2]);
                }

                if (qstjfx_time_group == '2') {
                  x_unit = "月";
                  qstjfxdaydata += "<th  class='tbhbfhFiHead'>" +
                      time[i].fCjsj.substring(0, 7) + "</th>";
                  chartXdata.push(time[i].fCjsj.substring(0, 7).split("-")[1]);
                }

                if (qstjfx_time_group == '3') {
                  x_unit = "年";
                  qstjfxdaydata += "<th  class='tbhbfhFiHead'>" +
                      time[i].fCjsj.substring(0, 4) + "</th>";
                  chartXdata.push(time[i].fCjsj.substring(0, 4));
                }

                allTime.push(time[i].fCjsj);
              }
              $('#tbhbfxday').html(qstjfxdaydata);
              var tdData = "";
              var seriesData = [];
              for (var i = 0; i < nodetreeIds.length; i++) {

                if (result.map[nodetreeIds[i]] != null && result.map[nodetreeIds[i]].length != 0) {
                  tdData += "<tr ><td class='tbhbfhFiHead' rowspan='2' style='text-align:center;vertical-align:middle;'>" + result.map[nodetreeIds[i]][0].fFxmc + "</td><td class='tbhbfhFiHead'>本期</td>"
                  var tdList = result.map[nodetreeIds[i]];//本期数据集合
                  var sametdKList = result.map[nodetreeIds[i] + "_same"];//同期数据集合

                  for (var j = 0; j < allTime.length; j++) {
                    var flag = '0';
                    var data = '';

                    for (var c = 0; c < tdList.length; c++) {
                      seriesData = [];
                      if (tdList[c].fCjsj == allTime[j]) {
                        flag = '1';
                        if (qstjfx_dw_group == '0') {
                          y_unit = "Kwh";
                          data = tdList[c].fData || '0.0';
                        }
                        if (qstjfx_dw_group == '1') {
                          y_unit = "ppm";
                          data = tdList[c].fCo2 || '0.0';
                        }
                        if (qstjfx_dw_group == '2') {
                          y_unit = "元";
                          data = tdList[c].fAllMoney || '0.0';
                        }
                        if (qstjfx_dw_group == '3') {
                          y_unit = "吨";
                          data = tdList[c].fCoalAmount || '0.0';
                        }
                        if (qstjfx_dw_group == '4') {
                          y_unit = "Kwh";
                          data = tdList[c].fPercapitaEnergy || '0.0';
                        }
                        if (qstjfx_dw_group == '5') {
                          y_unit = "元";
                          data = tdList[c].fPercapitaMoney || '0.0';
                        }
                        if (qstjfx_dw_group == '6') {
                          y_unit = "Kwh";
                          data = tdList[c].fUnitareaData || '0.0';
                        }
                        if (qstjfx_dw_group == '7') {
                          y_unit = "元";
                          data = tdList[c].fUnitareaMoney || '0.0';
                        }

                        break;
                      }

                    }
                    if (flag == '1') {

                      tdData += "<td class='tbhbfhFix'>" + data + "</td>";
                      seriesData.push(data);
                    } else {
                      tdData += "<td class='tbhbfhFix'>0.00</td>";
                      seriesData.push("0.00");
                    }
                    var seriesMap = {};
                    seriesMap['name'] = result.map[nodetreeIds[i]][0].fFxmc + "本期";
                    seriesMap['type'] = tableType;
                    seriesMap['smooth'] = 'true';
                    seriesMap['data'] = seriesData;
                    seriesMap['symbol'] = "roundRect";
                    seriesMap['symbolClip'] = true;
                    series.push(seriesMap);

                  }

                  tdData += "</tr> <tr><td class='tbhbfhFiHead'>同期</td>"

                  //同期数据处理在表格和echarts显示
                  for (var j = 0; j < allTime.length; j++) {
                    seriesData = [];
                    var sameflag = '0';
                    var samedata = '';
                    for (var c = 0; c < sametdKList.length; c++) {
                      var cstartTime = "";
                      var cendTime = "";
                      if (type == '0' && sametdKList[c].fCjsj != null) {

                        cstartTime = sametdKList[c].fCjsj.substring(5, 18);
                        cendTime = allTime[j].substring(5, 18);
                      } else if ((timeRange == '2' || timeRange == '7') && type == '1' && sametdKList[c].fCjsj != null) {

                        cstartTime = sametdKList[c].fCjsj.substring(8, 10);
                        cendTime = allTime[j].substring(8, 10);
                      } else if ((timeRange == '4' || timeRange == '9') && type == '1' && sametdKList[c].fCjsj != null) {

                        cstartTime = sametdKList[c].fCjsj.substring(5, 18);
                        cendTime = allTime[j].substring(5, 18);
                      } else {
                        if (sametdKList[c].fCjsj != null) {
                          cstartTime = sametdKList[c].fCjsj.substring(10, 18);
                          cendTime = allTime[j].substring(10, 18);
                        }
                      }

                      if (cstartTime != null && sametdKList[c].fCjsj != null && cstartTime == cendTime) {
                        sameflag = '1';
                        if (qstjfx_dw_group == '0') {
                          samedata = sametdKList[c].fData || '0.0';
                        }
                        if (qstjfx_dw_group == '1') {
                          samedata = sametdKList[c].fCo2 || '0.0';
                        }
                        if (qstjfx_dw_group == '2') {
                          samedata = sametdKList[c].fAllMoney || '0.0';
                        }
                        if (qstjfx_dw_group == '3') {
                          samedata = sametdKList[c].fCoalAmount || '0.0';
                        }
                        if (qstjfx_dw_group == '4') {
                          samedata = sametdKList[c].fPercapitaEnergy || '0.0';
                        }
                        if (qstjfx_dw_group == '5') {
                          samedata = sametdKList[c].fPercapitaMoney || '0.0';
                        }
                        if (qstjfx_dw_group == '6') {
                          samedata = sametdKList[c].fUnitareaData || '0.0';
                        }
                        if (qstjfx_dw_group == '7') {
                          samedata = sametdKList[c].fUnitareaMoney || '0.0';
                        }
                        break;
                      }

                    }
                    if (sameflag == '1') {
                      tdData += "<td class='tbhbfhFix'>" + samedata + "</td>";
                      seriesData.push(samedata);
                    } else {
                      tdData += "<td class='tbhbfhFix'>0.00</td>";
                      seriesData.push("0.00");
                    }
                    var seriesMap = {};
                    seriesMap['name'] = result.map[nodetreeIds[i]][0].fFxmc + "同期";
                    seriesMap['type'] = tableType;
                    seriesMap['smooth'] = 'true';
                    seriesMap['data'] = seriesData;
                    seriesMap['symbol'] = "roundRect";
                    seriesMap['symbolClip'] = true;
                    series.push(seriesMap);

                  }

                  tdData += "</tr>";
                }

              }
              $('#tbhbfx_body').html(tdData);
              $('#tbhbfxTable').fixedThead({side: '85%', body: '85%', thead: '93%', row: 1, col: 1});//固定表头和第

              //数据去重
              var echartData = [];
              var obj = {};
              for (var i = 0; i < series.length; i++) {
                if (!obj[series[i].name]) {
                  echartData.push(series[i]);
                  obj[series[i].name] = true;
                }
              }
              //合并data数据，echarts使用
              for (let i = 0; i < echartData.length; i++) {
                echartData[i].data = [];
                for (let j = 0; j < series.length; j++) {
                  if (echartData[i].name == series[j].name) {
                    var data = series[j].data[0];
                    echartData[i].data.push(data);
                  }
                }
              }

              var cols = [];
              var mytable = document.getElementById("tbhbfxTable");
              for (var i = 1, rows = mytable.rows.length; i < rows; i++) {
                for (var j = 0, cells = mytable.rows[i].cells.length; j < cells; j++) {
                  if (i % 2 == 0) {
                    cols.push(mytable.rows[i].cells[1].innerHTML);
                  } else {
                    cols.push(mytable.rows[i].cells[2].innerHTML);
                  }
                  break;
                }
              }

              for (var i = 0; i < cols.length; i++) {
                echartData[i].data[0] = cols[i];
              }

              chartShow(chartXdata, nodeNames, echartData, x_unit, y_unit);
            } else {
              swal({
                title : '没有搜索到要查找的内容!',// 展示的标题
                text : "",// 内容
                type : "warning",
                showCloseButton : false, // 展示关闭按钮
                allowOutsideClick : false,
                showConfirmButton : false,
                timer : 1000
              });
            }


          },
          complete: function () {
            hiddenLoad();
          }


        });


      },
      reset: function () {
        var qstjfh_group_id = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
        var qstjfh_group_val = ['本天', '本周', '本月', '本季', '本年', '上天', '上周', '上月', '上季', '上年', '自定义'];
        $("#tbhbfx_group").ISSPSpinnerBox({
          width: '9vw',//下拉列表宽度
          height: '2.9vh',//下拉列表高度
          margLeft: '0px',//margin-left属性
          isHasData: true,
          selId: '10',
          idArray: qstjfh_group_id,//id
          valArray: qstjfh_group_val,//txt
          isNoSelectedText: false, //是否设置未选中提示文本
          callBack: timeChange,
        });
        $('#tbhbfx_start_time').attr('disabled', false);
        $('#tbhbfx_end_time').attr('disabled', false);
        $("#tbhbfx_start_time,#qtbhbfx_end_time").css("cursor", "default");
        $('#tbhbfx_start_time').val("");
        $('#tbhbfx_end_time').val("");
        var dom = document.getElementById("tbhbfx_chart");
        var myChart = echarts.init(dom, "light");
        myChart.clear();
        $('#tbhbfxTable').fixedThead('destroy');//销毁
        $('#tbhbfxday').html("");
        $('#tbhbfx_body').html("");
        $('#tree_tbhbfx').treeview('uncheckAll', {silent: true});

      },
      pageInit: function () {
				time_csh();//初始化时间
        // dataannlysis_fx_tbhbfx.compareChange();
        // dataannlysis_fx_tbhbfx.getHourTableData();

      },
      //打印按钮
      print: function () {
        $("#clone_tbhbfxTable_head").printThis({});
      }
    }


    //时间js----判断时间条件
    function timeFormat() {
      var startTime = $('#tbhbfx_start_time').val();
      var endTime = $('#tbhbfx_end_time').val();
      if (startTime == '' || endTime == '') {
        swal("请输入查询时间段", "", "warning");
        return false;
      }
      var date1 = new Date(startTime.replace(/-/g, "/"));
      var date2 = new Date(endTime.replace(/-/g, "/"));
      if (date2.getTime() < date1.getTime()) {
        swal("开始时间不能大于结束时间！", "", "warning");
        return false;
      }
      return true;
    }


    //echarts数据
    function chartShow(xdata, legend, series, x_unit, y_unit) {
      var dom = document.getElementById("tbhbfx_chart");
      var myChart11 = echarts.init(dom, "light");
      var option = {
        title: {
          text: '逐时统计分析',
          left: 'left',
          top: "2%",
          textStyle: {
            color: '#8fe3f7',
            fontSize: '14'
          },
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {            // 坐标轴指示器，坐标轴触发有效
            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
          }
        },

        legend: {
          type: 'scroll',
          left: "10%",
          top: "2%",
          right: "3%",
          type: 'scroll',
          data: legend,
          pageIconColor: "rgb(42, 123, 193)",
          pageFormatter: '',//隐藏翻页的数字
          pageButtonItemGap: -6,//翻页按钮的两个之间的间距
          textStyle: {
            color: '#8fe3f7'
          }
        },
        grid: {
          left: '9%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: [
          {
            name: x_unit,
            nameTextStyle: {
              color: '#8fe3f7'
            },
            type: 'category',
            data: xdata,
            axisLine: {
              lineStyle: {
                color: '#8fe3f7'
              }
            },
            axisLabel: {
              show: true,
              textStyle: {
                color: '#8fe3f7'
              }
            }
          }
        ],
        dataZoom: [{
          type: 'inside',
          disabled: false
        }],
        yAxis: [
          {
            name: '单位:' + y_unit,
            nameTextStyle: {
              color: '#8fe3f7'
            },
            type: 'value',
            axisLine: {
              lineStyle: {
                color: '#8fe3f7'
              }
            },
            splitLine: {
              lineStyle: {
                color: 'rgba(40, 76, 117, 0.2)',
              }
            },
            axisLabel: {
              show: true,
              textStyle: {
                color: '#8fe3f7'
              }
            }
          }
        ],
        series: series
      };

      if (option && typeof option === "object") {
        myChart11.setOption(option, true);
        myChart11.resize();
      }
      $(window).resize(function () {
        myChart11.resize();
        setTimeout(function () {
          getHeight()
        }, 1);
      });
    }

  })(jQuery, window, document);
  dataannlysis_fx_tbhbfx.pageInit();

</script>
