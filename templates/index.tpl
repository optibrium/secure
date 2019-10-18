<!DOCTYPE html>
<html>
    <head>
        <script src='/static/vendor/aes-min.js'></script>
        <script src='/static/vendor/sha3-min.js'></script>
        <script src='/static/secure.js'></script>
        <link rel="stylesheet" type="text/css" href="/static/secure.css">
    </head>
    <body>
        <div class="header centered">
            <h1>SecureClip</h1>
            <h3>For when you need to reach out and paste something</h3>
        </div>
        <div class="centered">
            <textarea id='input'></textarea>
        </div>
        <div class="centered">
            <span class="selector">
                <label>Expires in</label>
                <select id='ttl'>
                    <option value='60'>1 minute</option>
                    <option value='120'>2 minutes</option>
                    <option value='300' selected="selected">5 minutes</option>
                    <option value='600'>10 minutes</option>
                    <option value='3600'>1 hour</option>
                    <option value='86400'>24 hours</option>
                    <option value='604800'>1 week</option>
                </select>
            </span>
            <span class="selector">
                <label>Burn After Reading</label>
                <input type='checkbox' id='burn_after_reading'></input>
            </span>
            <span class="selector">
                <label>Out Of Band Required</label>
                <input type='checkbox' id='double_encrypted'></input>
            </span>
            <span class="selector send" onclick="send()">
                <span>send</span>
            </span>
        </div>
        <div class="centered">
            <p id='out_of_band_password'></p>
        </div>
        <div class="centered">
            <p id='url'></p>
        </div>
    </body>
</html>
