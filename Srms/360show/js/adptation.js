var imgNames = 0;
var lastObj = "",
	lastIdx = 1,
	mainObj = document.getElementsByClassName("mask")[0];
//手势参数
var posX = 0,
	posY = 0,
	lastPosX = 0,
	lastPosY = 0;
var transforms = "",
	tra_p = "",
	tra_r = "",
	tra_t = "";
var pid = "",
	pname = "";
//var baseUrl = '',
//	userno = "";
var allInfos = "",
	img_datas = "";
var baseInfo = {};
$(function() {
	//	var baseInfo = getBaseInfo();//ios
	//	var baseInfos = window.ContactInfo.getBaseInfo();//andriod
	//		url = baseInfo.baseUrl;
	//		userno = baseInfo.userAccount;
//	_get_infos();
//	_menus_btns();
});
//dri --  安卓-0、ios-1；
//url --  服务器ip
//userno -- 用户名
function getBaseInfo(baseinfo) {
	alert(JSON.stringify(baseinfo));
	baseInfo = baseinfo;
	_get_infos();
	_menus_btns();
	//	baseInfo.device = device;
	//	baseInfo.url = url;
	//	baseInfo.userNo = userNo;
	//	baseInfo.pid = pid;
}

function _menus_btns() {
	$(".back").on("click", function(ev) {
		ev.stopPropagation();
		$(".top_mask").show();
		$("#save").show();
	});

	$("#saveYes").on("click", function() {
		$("#saveInfo").show();
		$("#save").hide();
	});

	$(".menu").on("click", function(ev) {
		ev.stopPropagation();
		var dom = document.getElementsByClassName("show")[0];
		$(".mask,.delete").hide();
		$(".show img").removeClass("checked");
		if(baseInfo.device == 1) {
			img_datas = share(dom.offsetLeft, dom.offsetTop + $(".menu-bar").height(), dom.clientWidth, dom.clientHeight);
		} else if(baseInfo.device == 0) {
			img_datas = window.ContactInfo.share(dom.offsetLeft, dom.offsetTop + $(".menu-bar").height(), dom.clientWidth, dom.clientHeight);
		}
		$(".top_mask").show();
		$("#menu").show();
	});

	//取消
	$(".top_btn_cancel,.top_mask").on("click", function(ev) {
		ev.stopPropagation();
		$(".top_view").hide();
		$(".top_mask").hide();
	});
	//存为草稿
	$("#saveNew").on("click", function() {
		$("#menu").hide();
		$("#saveInfo").show();
		$("#pName").val("");
		$("#pText").val("");
	});
	//新建
	$("#new").on("click", function() {
		window.location.href = window.location.href;
	});
	$("#opens").on("click", function() {
		//		();
		if(baseInfo.device == 1) {
			openPlans();
		} else if(baseInfo.device == 0) {
			window.ContactInfo.openPlans();
		}
	});
	//不保存退出
	$("#saveNo").on("click", function() {
		//		exit();
		if(baseInfo.device == 1) {
			exit();
		} else if(baseInfo.device == 0) {
			window.ContactInfo.exit();
		}
	});

	$(".delete .deletes").on("click", function(ev) {
		ev.stopPropagation();
		var data = {};
		$.each($(".show img"), function(i, n) {
			if($(this).hasClass("checked")) {
				data.goodNo = $(this).attr("goodno");
				data.pid = $(this).attr("pidNum");
			}
		});
		$.ajax({
			type: "POST",
			url: "http://192.168.9.175:8087/srmsapi/rs/assort/removeGood",
			//		url: url+"/rs/assort/getTempAssortGoods",
			data: JSON.stringify(data),
			success: function(data) {
				//				console.log(++namesss);
				if(data.flag == 0) {
					$(".mask").hide();
					$(".show").html('<div class="mask"></div>');
					$(".delete").hide();
					lastPosX = 0;
					lastPosY = 0;
					_get_infos();
				} else {
					alert(data.msg);
				}
			},
			error: function(data) {
				console.log('data = ' + JSON.stringify(data));
			},
			headers: {
				'Content-Type': 'application/json; charset=UTF-8'
			},
			dataType: 'json'
		});
	});

	$("#postMsg").on("click", function() {
		var pinfo = {},
			imginfos = [];
		pinfo.pname = $("#pName").val();
		pinfo.remark = $("#pText").val();
		pinfo.pimage = img_datas;
		if($(".info-line").length > 0) {
			pinfo.pid = ($(".info-line")[0]).getAttribute("pidnum");
			pinfo.userNo = 'zl';
			$.each($(".show img"), function(i, n) {
				var imginfo = {};
				imginfo.goodNo = $(this).attr("goodno");
				imginfo.translation = $(this).attr("tran");
				imginfo.pull = $(this).attr("pull");
				imginfo.circu = $(this).attr("circu");
				imginfo.div = $(this).css("z-index");
				//				console.log(imginfo);
				imginfos.push(imginfo);
			});
			//			console.log(imginfos);
			var datas = {};
			datas.assortPlan = pinfo;
			datas.goodassort = imginfos;
			//			console.log(datas);
			$.ajax({
				type: "POST",
				url: "http://192.168.9.175:8087/srmsapi/rs/assort/saveAssortPlan",
				//		url: url+"/rs/assort/getTempAssortGoods",
				data: JSON.stringify(datas),
				success: function(data) {
					//					console.log(data);
					if(data.flag == 0) {
						alert(data.msg);
						$(".top_mask,#saveInfo").hide();
						window.location.href = window.location.href;
					} else {
						alert(data.msg);
					}
				},
				error: function(data) {
					console.log('data = ' + JSON.stringify(data));
				},
				headers: {
					'Content-Type': 'application/json; charset=UTF-8'
				},
				dataType: 'json'
			});
		} else {
			alert("不能保存空数据！");
		}
	});
}

