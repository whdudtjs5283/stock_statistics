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

	
	<script src = "http://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js" defer ></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="//code.jquery.com/jquery.min.js"></script>
    <script type="text/javaScript" language="javascript" defer="defer">
    
    $(function(){
    	
    	
    	var table = $('#myTable').DataTable({
    		
    		"language": {
    	        "emptyTable": "데이터가 없어요.",
    	        "lengthMenu": "페이지당 _MENU_ 개씩 보기",
    	        "info": "현재 _START_ - _END_ / _TOTAL_건",
    	        "infoEmpty": "데이터 없음",
    	        "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
    	        "search": "종목코드/명 : ",
    	        "zeroRecords": "일치하는 데이터가 없어요.",
    	        "loadingRecords": "로딩중...",
    	        "processing":     "잠시만 기다려 주세요...",
    	        "paginate": {
    	            "next": "다음",
    	            "previous": "이전"
    	        }
    	    },
    	    ajax: {
    	    	 type: "POST"
    			,url: "/chart/selectListAjax.do",
				    dataSrc: 'sampleList' },
			columns: [
				 {targets: 0, data : 'itemId'},
				 {targets: 1, data : 'itemName', 'render' : fnGetLinkForDetail},
				 {targets: 2, data : 'priceOpen', 'render' : comma},
				 {targets: 3, data : 'priceHigh', 'render' : comma},
				 {targets: 4, data : 'priceLow', 'render' : comma},
				 {targets: 5, data : 'priceClose', 'render' : comma},
				 {targets: 6, data : 'cpc', 'render' : upDownCPC},
				 {targets: 7, data : 'cpcp', 'render' : upDownCPCP},
				 {targets: 8, data : 'volume', 'render' : comma},
				 {targets: 9, data : 'agoD'}
			]
		  });
    	
    	
    	// <a href="javascript:fn_egov_select('id', sd, sn)"><c:out value="${result.itemName}"/></a>
    });

    
    
/*     function fnGetLinkForDetail(data, type, row) {

    	 $('#myTable tbody').on('click', 'tr', function () {
	    	 var rowClick = $('#myTable').DataTable().row( this ).data();
	    	 console.log("rowClick : " + rowClick.itemId);
	    	// url = '<a href="javascript:fnGoUpdate(' + data + ', ' + rowClick.itemId + ', ' + rowClick.dealDate + rowClick.itemName + ')">' + data + '</a>'
    	}); 
  	 
    	 data = '<a href="javascript:fn_egov_select(' + "'028300'" + ', ' + '20200131' + ', ' + "'에이치엘비'" + ')">' + data + '</a>';
    	 
        return data; 
    } */
    
    
	 //data = '<a href="javascript:fn_egov_select(' + row.itemId + ', ' + row.dealDate + ')">' + data + '</a>'
 	  // data = '<span style="cursor:pointer;cursor:hand" onclick="javascript:fn_egov_select(' + "'028300'" + ',' + "20200131" + ', ' + 0000 + ')">' + data + "</span>";
    
