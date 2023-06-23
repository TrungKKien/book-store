// alert("hell0")
$(document).ready(function () {
    $("#btn-login").click(function () { 
        $("body .none").removeClass("none");    
        $("body .form-regist").addClass("none");
        $(".text1").addClass("none");
        $(".row .bg").addClass("right");

    });
});
$(document).ready(function () {
    $("#btn-register").click(function () { 
        $("body .none").removeClass("none");    
        $("body .form-login").addClass("none");
        $(".text2").addClass("none");
        // $(".row .bg").addClass("right");
        $(".right").removeClass("right");

    });
});
