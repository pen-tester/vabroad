var RecaptchaOptions = {
    theme: 'white'
};

    $(document).ready(function () {
        $(".grdImg2").each(function (index) {
            var height = $(this).height;
            var width = $(this).width();
            if (height == 0 || width == 0) {
                $(this).hide();
            }
        });
    })
    var $element;
    $(document).ready(function () {
 

        $element = $('#modal_contents').bind('webkitAnimationEnd', function () {
            this.style.webkitAnimationName = '';
        });

        $('ul.tabs li').click(function () {
            var tab_id = $(this).attr('data-tab');

            $('ul.tabs li').removeClass('current');
            $('.tab-content').removeClass('current');

            $(this).addClass('current');
            $("#" + tab_id).addClass('current');
            if (tab_id == "tabs-3") {
                console.log("tst");


                
                $element.css('webkitAnimationName', 'animatetop');
                    // you'll probably want to preventDefault here.
                
                $('#inqureform').show();
            }
        });

        $('.mclose').click(function () {
            $('#inqureform').hide();
        })

    })

    $(window).click(function (event) {
        console.log("windows click");
        // $('#inqureform').hide();
        if (event.target.id == "inqureform") {
            $('#inqureform').hide();
        }
    })