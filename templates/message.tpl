<!DOCTYPE html>
<html>
    <head>
        <script src='/static/vendor/aes-min.js'></script>
        <script src='/static/vendor/sha3-min.js'></script>
        <script src='/static/secure.js'></script>
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
                    element('message').textContent = decrypted
                }

            };
        </script>
        <link rel="stylesheet" type="text/css" href="/static/secure.css">
    </head>
    <body>
        <div class="header centered">
            <h1>SecureClip</h1>
            <h3>For when you need to reach out and paste something</h3>
        </div>
        <div id="message_container" class="centered">
            <pre id="message">

            {% if message.double_encrypted %}

                <input
                    onkeydown="decryptKeyDown(event)"
                    id="out_of_band_password_input"
                    type="text"
                    placeholder="Enter your Out Of Band password"
                ></input>

            {% else %}

                <div>Unfortunately we were not able to decrypt your message</div>
                <script>init();</script>

            {% endif %}

            </pre>
        </div>
        <a href='/'><button class="selector centered link">Create a new clip</button></a>
    </body>
</html>
