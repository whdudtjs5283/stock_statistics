/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.service;

import lombok.Data;

/**
 * @Class Name : SampleVO.java
 * @Description : SampleVO Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */
@Data
public class SampleVO extends SampleDefaultVO {

	private static final long serialVersionUID = 1L;

	private String itemId;
	private String itemName;
	private String dealDate;
	private int priceOpen;
	private int priceHigh;
	private int priceLow;
	private int priceClose;
	private double priceAvg5;
	private double priceAvg10;
	private double priceAvg20;
	private double priceAvg60;
	private double priceAvg120;
	private double volume;
	private double volumeAvg5;
	private double volumeAvg20;
	private double volumeAvg60;
	private double volumeAvg120;
	private int cpc;
	private double cpcp;
	private int year;
	private int month;
	private int day;
	private String agoD;
	
	public SampleVO() {}
	
}