function _get_infos() {
	//		_init_pic(names);
	//		return;
	var datas = {};
//	datas.userNo = "zl";
//	datas.pid = 0;
			datas.userNo = baseInfo.userNo;
			datas.pid = baseInfo.pid;
	//alert(11111);
	$.ajax({
		type: "POST",
		url: "http://192.168.9.175:8087/srmsapi/rs/assort/getTempAssortGoods",
		//		url: url+"/rs/assort/getTempAssortGoods",
		data: JSON.stringify(datas),
		success: function(data) {
			//						console.log(data);
			allInfos = data.msg;
			_init_pic(data);
		},
		error: function(data) {
			console.log('data = ' + JSON.stringify(data));
		},
		headers: {
			'Content-Type': 'application/json; charset=UTF-8'
		},
		dataType: 'json'
	});
}
var ticking = false;

function addHammers(obj) {

	var newHammer = new Hammer.Manager(obj);
	newHammer.add(new Hammer.Pan({
		threshold: 0,
		pointers: 0
	}));
	newHammer.add(new Hammer.Rotate({
		threshold: 0
	})).recognizeWith(newHammer.get('pan'));
	newHammer.add(new Hammer.Pinch({
		threshold: 0
	})).recognizeWith([newHammer.get('pan'), newHammer.get('rotate')]);

	newHammer.on("panstart panmove panend", onPan);
	//	newHammer.on("panmove", onPanMove);
	//	newHammer.on("panend", onPanEnd);

	newHammer.on("rotatestart rotatemove rotateend", onRotate);
	newHammer.on("pinchstart pinchmove pinchend", onPinch);
    
    }

function onPanStatrt(ev) {
	var lastPoint = lastObj.attr("tran");

}

function onPan(ev) {
	var lastPoint = lastObj.attr("tran");
	if(ev.type == "panmove") {
		if(lastPoint) {
			lastPoint = lastPoint.split("_");
			lastPosX = lastPoint[0];
			lastPosY = lastPoint[1];
		} else {
			lastPosX = 0;
			lastPosY = 0;
		}
	}
	if(ev.type == "panmove") {
		posX = ev.deltaX + parseInt(lastPosX);
		posY = ev.deltaY + parseInt(lastPosY);
		tra_t = "translate(" + posX + "px," + posY + "px)";
		console.log("移动中---->" + posX + "_" + posY);
		changeTransform();
	}
	if(ev.type == "panend") {
		var tran = posX + "_" + posY;
		lastObj.attr("tran", tran);
	}
}
var initScale = 1;