/*     function fnGoUpdate(data, id ,sd, sn) {
    	data = '<a href="javascript:fn_egov_select(' + 'id' + ', ' + 'sd' + ', ' + 'sn' + ')">' + data + '</a>';
    	return data;
    } */
    
    function fnGetLinkForDetail(data, type, row) {
    	
        var stVal = "";
        if (data){
        	
            stVal = '<span style="cursor:pointer;cursor:hand" onclick="fnGoUpdate(' + "'" + row.itemId + "'" + ', ' + row.dealDate + ', ' + "'" +  row.itemName + "'" + ')">' + data + '</span>';
        }
        return stVal;
    }
    
    function fnGoUpdate(id, sd, sn) {
    	console.log("fn id :  " + id);
    	console.log("fn sd :  " + sd);
    	
        var v_url = 'javascript:fn_egov_select(' + "'" + id + "'" + ", " + sd + ', ' + "'" + sn + "'" + ')';

        this.location.href = v_url;
    }
    
    function upDownCPC(data, toFormat) {
    	
    	 if(data > 0) { data = '<span align="right" class="up">▲' + data + '</span>' }
		 if(data < 0) { data = '<span align="right" class="down">▼' + Math.abs(data) + '</span>' }
		 if(data == 0) { data = data }
		
		 	return data;
    }
    
    function upDownCPCP(data) {
		if(data > 0) { data = '<span align="right" class="up">+' + data + '</span>' }
		if(data < 0) { data = '<span align="right" class="down">' + data + '</span>' }
		if(data == 0) { data = data }
			return data;
   }

    function comma(toFormat){
    	return toFormat.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
    
    function list(result) {
    	
    	var sampleData = result['sampleList'];
    	var searchData = result['searchVO'];
    	
    	for(var i = 0; i < sampleData.length; i++){
    		
    		rowItem = "<tr>"
	        		rowItem += "<td align='center' class='listtd'>" + sampleData[i].itemId + "</td>"
	        		rowItem += "<td align='left' class='listtd'>" + sampleData[i].itemName + "</td>"
	        		rowItem += "<td align='right' class='listtd'>" + sampleData[i].priceOpen + "</td>"
	        		rowItem += "<td align='right' class='listtd'>" + sampleData[i].priceHigh + "</td>"
	        		rowItem += "<td align='right' class='listtd'>" + sampleData[i].priceLow + "</td>"
	        		rowItem += "<td align='right' class='listtd'>" + sampleData[i].priceClose + "</td>"
         		if(sampleData[i].cpc > 0)
	        		rowItem += "<td align='right' class='up'>" + sampleData[i].cpc + "</td>"
        		if(sampleData[i].cpc < 0)
	        		rowItem += "<td align='right' class='down'>" + sampleData[i].cpc + "</td>"
        		if(sampleData[i].cpc == 0) 
       				rowItem += "<td align='right' class='listtd'>" + sampleData[i].cpc + "</td>"
	        		
	        		rowItem += "<td align='right' class='listtd'>" + sampleData[i].cpcp + "</td>"
	        		rowItem += "<td align='right' class='listtd'>" + sampleData[i].volume + "</td>"
	        		rowItem += "<td align='center' class='listtd'>" + sampleData[i].agoD + "</td>"
	        		rowItem += "</tr>"
        		
           		$('#listTable').append(rowItem);       	
    			console.log("sampleData : " + sampleData[i].itemId);
    	}

    }
    
        /* 글 수정 화면 function */
        function fn_egov_select(itemId, searchDate, stockName) {
        
        	$("#stockId").val(itemId);
        	$("#stockName").val(stockName);
        	
        	var vol = 0;
        
       	callAjax(itemId, searchDate, stockName, vol);
    	
        }

        $(function(){
       	
        	 $("input[name=volCheck]").on('click', function(){
          			
        		 	var vol = $(this).val();
            		//var itemId = $("#radioId").val();
	         		//var searchDate = $("#radioSD").val();
	         		//var stockName = $("#radioSN").val();
	         		
	         		console.log("select id : " + itemId);
	         		console.log("select searchDate : " + searchDate);
	         		console.log("select stockName : " + stockName);
        
            	callAjax(itemId, searchDate, stockName, vol);
          		
          		console.log("vol : " +  vol);
          		});
         	});
        

     /*              	
        function callAjax(itemId, searchDate, stockName, vol) {
       
        	var table = $('#myTable').DataTable({
        		ajax: { 
        			url: "/chart/selectChartAjax.do",
        			
   				    dataSrc: '' },
    			columns: [
    				 {data : 'dealDate'},
    				 {data : 'priceClose'},
    				 {data : 'pcAvg5'},
    				 {data : 'pcAvg10'},
    				 {data : 'pcAvg20'},
    				 {data : 'pcAvg60'},
    				 {data : 'volume'},
    				 {data : 'volAvg5'},
    				 {data : 'volAvg20'},
    				 {data : 'volAvg60'}
    			]
  		  });
        } */
        
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
    					 table(result, stockName);
    					 $(".dis_none").removeClass();
    				 }
    		});
        } 
        
        
        function table(result,stockName) {
        	
       	    var chartData = result['chartList'];
	          
	     
        	 var rowItem = $('#pct').html("");
   	     	 for(var i = 0; i < chartData.length; i++) {
   	     		rowItem = "<tr>"
        		rowItem += "<td align='center' class='listtd'>" + chartData[i].dealDate + "</td>"
        		rowItem += "<td align='center' class='listtd'>" + chartData[i].priceClose + "</td>"
        		rowItem += "<td align='center' class='listtd'>" + chartData[i].pcAvg5 + "</td>"
        		rowItem += "<td align='center' class='listtd'>" + chartData[i].pcAvg10 + "</td>"
        		rowItem += "<td align='center' class='listtd'>" + chartData[i].pcAvg20 + "</td>"
        		rowItem += "<td align='center' class='listtd'>" + chartData[i].pcAvg60 + "</td>"
        		rowItem += "<td align='center' class='listtd'>" + chartData[i].volume + "</td>"
        		rowItem += "<td align='center' class='listtd'>" + chartData[i].volAvg5 + "</td>"
        		rowItem += "<td align='center' class='listtd'>" + chartData[i].volAvg20 + "</td>"
        		rowItem += "<td align='center' class='listtd'>" + chartData[i].volAvg60 + "</td>"
        		rowItem += "</tr>"
            		$('#pct').append(rowItem);       		
   	     	 }
   	      		
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
        	<%-- 총 ${ paginationInfo.totalRecordCount }건
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
            				<td align="center" class="listtd"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
            				<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.id}"/>')"><c:out value="${result.id}"/></a></td>
            				
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
        	</div> --%>
        	<!-- /List -->
        	<div id="paging">
        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        		<form:hidden path="pageIndex" />
        	</div>
        	
        	<table id="myTable" width="120%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
        			<thead>
	        			<tr>
	        				<th align="center">종목코드</th>
	        				<th align="center">종목명</th>
	        				<th align="center">시가</th>
	        				<th align="center">고가</th>
	        				<th align="center">저가</th>
	        				<th align="center">종가</th>
	        				<th align="center">전일대비</th>
	        				<th align="center">등락률</th>
	        				<th align="center">거래량</th>
	        				<th align="center">비교거래일</th>
		         		</tr>
        			</thead>
        			<tbody >
        			
        			</tbody>
        		</table>
        		
        		<div class="dis_none" style="text-align:left;">
	       
	        		<input type="text" id="stockName" style="border:none" readonly="true"/>
	        
	        <table width="120%" border="0" cellpadding="0" cellspacing="2" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
        			<caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
        			<tr>
        				<!-- <th align="center">No</th> -->
        				<th align="center" rowspan="2" >거래일</th>
        				<th align="center" rowspan="2" >종가</th>
        				<th align="center" colspan="4">가격이동평균</th>
        				<th align="center" rowspan="2">거래량</th>
        				<th align="center" colspan="3">거래이동평균</th>
        			</tr>
        			<tr>
        				<th align="center">5일</th>
        				<th align="center">10일</th>
        				<th align="center">20일</th>
        				<th align="center">60일</th>
        				<th align="center">5일</th>
        				<th align="center">20일</th>
        				<th align="center">60일</th>
	         		</tr>
	         		<tbody id="pct">
	         		</tbody>
        		</table>

        	  </div>
        </div>
        
    </form:form>
  

</body>
</html>
