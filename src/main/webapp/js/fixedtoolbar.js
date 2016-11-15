$(window).scroll(function(){

    if ($(this).scrollTop() >= 150) {
        $("#fixedBar").addClass("navbar-fixed-top");
        $("#fixedBar").css({"top":"30px","padding-right":"20px","left":"11%","width":"88%"});
    }else{
        $("#fixedBar").removeClass("navbar-fixed-top");
        $("#fixedBar").css({"padding-right":"0","left":"0","width":"initial"});
    }

});