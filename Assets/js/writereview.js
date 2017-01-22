var images_count = 0;

function Validate() {
    var vValue = true;
    var str_error = "";
    rates = $('input[name=ratings]:checked').val();
    console.log(rates);
    if (rates == undefined) {
        str_error += "Please rate your overall stay. ";
        vValue = false;
    }

   vFName = $('#txtFName').val();
    vLName = $('#txtLName').val();
    vComments = $('#txtComments').val();
    vMonth = $('#ddlMonth').val();
    vYear = $('#ddlYear').val();
    vEmail = $('#email').val();
    vPhone = $('#txtPhone').val();

    console.log(vFName);


    if (vFName== "") {
        str_error +='Please enter first name.';
        vValue = false;
    }
    if ((vLName == '') || (vLName== null)) {
        str_error += 'Please enter last name. \n';
        vValue = false;
    }
    if (vMonth == 0) {
        str_error += 'Please specify month.\n';
        vValue = false;
    }
    if (vYear == 0) {
        str_error += 'Please specify year.\n';
        vValue = false;
    }
    if (vComments == "") {
        str_error += 'Please enter comments.\n';
        vValue = false;
    }
    if (vEmail == "") {
        str_error += 'Please enter email address.\n';
        vValue = false;
    }
    if (vPhone == "") {
        str_error += 'Please enter phone number.\n';
        vValue = false;
    }
       //        else {
    //            return true;
    //        }
    $('#lblInfo').text(str_error);
    console.log(str_error);
    return vValue;
}
var submit = 0;
var submitted=0;
function Submit() {
    if (submitted == 1) {
        viewloading();
        viewdisplayMsg("You've already reviewed.");
        return;
    }
    if (Validate() == false || submit == 1)
            return;
    viewloading();
    submit = 1;
    $.ajax({
        type: "POST",
        url: "/addcomments.aspx",
        data: $('form').serialize(),
        success: function (data) {
            submit = 0;
            submitted = 1;
            console.log(data);
            viewdisplayMsg("Review Success");
        },
        error: function (e) {
            submit = 0;
            console.log(e);
            viewdisplayMsg('Review Fail');
        },
        timeout: 5000
    });

}

function viewloading() {
    $('#inqureform').show();
    $('#modal_loading').show();
    $('#modal_dialog').hide();
}

function viewdisplayMsg(msg) {
    $('#modal_loading').hide();
    $('#modal_dialog').show();
    // alert("Review fail");
    $('#modalmsg').text(msg);
}

$(document).ready(function () {

    console.log("doc ready");

    $(window).click(function (event) {
        console.log("windows click");
        // $('#inqureform').hide();
        if (event.target.id == "inqureform") {
            $('#inqureform').hide();
        }
    });
    $('.mclose').click(function () {
        $('#inqureform').hide();
    });
});



function UploadFile() {
    if (images_count > 8) {
        alert("You are allowed to upload less than  10 images.");
        return;
    }
    var file = $('#imgfile').get(0).files[0];
    if (file == undefined) {
        alert("No file selected.");
        return;
    }
    var filetype=file['type'];
    console.log(filetype);
    var ValidImageTypes=['image/gif','image/jpeg','image/png'];
    if($.inArray(filetype, ValidImageTypes)<0){
        console.log("worng file type:"+filetype);
    }

    $('progress').attr({ value: 0, max: 100 });

    if (!confirm("Are you sure to upload this image?")) return;

    viewloading();

    var formdata = new FormData();
    //formdata.append('file',)
    formdata.append('file', file);
    $.ajax({
        url: "/fileupload.aspx",
        type: "POST",
       /* xhr: function () {
            var myXhr = $.ajaxSettings.xhr();
            if (myXhr.upload) {
                myXhr.upload.addEventListener('progress', progressHandler, false);

            }
            return myXhr;
        },*/
        success: completeHandler,
        error: errorHandler,
        data: formdata,
        cache: false,
        contentType: false,
        processData: false
    });
}

function progressHandler(e) {
  //  console.log(e);
    if (e.lengthComputable) {
        $('progress').attr({value:e.loaded, max:e.total});
    }
}


function completeHandler(e) {
    var file_name = e;
    var str = "<div class='srow'><div class='col-3 col-x-4'><img class='comimg' src='/img/comments/" + file_name + "' /></div>" +
          "<div class='col-9 col-x-4'><textarea class='comtxt' placeholder='write a review for the uploaded photo' id='com" + images_count + "' name='com" + images_count + "'></textarea><input type='hidden' name='img"+images_count+"' value='"+file_name+"' /></div></div>";
    $('#list_image').append(str);
    $('#image_count').val(++images_count);
    $('#imgfile').val('');
    viewdisplayMsg("image uploading success");
    console.log(images_count);
}

function errorHandler(e) {
    viewdisplayMsg("image uploading fail");
    console.log(e);
}
