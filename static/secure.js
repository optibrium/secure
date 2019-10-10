"use strict";

var encrypt = () =>
{
    var burn_after_reading = document.getElementById('burn_after_reading').value

    var text = document.getElementById('input').value
    var random_data = crypto.getRandomValues(new Uint32Array(128)).join()
    var hash = CryptoJS.SHA3(random_data)
    var password = hash.toString()
    var encrypted = CryptoJS.AES.encrypt(text, password);
    var encrypted_string = encrypted.toString(CryptoJS.enc.Utf8)

    var ttl = document.getElementById('ttl').value

    fetch(server_address,
    {
        method: 'POST',
        body: JSON.stringify({
            'burn_after_reading': burn_after_reading,
            'text': encrypted_string,
            'ttl': ttl
        })
    })
    .then(resp => resp.json())
    .then(reply =>
    {
        document.getElementById('url').innerHTML = `<pre>${server_address}/get/${reply.id}#${password}</pre>`
    })
};

var copy_url_to_clipboard = () =>
{

    document.getElementById('url').focus()
    document.execCommand("selectAll")
    document.execCommand("copy")
};