function onPinch(ev) {
	var lastPoint = $(".show .checked").attr("pull");
//		lastnum = $(".show .checked").attr("goodno");
	if(ev.type == 'pinchstart') {
		if(lastnum != imgNames) {
			if(lastPoint) {
				initScale = lastPoint;
			} else {
				initScale = 1;
			}
		}
	}
	if(ev.type == 'pinchmove') {
		tra_r = 'scale(' + (initScale * ev.scale).toFixed(2) + ',' + (initScale * ev.scale).toFixed(2) + ')';
		changeTransform();
	}
	//	console.log("拉伸的变化---->"+(initScale * ev.scale).toFixed(2)+ev.scale+initScale);
	if(ev.type == 'pinchend') {
		$(lastObj).attr("pull", (initScale * ev.scale).toFixed(2));
	}

}
var initAngle = 0;

function onRotate(ev) {
	var lastPoint = lastObj.attr("circu");
	//		lastnum = lastObj.attr("goodno"); 
	if(ev.type == 'rotatestart') {
		if(lastPoint) {
			initAngle = lastPoint;
		} else {
			initAngle = 0;
		}
		logs("旋转开始---->",initAngle,ev.rotation);
	}
	if(ev.type == 'rotatemove') {
		tra_p = 'rotate(' +  parseInt(parseInt(initAngle) + ev.rotation) + 'deg)';
		changeTransform();
		logs("旋转...---->",initAngle,ev.rotation);
	}

	//	console.log("旋转的变化---->" + initAngle + parseInt(initAngle + ev.rotation));
	if(ev.type == 'rotateend') {
		initAngle = parseInt(initAngle) + ev.rotation;
		$(lastObj).attr("circu", initAngle);
		logs("旋转开始---->",initAngle,ev.rotation);
		logs($(lastObj).attr("circu"),0,0);
	}
	
}

//var initialScale = 1;
//
//function pinchAndRotate() {
//	var cobjs = new Hammer.Manager(document.getElementsByClassName("checked")[0]);
//	var pinch = new Hammer.Pinch(); //缩放
//	var rotate = new Hammer.Rotate(); //旋转
//	rotate.recognizeWith(pinch);
//	cobjs.add([pinch, rotate]);
//	var pinchs = "",
//		rotates = "";
//	cobjs.on("pinch rotate", function(ev) {
//		ev.preventDefault();
//		if(ev.type == "pinch") {
//			tra_p = 'rotate(' + parseInt(ev.rotation) + 'deg)';
//		}
//		if(ev.type == "rotate") {
//			currentScale = ev.scale - 1;
//			currentScale = initialScale + currentScale;
//			currentScale = currentScale > 5 ? 5 : currentScale;
//			tra_r = 'scale(' + currentScale + ',' + currentScale + ')';
//		}
//		changeTransform();
//	});
//}
//
//function pans() {
//	if(lastObj) {
//		posX = 0;
//		posY = 0;
//		var cobjs = new Hammer($(".checked")[0]);
//		cobjs.on("pan panend", function(ev) {
//			ev.preventDefault();
//			posX = ev.deltaX + lastPosX;
//			posY = ev.deltaY + lastPosY;
//			tra_t = "translate(" + posX + "px," + posY + "px)";
//			changeTransform();
//			//			console.log("ev.deltaX ——> "+ev.deltaX+"  ev.deltaY ---> " +ev.deltaY)
//		});
//	}
//}
//
//function taps() {
//	if(document.getElementsByClassName("checked")[0]) {
//		var cobjs = Hammer($(".checked")[0]);
//		cobjs.on("tap", function(ev) {});
//	}
//}

function changeTransform() {
	//		console.log(lastObj[0].style.transform);
	transforms = tra_t + " " + tra_p + " " + tra_r;
	lastObj[0].style.transform = transforms;
	//	lastObj[0].style.oTransform = transforms;
	//	lastObj[0].style.msTransform = transforms;
	//	lastObj[0].style.mozTransform = transforms;
	lastObj[0].style.webkitTransform = transforms;
}

