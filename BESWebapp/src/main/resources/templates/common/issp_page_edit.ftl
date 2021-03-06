<#--page.ftl不同页面分页点击会相互影响，在issp_page.ftl的基础上稍微修改，用来分页-->
<div class="pages border-top">
	<div class="row" style="margin-left:0;">
		<div class="col-md-4">
			<div class="m-t-md">当前显示 ${page.startRow } 到 ${page.endRow } 条，共 ${page.pages } 页 ${page.total } 条</div>
		</div>
		<div class="col-md-8 footable-visible" style="margin-right:0;margin-top:10px;display: block;">
			<ul class="pagination pull-right" style="margin:5px 1px 5px 1px;">
				<li class="footable-page-arrow"><a data-page="1" href="javascript:void(0);" onclick="goPage(this,'${formId }','${showPageId }');">«</a></li>
				<li class="footable-page-arrow"><a data-page="${page.prePage }" href="javascript:void(0);" onclick="goPage(this,'${formId }','${showPageId }');">‹</a></li>
				<#if page?? && page.navigatepageNums?? && (page.navigatepageNums?size > 0)>
					<#list page.navigatepageNums as pgnum>
						<#if pgnum==page.pageNum>
							<li class="footable-page active"><a data-page="${pgnum }" href="javascript:void(0);" onclick="goPage(this,'${formId }','${showPageId }');">${pgnum }</a></li>
						<#else>
							<li class="footable-page"><a data-page="${pgnum }" href="javascript:void(0);" onclick="goPage(this,'${formId }','${showPageId }');">${pgnum }</a></li>
						</#if>
					</#list>
				</#if>
				<li class="footable-page-arrow"><a data-page="${page.nextPage }" href="javascript:void(0);" onclick="goPage(this,'${formId }','${showPageId }');">›</a></li>
				<li class="footable-page-arrow"><a data-page="${page.pages }" href="javascript:void(0);" onclick="goPage(this,'${formId }','${showPageId }');">»</a></li>
			</ul>
		</div>
		<input type="hidden" name="pageNum" />
	</div>
</div>
<script type="text/javascript">
  function goPage(objA, formId, showPageId) {
    $('#' + formId+" input[name='pageNum']").val($(objA).attr("data-page"));
    $.ajax({
      cache: true,
      type: "POST",
      url: $("#" + formId).attr("action"),
      data: $('#' + formId).serialize(),// 序列化的form
      async: false,
      error: function(data) {
        toastr.error('', '分页查询失败');
      },
      success: function(data) {
        // $("#" + showPageId).tabulator("setData", data);
          $("#" + showPageId).html(data);
      }
    });
  }
</script>
