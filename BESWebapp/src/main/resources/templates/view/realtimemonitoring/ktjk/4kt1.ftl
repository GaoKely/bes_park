<style type="text/css">

</style>

<div class="Information_area"
	 style="background: url('static/images/ktjk/ktjk1.png'); position: relative;background-size: 53% 34%; background-repeat: no-repeat;background-position: bottom right;">
    <div class="ktjk_row" >
    <!--开关 -->
        <div class="ktjk_top_left">
            <div class="ktjk_top_right_all">
                <ul>
                    <li style="width: 28%;">
                        <span>东机组启停控制</span>
                    </li>
                    <li style="width: 20%;">
                        <select id="KT_AirUnitRunStopCmd_4_1_1" onchange="dataAnalysis_ktjk2.setLampVPoint(this)">
		                   <option value="255">开</option>
		                   <option value="0">关</option>
                        </select>
                    </li>

                </ul>
               
                <ul>
                	<li style="width: 28%;">
                        <span>东机组工作模式设置</span>
                    </li>
                    <li style="width: 20%;">
                        <select id="KT_SetWorkMode_4_1_1" onchange="dataAnalysis_ktjk2.setLampVPoint(this)">
		                   <option value="0">供冷</option>
		                   <option value="1">通风</option>
		                   <option value="2">供热</option>
                        </select>
                    </li>
                </ul>
            </div>
        </div>
    <!--状态 -->
        <div class="ktjk_top_right">
            <div class="ktjk_top_right_all">
                <ul>
                    <li>
                        <span>东机组运行状态</span>
                    </li>
                    <li>
                        <span id="KT_RunStopStatus_4_1_1"></span>
                    </li>
                    <li>
                        <span>东就地远程状态</span>
                    </li>
                    <li>
                        <span id="KT_ManualAutoStatus_4_1_1"></span>
                    </li>
					<li>
                        <span>东综合故障报警</span>
                    </li>
                    <li>
                        <span id="KT_AlarmStatus_4_1_1"></span>
                    </li>
                </ul>

                 <ul>
                	<li>
                        <span>东机组工作模式反馈</span>
                    </li>
                    <li>
                        <span id="KT_WorkMode_4_1_1"></span>
                    </li>

                </ul>

                <ul>
				</ul>
            </div>
        </div>
    </div>


</div>
