$(document).ready(function() {
    // Load symptom dropdown options
    $.ajax({
        url: 'symptom',
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
        url: 'severities',
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
});