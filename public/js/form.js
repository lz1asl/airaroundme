$(document).ready(function() {
    $.ajax({
        url: 'severities',
        type: 'GET',
        dataType: 'json',
        success: function (json) {
            $.each(json, function (i, value) {
                debugger;
                $('#severities').append($('<option>').text(value).attr('value', value));
            });
        },
        failure: function (json) {
            debugger;
        }
    });
});