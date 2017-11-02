mainapp.filter('startFrom', function () {
    return function (input, start) {
        start = +start; //parse to int
        return input.slice(start);
    }
});

mainapp.controller('verifyController', function ($scope, $http) {
    $scope.currentPage = 1;
    $scope.pageSize = 10;
    $scope.requests = [];
    $scope.allrequests = [];
    $scope.allnumber = 0;
    $scope.numberOfPages = function () {
        // return Math.ceil($scope.requests.length / $scope.pageSize);
        return Math.ceil($scope.allnumber / $scope.pageSize);
    }
    //Sorting..
    $scope.sortingfield = "UserID";
    $scope.sorttype = 0;

    $scope.changesort = function (field) {
        if ($scope.sortingfield != field) {
            $scope.sorttype = 1;
        } else {
            $scope.sorttype = 1- $scope.sorttype;
        }
        $scope.sortingfield = field;
    }

    $scope.getVerified = function (status) {
        if (status == null || status == "0") {
            return "Unverified";
        } else return "Verified";
    }

    $scope.decodeHtml=function (html) {
        var txt = document.createElement("textarea");
        txt.innerHTML = html;
        return txt.value;
    }

    $scope.filterfunction = function (request) {
        // if(request.employeeemail==null || !request.employeeemail.includes($scope.empid)) return false;
        return true;
    };


    $scope.list_properties = function (page) {
        $http({
            url: '/apiadmin.aspx/get_unverifiedpropertylist',
            method: "POST",
            data: "{ \"page\": "+(page-1)+", \"sorting_field\":\""+$scope.sortingfield+"\", \"sorttype\":"+$scope.sorttype+"}",
            dataType:"json",
            headers:{"Content-Type":"application/json"}
        })
        .then(function (response) {
            // success
            $scope.allrequests = response.data.d;
            console.log(response.data);
        },
        function (response) { // optional
            // failed
        });
    }

    $scope.getall_mapunverified_properties = function () {
        $http({
            url: '/apiadmin.aspx/getnumber_unverifiedpropertylist',
            method: "POST",
            data: {},
            headers: { "Content-Type": "application/json" }
        })
        .then(function (response) {
            // success
            //$scope.allrequests = response.data.d;
            $scope.allnumber = response.data.d;
            console.log(response.data);
        },
        function (response) { // optional
            // failed
        });
    }

    $scope.update = function () {
        $scope.list_properties(0);
        $scope.getall_mapunverified_properties();
    }
    $scope.update();

    $scope.downloadcsv = function () {
        var table = document.getElementById("table");
        var csvString = '';
        var rowData = table.rows[0].cells;
        for (var j = 0; j < rowData.length; j++) {
            csvString = csvString + rowData[j].innerHTML.replace(/(<([^>]+)>)/g, "").replace(/[\s+]/g, "") + ",";
        }
        csvString = csvString.substring(0, csvString.length - 1);
        csvString = csvString + "\n";
        var fields = [{ name: "created", type: 0, filter: "", prefix: 0 }, { name: "amount", type: 0, filter: "$", prefix: 0 }, { name: "sname", type: 0, filter: "", prefix: 0 }, { name: "rname", type: 0, filter: "", prefix: 0 }, { name: "getid", type: 1, filter: "", params: ["rid", "rtype"], count: 2 }
        , { name: "getid", type: 1, filter: "", params: ["sid", "stype"], count: 2 }, { name: "sbalance", type: 0, filter: "$", prefix: 0 }, { name: "incoming", type: 0, filter: "$", prefix: 0 }, { name: "outgoing", type: 0, filter: "$", prefix: 0 }, { name: "getStatus", type: 1, filter: "", params: ["status"] }];
        for (var i = 0; i < $scope.requests.length; i++) {
            var request = $scope.requests[i];
            var count = fields.length;
            csvString = csvString + (i + 1) + ",";
            for (var j = 0; j < count; j++) {
                var field = fields[j];
                var filter = "", afterfilter = "";
                if (j == 9) csvString = csvString + " " + ",";
                if (field.type == 0) {
                    if (field.prefix == 0) filter = field.filter;
                    else afterfilter = field.filter;
                    csvString = csvString + filter + request[field.name].toString().replace(/[,]/g, "") + afterfilter + ",";
                }
                else {
                    var res;
                    if (field.count == 2) res = $scope[field.name](request[field.params[0]], request[field.params[1]]);
                    else res = $scope[field.name](request[field.params[0]]);
                    csvString = csvString + res + ",";
                }
            }
            csvString = csvString.substring(0, csvString.length - 1);
            csvString = csvString + "\n";
        }
        csvString = csvString.substring(0, csvString.length - 1);
        var a = $('<a/>', {
            style: 'display:none',
            href: 'data:application/octet-stream;base64,' + btoa(csvString),
            download: 'emailStatistics.csv'
        }).appendTo('body')
        a[0].click()
        a.remove();
    }
});

