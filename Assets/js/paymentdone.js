
$(document).ready(function () {
    console.log("doc ready");
    setTimeout(gotoListing, 5000);
});

function gotoListing() {
    window.location.href = "/userowner/listings.aspx?UserID="+$("#userid").val();
}
