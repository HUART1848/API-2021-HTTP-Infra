$(function (){
    console.log("Loading cats...");

    function loadCats() {
        $.getJSON("/dynamic/", function(cats) {
            message = "";
            for (var i = 0; i < cats.length; ++i) {
                message += "<p class=\"font-mono\">Cat #" + i + " aged " + cats[i].age + " and of breed '" + cats[i].breed
                    + "' is " + cats[i].status + "!</p>";
            }
            $("#cats").html(message);
        });
    };

    setInterval(() => {
        loadCats();
    }, 7000);
})
