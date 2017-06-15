$(document).ready(function () {
    var countryname = $('#countryname').val();
    var title = "Vacations Abroad is a directory of " + countryname + " Vacation Rentals and " + countryname + " Hotels";
    $('#footerlogo').attr({ "title": title, "alt": title });
});