function _init_pic(data) {
	if(data) {
		console.log(data);
		var img_html = $(".show").html();
		var line_info = "",
			size_info = "";

		$.each(data.msg, function(i, n) {
			var sizes = [],
				colors = [],
				colorsids = [];

			$.each(JSON.parse(n.otherinfo)[0].goodsInfo.sizes, function(i2, n2) {
				var color = [],
					colorsid = [];
				sizes[i2] = n2.size;
				$.each((n2.longs[0]).colors, function(x, y) {
					color[x] = y.colordesc;
					colorsid[x] = y.colorid;
				});
				colors.push(color);
				colorsids.push(colorsid);
			});
			//			console.log(colors);
			line_info += '<div class="col-sm-12 info-line no-p" goodno="' + JSON.parse(n.otherinfo)[0].goodsInfo.goodsno + '" pidNum = "' + n.pid + '" customerId = "' + n.customer_id + '">';
			line_info += '<div class="col-sm-12 titles-line no-p"><div class="col-sm-6 info-title no-p">' + JSON.parse(n.otherinfo)[0].goodsInfo.goodsname + '</div>';
			line_info += '<div class="col-sm-6 info-ordered no-p">订货总数：<span>0<span>件</div></div>';
			line_info += '<div class="col-sm-12 infos"><div class="col-sm-12 info-checked no-p">';
			line_info += '<img class="col-sm-4 col-sm-offset-4" src="' + JSON.parse(n.otherinfo)[0].mainPictureUrl + '" style="margin-top: 1vh;" />';
			line_info += '<div class="col-sm-12 info-title-chek">货号：' + JSON.parse(n.otherinfo)[0].goodsInfo.goodsno + '</div>';
			line_info += '<div class="col-sm-6 info-info-chek">类别：' + JSON.parse(n.otherinfo)[0].goodsInfo.category + '</div>';
			line_info += '<div class="col-sm-6 info-info-chek">款型：' + JSON.parse(n.otherinfo)[0].goodsInfo.pattern + '</div>';
			line_info += '<div class="col-sm-6 info-info-chek">年份：' + JSON.parse(n.otherinfo)[0].goodsInfo.year + '</div>';
			line_info += '<div class="col-sm-6 info-info-chek">季节：' + JSON.parse(n.otherinfo)[0].goodsInfo.season + '</div>';
			line_info += '<div class="col-sm-6 info-info-chek">性别：' + JSON.parse(n.otherinfo)[0].goodsInfo.sex + '</div>';
			line_info += '<div class="col-sm-6 info-info-chek">面料：' + JSON.parse(n.otherinfo)[0].goodsInfo.material + '</div>';
			line_info += '<div class="col-sm-12"><div class="col-sm-12 no-p  info-subtitle">';
			line_info += '<div class="col-sm-5 no-p">价格：￥' + JSON.parse(n.otherinfo)[0].goodsInfo.priceranges[0].prcie + '</div>';
			line_info += '<div class="col-sm-7 np-p">起批量：' + JSON.parse(n.otherinfo)[0].goodsInfo.priceranges[0].lowerlimit + "~" + JSON.parse(n.otherinfo)[0].goodsInfo.priceranges[0].upperlimit + '</div></div>';
			line_info += '<div class="col-sm-12"><div class="col-sm-12 info-sub-info"><div class="col-sm-3 no-p">';
			line_info += '<div class="col-sm-12 no-p">库存</div><div class="col-sm-12 no-p">' + JSON.parse(n.otherinfo)[0].goodsInfo.stockNum + '</div></div>';
			line_info += '<div class="col-sm-3 no-p"><div class="col-sm-12 no-p">已补</div><div class="col-sm-12 no-p">' + JSON.parse(n.otherinfo)[0].goodsInfo.replenishedNum + '</div>';
			line_info += '</div><div class="col-sm-3 no-p"><div class="col-sm-12 no-p">未发</div><div 	class="col-sm-12 no-p">' + JSON.parse(n.otherinfo)[0].goodsInfo.unDeliveredNum + '</div>';
			line_info += '</div><div class="col-sm-3 no-p"><div class="col-sm-12 no-p">在途</div><div class="col-sm-12 no-p">' + JSON.parse(n.otherinfo)[0].goodsInfo.deliveredNum + '</div></div></div></div></div></div>';
			line_info += '<div class="col-sm-12" style="overflow-x: scroll;">';
			line_info += '<table style="margin-top: 2vh;">';
			line_info += '<tr style="margin-top: 10vh;"><td></td>';
			line_info += _get_sizes(sizes);
			line_info += _get_colors(colors[i], sizes.length, colorsids[i]);
			line_info += '</table></div>';
			line_info += '<div class="col-sm-12 no-p"><hr /></div>';
			line_info += '<div class="col-sm-12"><div class="col-sm-6 col-sm-offset-3 btns">加入到补货池</div></div></div></div>';
			img_html += '<img class="imgs" src="' + JSON.parse(n.otherinfo)[0].mainPictureUrl + '" goodno="' + JSON.parse(n.otherinfo)[0].goodsInfo.goodsno + '" pidNum = "' + n.pid + '" tran = "' + n.translation + '" pull = "' + n.pull + '"  circu = "' + n.circu + '" style= "' + changeRotates(n.translation, n.pull, n.circu) + 'z-index:0"/>';
		});
		$(".show").html(img_html);
		$(".right-v").html(line_info);

		$(".show img").on("click", function(ev) {
			ev.stopPropagation();
			var trans = $(this)[0];
			//			lastObj = $(this);
			$(this).addClass("checked");
			$(".mask").show();
			$(".delete").show();
			$(".info-line").removeClass("selected");
			$(".right-v [goodno='" + $(this).attr("goodno") + "']").addClass("selected");
			var goodNumber = $(this).attr("goodno");
			if(goodNumber != imgNames) {
				imgNames = goodNumber;
				lastObj = $(this);
				addHammers(document.getElementsByClassName("checked")[0]);
			}

		});

		$(".mask").on("click", function(ev) {
			ev.stopPropagation();
			$(".delete").hide();
			$(".info-line").removeClass("selected");
			$(this).css({
				"display": "none"
			});
			$(".show img").removeClass("checked").css({
				"z-index": 2
			});
		});

		$(".info-line").on("click", function(ev) {
			ev.stopPropagation();
			var num = $(this).attr("goodno");
			$(".info-line").removeClass("selected");
			$(".show .imgs").removeClass("checked");
			$(".right-v [goodno = '" + num + "']").addClass("selected");
			$('.show [goodno = "' + num + '"]').addClass("checked");
			lastObj = $('.show [goodno = "' + num + '"]');
			$(".mask").show();
			$(".delete").show();
			$(".show img [goodno='" + num + "']").addClass("checked");
			var trans = $(".show img [goodno='" + num + "']");
			imgNames = $(this).attr("goodno");
			addHammers(document.getElementsByClassName("checked")[0]);
			//			console.log(lastObj);
		});

		$(".btns").on("click", function(ev) {
			ev.stopPropagation();
			var datas = {};
			datas.userNo = "zs";
			datas.customer_id = $(this).parent().parent().parent().attr("customerId");
			datas.pid = $(this).parent().parent().parent().attr("pidNum");
			datas.goodNo = $(this).parent().parent().parent().attr("goodno");
			var currentsizes = [],
				tables = $(this).parent().parent().parent().find("tbody"),
				tr = tables.find("tr"),
				trLe = tr.length,
				tdLe = tr[0].cells.length;
			var colorNames = [],
				colorIds = [],
				sizeNames = [],
				numbers = [];
			for(var n = 0; n < tdLe; n++) {
				for(var i = 0; i < trLe; i++) {
					if(n == 0) {
						colorNames.push(tr[i].cells[n].innerHTML);
						colorIds.push(tr[i].cells[n].getAttribute("colorId"));
					} else {
						if(i == 0) {
							sizeNames.push(tr[i].cells[n].firstChild.innerHTML);
						} else {
							numbers.push(parseInt(tr[i].cells[n].firstChild.value));
						}
					}
				}
			}
			colorNames.splice(0, 1);
			colorIds.splice(0, 1);
			var longss = [];
			for(var i = 0; i < sizeNames.length; i++) {
				var colors = [],
					longs = {},
					allColor = {},
					longsss = [];
				longs.size = sizeNames[i];
				for(var n = 0; n < colorNames.length; n++) {
					var color = {};
					color.colordesc = colorNames[n];
					color.colorid = colorIds[n];
					color.stcokqty = 100;
					color.currentqty = numbers[colorNames.length * i + n];
					colors.push(color);
				}
				allColor.colors = colors;
				allColor.longdesc = '0';
				allColor.longid = '0';
				longsss.push(allColor);
				longs.longs = longsss;
				longss.push(longs);
				longs.displayIndex = i + 1;
				longs.currentqty = 0;
				longs.stcokqty = 0;

			}
			datas.sizes = longss;
			//			console.log(allInfos);
			var infos = {};
			$.each(allInfos, function(i, n) {
				if(n.goodNo == datas.goodNo) {
					infos = JSON.parse(n.otherinfo)[0];
					infos.goodsInfo.sizes = longss;
					var pr_num = 0;
					for(var m = 0; m < numbers.length; m++) {
						if(numbers[m]) {
							pr_num += numbers[m];
						}
					}
					infos.totalQty = pr_num;
					infos.totalAmount = (infos.disPrice) * pr_num;
					//					console.log("disPrice:" + infos.disPrice + "--totalQty:" + infos.totalQty + "---totalAmount:" + infos.totalAmount);
				}
			});
			//			console.log(JSON.stringify(infos));
			$.ajax({
				type: "POST",
				url: "http://121.40.47.76:30001/srmsapi/rs/ordersgoods/ceateorder",
				//		url: url+"/rs/assort/getTempAssortGoods",
				data: JSON.stringify(infos),
				success: function(data) {
					if(data.msg = 'succeed') {
						alert("加入补货池成功");
					} else {
						alert(data.msg);
					}
				},
				error: function(data) {
					console.log('data = ' + JSON.stringify(data));
				},
				headers: {
					'Content-Type': 'application/json; charset=UTF-8'
				},
				dataType: 'json'
			});
		});
	} else {
		console.log("没有数据");
	}
}

