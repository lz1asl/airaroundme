$(document).ready(function() {
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