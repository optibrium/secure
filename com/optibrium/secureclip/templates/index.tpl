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
            <textarea id='input' onfocus="hide_url_and_send()" onkeyup="hide_url_and_send()"></textarea>
        </div>
        <div id="out_of_band_password_container" class="centered hidden">
            <input
                type="password"
                id="out_of_band_password_first_input"
                placeholder="Please enter your out of band password..."
            ></input>
            <span
                id="send_out_of_band"
                title="send"
            >
                <img src='/static/arrow.svg' id="send_out_of_band_arrow"/>
            </span>
            <span
                id="show_password_container"
                title="show password"
                onmouseover="reveal_password()"
                onmouseout="unreveal_password()"
                >
                <img src='/static/eye.svg' id="show_password"/>
            </span>
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
            <span
                id="burn_after_reading"
                class="selector selectable"
                onclick="toggle_burn_after_reading()"
            >
                <span>Burn After Reading</span>
            </span>
            <span
                id="out_of_band"
                class="selector selectable"
                onclick="toggle_out_of_band()"
            >
                <span>Out Of Band Required</span>
            </span>
            <span id="send" class="selector selectable hidden" onclick="send()">
                <span>send</span>
            </span>
        </div>
        <div id="url_container" class="centered hidden">
            <span id="url"></span>
            <span
                id="clipboard_container"
                title="Copy to Clipboard"
                onmousedown="copy_to_clipboard()"
            >
                <img src='/static/clipboard.svg' id="clipboard"/>
            </span>
            <span id="green_tick" class="green_tick green_tick_hidden">
                <img src='/static/tick.svg' id="white_tick"/>
            </span>
        </div>
    </body>
</html>
