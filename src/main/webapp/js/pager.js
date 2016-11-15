var PAGER = {
	currentPage: 1,  //当前页
	totalPages: 0,  //总页数
	pageNums: 10,  //显示的页码数
	pageSize:10,//每页显示多岁数据
	pageNumArr: new Array(),  //页码数组
	pager: null,  //显示分页的html对象
	callbackFun: null,  //回调函数, 入参: 当前页码

	/**
	 * 初始化分页参数
	 * currentPage: 当前页码
	 * total: 总页数
	 * pageSize: 每页显示条目数
	 * obj: 显示分页的html对象id
	 * callbackFun: 分页回调函数  PAGER.initPager('${start}',' ${json.total}','${limit}', 8, 'pager', getData);
	 */
	initPager: function(currentPage, total, pageSize, pageNums, obj, callbackFun) {
		if(total%pageSize==0) {
			this.totalPages = total/pageSize;
		} else {
			this.totalPages = total/pageSize + 1;
		}
		this.pageSize=pageSize;
		this.totalPages = parseInt(this.totalPages);
		this.currentPage = currentPage;
		this.pageNums = pageNums;
		this.pager = document.getElementById(obj);
		this.callbackFun = callbackFun;
	
		this.renderPager();
	},
	
	/**
	 * 执行回调函数
	 */
	doCallBack: function() {
		if(this.callbackFun) {
			this.callbackFun(this.currentPage,this.pageSize);
		}
	},

	/**
	 * 跳转到首页
	 */
	gotoFirstPage: function() {
		this.currentPage = 1;
		this.renderPager();
	},

	/**
	 * 跳转到尾页
	 */
	gotoLastPage: function() {
		this.currentPage = this.totalPages;
		this.renderPager();
	},

	/**
	 * 跳转到上一页
	 */
	gotoPrePage: function() {
		if (this.currentPage>1) {
			this.currentPage --;
			this.renderPager();
		}
	},

	/**
	 * 跳转到下一页
	 */
	gotoNextPage: function() {
		//if(this.currentPage<this.pageNumArr[this.pageNumArr.length-1]) {
		if(this.currentPage<this.totalPages) {
			this.currentPage++;
			this.renderPager();
		}
	},

	/**
	 * 跳转到指定页
	 */
	gotoPage: function(targetPage) {
		
		if(targetPage==""){
			targetPage=$("#targetPage").val();
		}
		if(targetPage<1) {
			targetPage = 1;
		} else if(targetPage>this.totalPages) {
			targetPage = this.totalPages;
		}
		
		this.currentPage = targetPage;
		this.renderPager();
	},
	/**
	 * 修改分页语句
	 */
	goPageByPageSize: function() {
		var ps=$("#pageSize").val();
		if(ps==''){
			this.pageSize=10;
		}else{
			this.pageSize=ps;
		}
		this.renderPager();
	},
	/**
	 * 跳转到指定页
	 */
	gotoTargetPage: function() {
		var targetPage=$("#targetPage").val();
		if(targetPage<1) {
			targetPage = 1;
		} else if(targetPage>this.totalPages) {
			targetPage = this.totalPages;
		}
		
		this.currentPage = targetPage;
		this.renderPager();
	},

	/**
	 * 渲染分页数据
	 */
	renderPager: function() {
		//alert(this.currentPage);
		var begin = 1;
		this.pageNumArr = new Array();
	
		var midPage = Math.floor(this.pageNums/2);
		if(this.totalPages>this.pageNums) {
			if (this.currentPage>midPage) {
				begin = this.currentPage - midPage;
			} 
			if (this.totalPages-this.currentPage<midPage) {
				begin = this.totalPages - (this.pageNums-1);
			}
		}
	
		for(var i=begin; i<=this.totalPages&&i<this.pageNums+begin; i++) {
			this.pageNumArr.push(i);
		}
	
		var pageStr = "";
		var preStr = "<ul > <li ><a href='javascript:PAGER.gotoPrePage()'>上一页</a></li><li ><a href='javascript:PAGER.gotoFirstPage()'>首页</a></li>";
		var nextStr = "<li><a href='javascript:PAGER.gotoLastPage()'>尾页</a></li><li><a href='javascript:PAGER.gotoNextPage()'>下一页</a></li>";
		var goStr="<li><input type='text' name='targetPage' id='targetPage' style='width:20px;height:20px'/><a href='javascript:PAGER.gotoTargetPage()' >GO</a></li>";
		var limitStr="<li ><select id='pageSize' name='pageSize' onChange='PAGER.goPageByPageSize()'  style='width:auto;' >"
		var limitPage=new Array(5,10,20,25,50,100,500);
		for(var  i=0;i<limitPage.length;i++){
			if(this.pageSize==limitPage[i]){
				limitStr+="<option  value='"+limitPage[i]+"'  selected='selected'>"+limitPage[i]+"</option>";
			}else{
				limitStr+="<option  value='"+limitPage[i]+"'>"+limitPage[i]+"</option>";
			}
		}
		limitStr+="</select></li></ul>";
		var cenStr = "";
		for(var i=0; i<this.pageNumArr.length; i++) {
			if (this.currentPage==this.pageNumArr[i]) {
				cenStr += "<li ><a style='background-color:#D3D3D3' href='javascript:PAGER.gotoPage(" + this.pageNumArr[i] + ")'>" + this.pageNumArr[i] + "</a></li>";
			} else {
				cenStr += "<li><a href='javascript:PAGER.gotoPage(" + this.pageNumArr[i] + ")'>" + this.pageNumArr[i] + "</a></li>";
			}
		}
		pageStr = preStr + cenStr + nextStr+goStr+limitStr;
		this.pager.innerHTML = pageStr;
		
		this.doCallBack();
	}

}