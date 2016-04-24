$(document).ready(function() {
    // Load symptom dropdown options
    $.ajax({
        url: '/sympthoms',
        type: 'GET',
        dataType: 'json',
        success: function (json) {
            $.each(json, function (i, value) {
                $('#symptoms').append($('<option>').text(value.label).attr('value', value.id));
            });
        },
        failure: function (json) {
            console.error('Cannot load the symptoms options: ' + JSON.parse(json))
        }
    });

    // Load severity dropdown options
    $.ajax({
        url: '/severities',
        type: 'GET',
        dataType: 'json',
        success: function (json) {
            $.each(json, function (i, value) {
                $('#severities').append($('<option>').text(value.label).attr('value', value.id));
            });
        },
        failure: function (json) {
            console.error('Cannot load the severities options: ' + JSON.parse(json))
        }
    });

    // Submit the report
    $("#report-button").click(function(e) {
        var body = {
            lat: map.center.lat(),
            lon: map.center.lng(),
            from: $("#from").val(),
            note: $("#note").val(),
            severity: parseInt($("#severities").val()),
            sympthom: parseInt($("#symptoms").val())
        };

        e.preventDefault();

        $.ajax({
            url: "/report",
            type: "POST",
            data: JSON.stringify(body),
            contentType: "application/json",
            success: function(result) {
                $("sharelink").html(result);
            }
        });
    });
});