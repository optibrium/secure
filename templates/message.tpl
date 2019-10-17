<!DOCTYPE html>
<html>
    <head>
        <script>
            var message = "{{ message.text }}";
            var init = () =>
            {

                {% if message.double_encrypted %}

                var password = element('out_of_band_password_input').value
                message = decrypt(message, password)

                {% endif %}

                var password = location.hash.replace('#', '')
                var decrypted = decrypt(message, password)
                if (decrypted.length)
                {
                    element('message').innerHTML = message_template(decrypted)
                }

            };
        </script>
        <script src='/static/vendor/aes-min.js'></script>
        <script src='/static/vendor/sha3-min.js'></script>
        <script src='/static/secure.js'></script>
        <link rel="stylesheet" type="text/css" href="/static/secure.css">
    </head>
    <body>
        <div id="message">

            {% if message.double_encrypted %}

                <input id="out_of_band_password_input" type="text" placeholder="Enter your Out Of Band password"></input>
                <button onclick="init()">Decrypt</button>

            {% else %}

                <div id="message">Unfortunately we were not able to decrypt your message</div>
                <script>init();</script>

            {% endif %}

        </div>
    </body>
</html>