function changeRotates(data1, data2, data3) {
	//	var transfroms = data1 + " " + data2 + " " + data3; 'scale(' + initScale * ev.scale + ',' + initScale * ev.scale + ')' 'rotate(' + parseInt(initAngle + ev.rotation) + 'deg)'
	//		alert("data1-->"+data1+"data2-->"+data2+"data3-->"+data3);
	if(data1) {
		data1 = data1.split("_");
		data1 = "translate(" + data1[0] + "px," + data1[1] + "px)";
	}
	if(data2) {
		data2 = 'scale(' + data2 + ',' + data2 + ')';
		//		alert(data2);
	}
	if(data3) {
		data3 = 'rotate(' + parseInt(data3) + 'deg);';
	}
	var transforms = data1 + " " + data2 + " " + data3;
	return "transform:" + transforms + ";-webkit-transform:" + transforms;
}

function _get_sizes(sizes) {
	var trs = "";
	$.each(sizes, function(i, n) {
		trs += '<td><div class="size">' + n + '</div></td>';
	});
	trs += '</tr>';
	//	console.log(trs);
	return trs;
}

function _get_colors(data, length, colorId) {
	var trs = '';
	console.log(data);
	$.each(data, function(i, n) {
		trs += '<tr><td class="color" colorId = "' + colorId[i] + '">' + n + '</td>';
		for(var i = 0; i < length; i++) {
			trs += '<td><input class="inputs" type="text" /></td>';
		}
		trs += '</tr>';
	});
	return trs;
}

//function _change_img(dom) {
//	html2canvas(window.document.body, {
//		onrendered: function(canvas) {
//			var myImage = canvas.toDataURL();
//			console.log(myImage);
//		}
//	});
//}