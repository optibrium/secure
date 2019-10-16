<!DOCTYPE html>
<html>
    <head>
        <script>
            var message = "{{ message.text }}";
        </script>
        <script src='/static/vendor/aes-min.js'></script>
        <script src='/static/vendor/sha3-min.js'></script>
        <script src='/static/secure.js'></script>
        <link rel="stylesheet" type="text/css" href="/static/secure.css">
    </head>
    {% if message.double_encrypted %}
    <body>
        <div id="message">
            <input id="out_of_band_password_input" type="text" placeholder="Enter your Out Of Band password"></input>
            <button onclick="double_init()">Decrypt</button>
        </div>
    </body>
    {% else %}
    <body onload="single_init()">
        <div id="message">Unfortunately we were not able to decrypt your message</div>
    </body>
    {% endif %}
</html>
