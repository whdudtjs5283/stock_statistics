<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>차트</title>
 <!-- jQuery -->
 <script src="https://code.jquery.com/jquery.min.js"></script>
 <!-- google charts -->
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
 <script type="text/javascript">
 
 function proc(result){
	 
	
	 
	 //$('#test').append(result.chartList.itemId);
	// $('#text').val(JSON.stringify(result.chartList.itemId));
	 //var itemId = JSON.stringify(result.chartList.itemId);

	 console.log("t : " + result['chartList'][0].itemId)
	
	 var chart = result['chartList'];
	 
	 for(var i = 0; i < chart.length; i++) {
		 console.log("for : " + chart[i].itemId);
		 //$('#test').append(result['chartList'][i].dealDate + '<br>');
	 }
	 
/* 	 for(var ch in  result['chartList']) {
		 console.log("for in : " +  result['chartList'][ch].itemName);
	 }
	 
	 result['chartList'].forEach(function(ch) {
		 console.log("forEach : " + ch.itemName)
	 }); */
 }
 
 $(function(){
	 var id = $("#id").val();
	 var sd = $("#sd").val();
	 
	 $.ajax({
		 type: "POST"
		 , dataType: "json"
		 , data: {
			 'chartId' : id
			 , 'searchDate' : sd
		 }
		 , url: "/chart/selectChartAjax.do"
		 , error : function(error) {
			 console.log("실패 " + error);
		 }
		 , success : function(result){
			 var a = result.chartList[0].itemId;
			 console.log("성공 "+ a);
			 proc(result);
			 
			 		var chartDrowFun = {

					    chartDrow : function(){
					    	
					        var chartData = '';

					        //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
					        var chartDateformat 	= 'yyyy년MM월dd일';
					        //라인차트의 라인 수
					        var chartLineCount    = 10;
					        //컨트롤러 바 차트의 라인 수
					        var controlLineCount	= 10;


					        function drawDashboard() {

					          var data = new google.visualization.DataTable();
					          //그래프에 표시할 컬럼 추가
					          data.addColumn('datetime' , '날짜');
					          data.addColumn('number'   , '종가');
					          data.addColumn('number'   , '5일 평균');
					          data.addColumn('number'   , '10일 평균');
					          data.addColumn('number'   , '20일 평균');
					          data.addColumn('number'   , '60일 평균');
					          data.addColumn('number'   , '120일 평균');;
					          //data.addColumn('number'   , '거래량');
					          //data.addColumn('number'   , '거래량이동평균');

					          //그래프에 표시할 데이터
					          var dataRow = [];
					          
					          var chartData = result['chartList'];
					          
					          console.log("0번째 날 : " + chartData[0].dealDate);
					        
					      	 
					     	 for(var i = 0; i < chartData.length; i++) {
					    		 var year = chartData[i].year;
					    		 var month = chartData[i].month;
					    		 var day = chartData[i].day;
					    		 var priceClose = chartData[i].priceClose;
					    		 var priceAvg5 = chartData[i].priceAvg5;
					    		 var priceAvg10 = chartData[i].priceAvg10;
					    		 var priceAvg20 = chartData[i].priceAvg20;
					    		 var priceAvg60 = chartData[i].priceAvg60;
					    		 var priceAvg120 = chartData[i].priceAvg120;
					    		 //var volume = chart[i].volume;
					    		 //var volumeAvg60 = chart[i].volumeAvg60;
					    		 
					    		 console.log("거래일 : " + year + "년" + month + "월" + day + "일");
					    		 
					    		 dataRow =  [new Date(year, month, day), priceClose, priceAvg5, priceAvg10, priceAvg20, priceAvg60, priceAvg120];
					    		 data.addRow(dataRow);
					    	 } 
					          

					           /*  for(var i = 0; i <= 29; i++){ //랜덤 데이터 생성
					            var total   = Math.floor(Math.random() * 300) + 1;
					            var man     = Math.floor(Math.random() * total) + 1;
					            var woman   = total - man;

					            dataRow = [new Date('2017', '09', i , '10'), man, woman , total];
					            data.addRow(dataRow);
					          }  */
					           
					          
					          var minPL = $("#mpl").val();
					          var minPA = $("#mpa").val();
					          var min;
					          if(minPA < minPL) {
					        	  min = minPA;
					        	  console.log("minPA: " + min);
					          } else {
					        	  min = minPL;
					        	  console.log("minPL: " + min);
					          }
					          

					            var chart = new google.visualization.ChartWrapper({
					            	
					              chartType   : 'LineChart',
					              containerId : 'lineChartArea', //라인 차트 생성할 영역
					              options     : {
					                              isStacked   : 'percent',
					                              focusTarget : 'category',
					                              height		  : 500,
					                              width			  : '50%',
					                              legend		  : { position: "top", textStyle: {fontSize: 13}},
					                              pointSize		: 5,
					                              tooltip		  : {textStyle : {fontSize:12}, showColorCode : true,trigger: 'both'},
					                              hAxis			  : {format: chartDateformat, gridlines:{count:chartLineCount,units: {
					                                                                  years : {format: ['yyyy년']},
					                                                                  months: {format: ['MM월']},
					                                                                  days  : {format: ['dd일']}}
					                                                                },textStyle: {fontSize:12}},
					                vAxis			  : {minValue: 100,viewWindow:{min:min},gridlines:{count:-1},textStyle:{fontSize:12}}, // 세로축, y축
					                animation		: {startup: true,duration: 1000,easing: 'in' },
					                annotations	: {pattern: chartDateformat,
					                                textStyle: {
					                                fontSize: 15,
					                                bold: true,
					                                italic: true,
					                                color: '#871b47',
					                                auraColor: '#d799ae',
					                                opacity: 0.8,
					                                pattern: chartDateformat
					                              }
					                            }
					              }
					            });

					            var control = new google.visualization.ControlWrapper({
					              controlType: 'ChartRangeFilter',
					              containerId: 'controlsArea',  //control bar를 생성할 영역
					              options: {
					                  ui:{
					                        chartType: 'LineChart',
					                        chartOptions: {
					                        chartArea: {'width': '60%','height' : 80},
					                          hAxis: {'baselineColor': 'none', format: chartDateformat, textStyle: {fontSize:12},
					                            gridlines:{count:controlLineCount,units: {
					                                  years : {format: ['yyyy년']},
					                                  months: {format: ['MM월']},
					                                  days  : {format: ['dd일']}}
					                            }}
					                        }
					                  },
					                    filterColumnIndex: 0
					                }
					            });

					            var date_formatter = new google.visualization.DateFormat({ pattern: chartDateformat});
					            date_formatter.format(data, 0);

					            var dashboard = new google.visualization.Dashboard(document.getElementById('Line_Controls_Chart'));
					            window.addEventListener('resize', function() { dashboard.draw(data); }, false); //화면 크기에 따라 그래프 크기 변경
					            dashboard.bind([control], [chart]);
					            dashboard.draw(data);

					        }
					          google.charts.setOnLoadCallback(drawDashboard);

					      }
					    }
			 		
			 		function drawBasic() {
			 			
		 				  var dataRow = [];
				          
				          var chartData = result['chartList'];

			 		      var data = new google.visualization.DataTable();
			 		      data.addColumn('timeofday', 'Time of Day');
			 		      data.addColumn('number', 'Motivation Level');
			 		    /*   data.addColumn('datetime' , '날짜');
				          data.addColumn('number'   , '시가');
				          data.addColumn('number'   , '고가');
				          data.addColumn('number'   , '저가');
				          data.addColumn('number'   , '종가');
				          data.addColumn('number'   , '가격이동평균'); */
			 		 /*      
			 		     for(var i = 0; i < chartData.length; i++) {
				    		 var year = chartData[i].year;
				    		 var month = chartData[i].month;
				    		 var day = chartData[i].day;
				    		 var priceOpen = chartData[i].priceOpen;
				    		 var priceHigh = chartData[i].priceHigh;
				    		 var priceLow = chartData[i].priceLow;
				    		 var priceClose = chartData[i].priceClose;
				    		 var priceAvg60 = chartData[i].priceAvg60;
				    		 //var volume = chart[i].volume;
				    		 //var volumeAvg60 = chart[i].volumeAvg60;
				    		 
				    		 console.log("거래일 : " + year + "년" + month + "월" + day + "일");
				    		 
				    		 dataRow =  [new Date(year, month, day), priceOpen, priceHigh, priceLow, priceClose, priceAvg60];
				    		 data.addRow(dataRow);
				    	 } 
 */
			 		      data.addRows([
			 		        [{v: [8, 0, 0], f: '8 am'}, 1],
			 		        [{v: [9, 0, 0], f: '9 am'}, 2],
			 		        [{v: [10, 0, 0], f:'10 am'}, 3],
			 		        [{v: [11, 0, 0], f: '11 am'}, 4],
			 		        [{v: [12, 0, 0], f: '12 pm'}, 5],
			 		        [{v: [13, 0, 0], f: '1 pm'}, 6],
			 		        [{v: [14, 0, 0], f: '2 pm'}, 7],
			 		        [{v: [15, 0, 0], f: '3 pm'}, 8],
			 		        [{v: [16, 0, 0], f: '4 pm'}, 9],
			 		        [{v: [17, 0, 0], f: '5 pm'}, 10],
			 		      ]); 

			 		      var options = {
			 		        title: 'Motivation Level Throughout the Day',
			 		        hAxis: {
			 		          title: 'Time of Day',
			 		         format: 'yyyy, MM, dd',
			 		          viewWindow: {
			 		            min: [7, 30, 0],
			 		            max: [17, 30, 0]
			 		          }
			 		        },
			 		        vAxis: {
			 		          title: 'Rating (scale of 1-10)'
			 		        }
			 		      }
			 		     

			 		      var chart = new google.visualization.ColumnChart(
			 		        document.getElementById('chart_div'));

			 		      chart.draw(data, options);
			 		    }

					$(document).ready(function(){
					  google.charts.load('current', {'packages':['line','controls']});
					  chartDrowFun.chartDrow(); //chartDrow() 실행
					  google.charts.load('current', {packages: ['corechart', 'bar']});
					  google.charts.setOnLoadCallback(drawBasic);
					});
			 
			
		 }
		 
	 });
 });

 
 </script>
</head>
<body>
<input type="hidden" id="id" value="${ chart.itemId }">
<input type="hidden" id="sd" value="${ searchVO.searchDate }"/>
<input type="hidden" id="mpl" value="${ minPL }"/>
<input type="hidden" id="mpa" value="${ minPA }"/>
<h4>${ chart.itemName }</h4>


    <div id="Line_Controls_Chart">
      <!-- 라인 차트 생성할 영역 -->
  		<div id="lineChartArea" style="padding:0px 20px 0px 0px;"></div>
      <!-- 컨트롤바를 생성할 영역 -->
  		<div id="controlsArea" style="padding:0px 20px 0px 0px;"></div>
		</div>

  <div id="chart_div"></div>
      
</body>
</html>