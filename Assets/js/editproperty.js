var current_page = 0;
$(document).ready(function () {
    $("#wzardstep" + current_page).show();
    //For clicking step wizard 
    $('div.step').click(function () {
        var target = $(this).attr('data-target');
        if (!$('div.step[data-target="' + target + '"]').parent().hasClass("done")) return;
        switchPage(target);
        buttongroup(current_page);
    });
    //For step button event
    $('.btnprev').click(function () {
        if (current_page > 0) {
            switchPage(current_page - 1);
            buttongroup(current_page);
        }
    });
    $('.btnnext').click(function () {
        if (current_page < 3 && validatePage(current_page)) {
            switchPage(current_page + 1);
            buttongroup(current_page);
        }
    });
    $('input').keypress(function () {
        $(this).removeClass('error_required');
        $(this).parent().find('.error_msg').remove();
    });
    buttongroup(current_page);
});

function switchPage(target) {
    for (var i = target; i < 4; i++) {
        $('div.step[data-target="' + i + '"]').parent().removeClass("done").removeClass("active");
    }

    for (var i =0 ; i < target; i++) {
        $('div.step[data-target="' + i + '"]').parent().addClass("done").removeClass("active");
    }

    $("#wzardstep" + current_page).hide();
    $("#wzardstep" + target).css({ "left": 300, "opacity": 0 });
    $("#wzardstep" + target).show();
    $("#wzardstep" + target).animate({
        opacity: 1.0,
        left: 0,
    }, 300, function () {
        // Animation complete.
    });
    current_page = parseInt(target);
    $('div.step[data-target="' + current_page + '"]').parent().addClass("active");
}

//Function to validate the each step
function validatePage(page) {
    var result = true;
    $('.error_msg').remove();
    if (page == 0) {
        //Check the required field.
        $('input').each(function () {
            if ($(this).hasClass('required')) {
                if ($(this).val().length == 0) {
                    $(this).addClass('error_required');
                    addErrorField(this, "This field is requried");
                    result = false;
                }
            }
            if ($(this).hasClass('maxchars')) {
                if ($(this).val().length> $(this).attr('data-max')) {
                    $(this).addClass('error_required');
                    addErrorField(this, "This field length has to be less than " + $(this).attr('data-max'));
                    result = false;
                }
            }
        });
    }
    return result;
}
//Add error field
function addErrorField(obj,message) {
    $(obj).after("<div class='error_msg'>"+message+"</div>");
}

function buttongroup(page) {
    if (page == 0) {
        $('.btnprev').addClass('firststep');
    } else $('.btnprev').removeClass('firststep');
    if (page == 3) {
        $('.btnnext').val("Finish");
    } else $('.btnnext').val("Next");
}