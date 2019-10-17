"use strict";

var element = (id) =>
{
    return document.getElementById(id)
};

var send = () =>
{
    if(!element('input').value.length)
        return

    var password = generate_password(32)
    var text = encrypt(element('input').value, password)

    if(element('double_encrypted').checked)
    {
        var out_of_band_password = generate_password(32)
        text = encrypt(text, out_of_band_password)
        element('out_of_band_password').innerHTML = pass_template(out_of_band_password)
    }

    save_to_server({
        'burn_after_reading': element('burn_after_reading').checked,
        'double_encrypted': element('double_encrypted').checked,
        'text': text,
        'ttl': element('ttl').value
    }, (reply)=>
    {
        element('url').innerHTML = url_template(reply.id, password)
    })
};

var generate_password = (length) =>
{
    var random_data = crypto.getRandomValues(new Uint32Array(128)).join()
    var hash = CryptoJS.SHA3(random_data)
    return hash.toString().slice(0, length)
};

var encrypt = (message, password) =>
{
    var encrypted = CryptoJS.AES.encrypt(message, password)
    return encrypted.toString()
};

var decrypt = (message, password) =>
{
    var decrypted = CryptoJS.AES.decrypt(message, password);
    return decrypted.toString(CryptoJS.enc.Utf8)
};

var save_to_server = (data, callback) =>
{
    fetch(window.location.origin,
    {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(resp => resp.json())
    .then(reply => callback(reply))
};

var url_template = (id, password) =>
{
    return `<span class="url_populated">${window.location.origin}/?${id}#${password}</span>`
};

var pass_template = (password) =>
{
    return `<span class="pass_populated"><span>Out Of Band Password: </span><span>${password}</span></span>`
};

var message_template = (message) =>
{
    return `<pre>${message}</pre>`
};

var copy_url_to_clipboard = () =>
{
    document.getElementById('url').focus()
    document.execCommand("selectAll")
    document.execCommand("copy")
};
