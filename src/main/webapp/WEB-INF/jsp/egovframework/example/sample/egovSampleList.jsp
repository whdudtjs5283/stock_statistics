<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
  /**
  * @Class Name : egovSampleList.jsp
  * @Description : Sample List 화면
  * @Modification Information
  *
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2009.02.01            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.02.01
  *
  * Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><spring:message code="title.sample" /></title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
	<style>
		.up {
			color:red;
		}
		
		.down {
			color:blue;
	
		}
		
		.dis_none {
			display: none;
			
		}
	</style>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="//code.jquery.com/jquery.min.js"></script>
    <script type="text/javaScript" language="javascript" defer="defer">
    
        /* 글 수정 화면 function */
        function fn_egov_select(itemId, searchDate, stockName) {
        
        	$("#radioId").val(itemId);
        	$("#radioSD").val(searchDate);
        	$("#radioSN").val(stockName);
        	
        	$("#radio1").prop("checked", true);
        	
        	var vol = 0;
        
       	callAjax(itemId, searchDate, stockName, vol);
    	

        }
        

        $(function(){
         		
         	
        	 $("input[name=volCheck]").on('click', function(){
          			
        		 	var vol = $(this).val();
            		var itemId = $("#radioId").val();
	         		var searchDate = $("#radioSD").val();
	         		var stockName = $("#radioSN").val();
	         		
	         		console.log("id : " + itemId, "searchDate : " + searchDate)
        
            	callAjax(itemId, searchDate, stockName, vol);
          		
          		console.log("vol : " +  vol);
          		});
         	});
                  	
        function callAjax(itemId, searchDate, stockName, vol) {
       
        	console.log("ajax vol : " + vol);
    		$.ajax({
    			 type: "POST"
    				 , dataType: "json"
    				 , data: {
    					 'chartId' : itemId
    					 , 'searchDate' : searchDate
    					 , 'vol' : vol
    				 }
    				 , url: "/chart/selectChartAjax.do"
    				 , error : function(error) {
    					 console.log("실패 " + error);
    				 }
    				 , success : function(result){
    					 console.log("id : " + itemId, searchDate);
    					 drawTrendlines(result, stockName);
    					 drawVisualization(result);
    					 $(".dis_none").removeClass();
    					 //$("#radio1").prop("checked", true);
    					 
    				 }
    		});
        }
        
        google.charts.load('current', {packages: ['corechart', 'line']});
        //google.charts.setOnLoadCallback(drawTrendlines);
        google.charts.load('current', {'packages':['corechart']});
       

        function drawTrendlines(result, stockName) {
              var data = new google.visualization.DataTable();
                data.addColumn('string' , '날짜');
				data.addColumn('number'   , '종가');
				data.addColumn('number'   , '1주');
				data.addColumn('number'   , '2주');
				data.addColumn('number'   , '1개월');
				data.addColumn('number'   , '3개월');
				data.addColumn('number'   , '6개월');
				
				 var dataRow = [];
		          
		          var chartData = result['chartList'];
		          
		        	console.log("cn : " + stockName);

		      	 
		     	 for(var i = 0; i < chartData.length; i++) {
		    		 var year = chartData[i].year;
		    		 var month = chartData[i].month;
		    		 var day = chartData[i].day;
		    		 var dealDate = chartData[i].dealDate;
		    		 var priceClose = chartData[i].priceClose;
		    		 var priceAvg5 = chartData[i].priceAvg5;
		    		 var priceAvg10 = chartData[i].priceAvg10;
		    		 var priceAvg20 = chartData[i].priceAvg20;
		    		 var priceAvg60 = chartData[i].priceAvg60;
		    		 var priceAvg120 = chartData[i].priceAvg120;
		    		 
		    		 //console.log("거래일 : " + year + "년" + month + "월" + day + "일");
		    		 
		    		 dataRow =  [
		    			dealDate
			    		 , priceClose
			    		 , priceAvg5
			    		 , priceAvg10
			    		 , priceAvg20
			    		 , priceAvg60
			    		 , priceAvg120
		    		 ];
		    		 data.addRow(dataRow);
		    	 } 
		     	 
		     	  //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
			        var chartDateformat 	= 'yyyy년MM월dd일';
			        //라인차트의 라인 수
			        var chartLineCount    = 10;
			        //컨트롤러 바 차트의 라인 수
			        var controlLineCount	= 10;
			        

              var options = {
      		  	title : stockName,
                hAxis: {format: chartDateformat, gridlines:{count:chartLineCount,units: {
                      years : {format: ['yyyy년']},
                      months: {format: ['MM월']},
                      days  : {format: ['dd일']}}
                  }
                },
                vAxis: {

                },
               
                legend : {
        			position : 'right'
        		}
              };

              var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
              chart.draw(data, options);
            }
        
        function drawVisualization(result) {
        	  var data = new google.visualization.DataTable();
              	 data.addColumn('string' , '날짜');
				 data.addColumn('number'   , '거래량');				
				 data.addColumn('number'   , '3개월');
	
				
				 var dataRow = [];
		          
		          var chartData = result['chartList'];
		          
		         
		      	 
		     	 for(var i = 0; i < chartData.length; i++) {
		    		 var year = chartData[i].year;
		    		 var month = chartData[i].month;
		    		 var day = chartData[i].day;
		    		 var dealDate = chartData[i].dealDate;
		    		 var volume = chartData[i].volume;
		    		 var volumeAvg60 = chartData[i].volumeAvg60;

		    		 dataRow =  [
		    			 dealDate
			    		 , volume
			    		 , volumeAvg60
		    		 ];
		    		 data.addRow(dataRow);
		    	 } 
		     	 
		     	  //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
			        var chartDateformat 	= 'yyyy년MM월dd일';
			        //라인차트의 라인 수
			        var chartLineCount    = 10;
			        //컨트롤러 바 차트의 라인 수
			        var controlLineCount	= 10;

            

            var options = {
              title : '거래량',
              seriesType: 'bars',
              series: {1: {type: 'line'}}        };

            var chart = new google.visualization.ComboChart(document.getElementById('chart_div2'));
            chart.draw(data, options);
          }
        
        /* 글 등록 화면 function */
        function fn_egov_addView() {
           	document.listForm.action = "<c:url value='/addSample.do'/>";
           	document.listForm.submit();
        }
     
        /* 글 검색 화면 function */
        function fn_egov_selectList(yn) {
        	console.log(yn);
        	document.listForm.pageIndex.value = yn;
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit();
        }
        
        function Enter_Check(){
	    	if(event.keyCode == 13){
	    		fn_egov_selectList(1);
	    		return;
	    	}
    }

        /* pagination 페이지 링크 function */
        function fn_egov_link_page(pageNo){
        	document.listForm.pageIndex.value = pageNo;
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit();
        }
  
        $(function(){
        	
			$("#secDate").on("change", function(){
	        	var date = $("#secDate").val().replace(/\-/g,"");
	        	console.log(date);
				$("#formDate").val(date);
	        });
		});
        	
        	$(function(){
	        	console.log($("#secDate").val());
        	});

    </script>
