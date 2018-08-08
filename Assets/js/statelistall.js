$(document).ready(function () {
    var statename = $('#statename').val();
    var title = "Vacations Abroad is a directory of " + statename + " Vacation Rentals and " + statename + " Boutique Hotels";
    $('#footerlogo').attr({ "title": title, "alt": title });

    //For step box item width
    var step_width = $('.borerstep').width();
    console.log("step box width:" + step_width);

    $('.colfield_2').width(step_width - 70);
    if (step_width <= 768) $('.colfield_s2').width(step_width - 70);

    //Refresh the radio buttons
    RefreshStepbox();
});

function RefreshStepbox() {
    //For proptype  proptyperadio
    var proptype = $('input:hidden[name = proptyperadio]').val();
    $("input[name=proptype][value=" + proptype + "]").attr('checked', 'checked');
    //For Room Number  roomnums
    var roomnums = $('input:hidden[name = bedroomtyperadio]').val();
    $("input[name=roomnums][value=" + roomnums + "]").attr('checked', 'checked');
    //For   Amenity Type
    var amenity = $('input:hidden[name = amenityradio]').val();
    $("input[name=amenitytype][value=" + amenity + "]").attr('checked', 'checked');
    //For Sort  proptyperadio
    var sort = $('input:hidden[name = sortradio]').val();
    $("input[name=pricesort][value=" + sort + "]").attr('checked', 'checked');
}

