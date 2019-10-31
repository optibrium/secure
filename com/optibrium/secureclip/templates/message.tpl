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
                var window_password = location.hash.replace('#', '')

                {% if message.double_encrypted %}

                var out_of_band_password = element('out_of_band_password_second_input').value
                var inner_message = decrypt(message, out_of_band_password)
                var decrypted = decrypt(inner_message, window_password)

                {% else %}

                var decrypted = decrypt(message, window_password)

                {% endif %}

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
                    onkeydown="decrypt_key_down(event)"
                    id="out_of_band_password_second_input"
                    type="password"
                    placeholder="Enter your Out Of Band password"
                ></input>
                <script>element('out_of_band_password_second_input').focus()</script>

            {% else %}

                <div>Unfortunately we were not able to decrypt your message</div>
                <script>init();</script>

            {% endif %}

            </pre>
        </div>
        <a href='/'><button id="new_clip" class="selector centered link">Create a new clip</button></a>
    </body>
</html>