</head>
<fmt:parseDate var="pd" value="${ searchVO.searchDate }"  pattern="yyyyMMdd"/>
<fmt:formatDate var="pd2" value="${ pd }" pattern="yyyy-MM-dd" />
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
    <form:form commandName="searchVO" id="listForm" name="listForm" method="post" pageEncoding="utf-8">
        <input type="hidden" name="selectedId" />
        <div id="content_pop">
        	<!-- 타이틀 -->
        	<div id="title">
        		<ul>
        			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/><spring:message code="title.chart" /></li>
        		</ul>
        	</div>
        	<!-- // 타이틀 -->
        	<div id="search">
        		<ul>
        			<li><label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
        		
                       거래일 :  <input type="date"  id="secDate" value="${ pd2 }"'/>
                       
            					<form:hidden path="searchDate" id="formDate" value="${ secDate }"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </li>
        			<li>
        			    <label for="searchCondition" style="visibility:hidden;"><spring:message code="search.choose" /></label>
        				<form:select path="searchCondition" cssClass="use">
        					<form:option value="0" label="종목코드/명" />
        				</form:select>
        			</li>
        			<li><label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
                        <form:input path="searchKeyword" cssClass="txt" onkeydown="Enter_Check();"/>
                    </li>
        			<li>
        	            <span class="btn_blue_l">
        	                <a href="javascript:fn_egov_selectList(1);"><spring:message code="button.search" /></a>
        	                <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
        	            </span>
        	        </li>
                </ul>
        	</div>
        	<!-- List -->
        	총 ${ paginationInfo.totalRecordCount }건
        	<div id="table">
        		<table width="100%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
        			<caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
        			<colgroup>

        			</colgroup>
        			<tr>
        				<!-- <th align="center">No</th> -->
        				<th align="center"><spring:message code="title.chart.itemNo" /></th>
        				<th align="center"><spring:message code="title.chart.itemName" /></th>
        				<th align="center"><spring:message code="title.chart.itemPO" /></th>
        				<th align="center"><spring:message code="title.chart.itemPH" /></th>
        				<th align="center"><spring:message code="title.chart.itemPL" /></th>
        				<th align="center"><spring:message code="title.chart.itemCL" /></th>
        				<th align="center"><spring:message code="title.chart.itemYS" /></th>
        				<th align="center"><spring:message code="title.chart.itemPS" /></th>
        				<th align="center"><spring:message code="title.chart.itemVL" /></th>
        				<th>비교거래일</th>
        			</tr>
        			<c:forEach var="result" items="${resultList}" varStatus="status">
            			<tr>
            				<%-- <td align="center" class="listtd"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td> --%>
            				<%-- <td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.id}"/>')"><c:out value="${result.id}"/></a></td> --%>
            				
            				<td align="center" class="listtd"><c:out value="${result.itemId}"/>&nbsp;</td>
            				<td align="left" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.itemId}"/>', <c:out value="${searchVO.searchDate}"/>, '<c:out value="${result.itemName}"/>')"><c:out value="${result.itemName}"/></a>&nbsp;</td>
            				<td align="right" class="listtd"><fmt:formatNumber value="${result.priceOpen}" pattern="#,###" />&nbsp;</td>
            				<td align="right" class="listtd"><fmt:formatNumber value="${result.priceHigh}" pattern="#,###" />&nbsp;</td>
            				<td align="right" class="listtd"><fmt:formatNumber value="${result.priceLow}" pattern="#,###" />&nbsp;</td>
            				<td align="right" class="listtd"><fmt:formatNumber value="${result.priceClose}" pattern="#,###" />&nbsp;</td>
            				<td align="right" class="listtd">
            					<c:set var="agopc" value="${result.cpc}"/>
            					<c:if test="${ agopc  > 0 }">
            						<span class="up"><fmt:formatNumber value="${ agopc }" pattern="▲#,###" />&nbsp;</span>
            					</c:if>
            					<c:if test="${ agopc  < 0 }">
            						<span class="down"><fmt:formatNumber value="${ -agopc }" pattern="▼#,###" />&nbsp;</span>
            					</c:if>
            					<c:if test="${ agopc == 0 }">
            						<fmt:formatNumber value="${ agopc }" pattern="#,###" />&nbsp;
            					</c:if>
            				</td>
            				<td align="right" class="listtd">
            					<c:set var="udp" value="${ result.cpcp }" />
            					<c:if test="${ udp > 0 }">
            						<span class="up">+<fmt:formatNumber value="${ udp }" pattern="#,###.##" />&nbsp;</span>
            					</c:if>
            					<c:if test="${ udp < 0 }">
            						<span class="down"><fmt:formatNumber value="${ udp }" pattern="#,###.##" />&nbsp;</span>
            					</c:if>
            					<c:if test="${ udp == 0 }">
            						<fmt:formatNumber value="${ udp }" pattern="#,###.##" />&nbsp;
            					</c:if>
            				</td>
            				<td align="right" class="listtd"><fmt:formatNumber value="${result.volume}" pattern="#,###" />&nbsp;</td>
            				<td align="right" class="listtd">
	            				<fmt:parseDate var="dda" value="${ result.agoD }"  pattern="yyyyMMdd"/>
								<fmt:formatDate var="dda2" value="${ dda }" pattern="yyyy-MM-dd" />${ dda2 }
								&nbsp;</td>            				
            			</tr>
        			</c:forEach>
        				<c:if test="${ resultList[0].itemId eq null }">
        					<td align="center" class="listtd" colspan="10">장이 열리는 날이 아니거나 없는 종목입니다.</td>
        				</c:if>
        		</table>
        	</div>
        	<!-- /List -->
        	<div id="paging">
        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        		<form:hidden path="pageIndex" />
        		<div class="dis_none" style="text-align:left;">
        		
	        		<input type="hidden" id="radioId"/>
					<input type="hidden" id="radioSD"/>
	        		<input type="hidden" id="radioSN"/>
	        
	        		
	        	  <input type="radio" name="volCheck" id="radio1" value="0"/>일
	        	  <input type="radio" name="volCheck" value="1"/>주
	        	  <input type="radio" name="volCheck" value="2"/>월

        	  </div>
        	</div>
        	  <div id="chart_div"></div>
        	  <div id="chart_div2"></div>
        </div>
        
    </form:form>
  

</body>
</html>
