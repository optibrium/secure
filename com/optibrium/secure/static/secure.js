"use strict";

const element = (id) =>
{
    return document.getElementById(id)
};

const send = () =>
{
    if(!element('input').value.length)
        return

    var password = generate_password(32)
    var text = encrypt(element('input').value, password)

    if(element('double_encrypted').checked)
    {
        request_out_of_band_password((out_of_band_password) =>
        {
            text = encrypt(text, out_of_band_password)
            save_to_server(text, (reply)=>
            {
                show_url(url_template(reply.id, password))
            })
        })
    }
    else
    {
        save_to_server(text, (reply)=>
        {
            show_url(url_template(reply.id, password))
        })
    }
};

const request_out_of_band_password = (callback) =>
{
    element('out_of_band_password_container').classList.remove('hidden')
    element('send').classList.add('hidden')
    element('out_of_band_password_first_input').onkeydown = out_of_band_key_down.bind({}, () =>
    {
        var out_of_band_password = element('out_of_band_password_first_input').value
        if(out_of_band_password.length)
        {
            callback(out_of_band_password)
        }
    })
};

const generate_password = (length) =>
{
    var random_data = crypto.getRandomValues(new Uint32Array(128)).join()
    var hash = CryptoJS.SHA3(random_data)
    return hash.toString().slice(0, length)
};

const encrypt = (message, password) =>
{
    var encrypted = CryptoJS.AES.encrypt(message, password)
    return encrypted.toString()
};

const decrypt = (message, password) =>
{
    var decrypted = CryptoJS.AES.decrypt(message, password);
    return decrypted.toString(CryptoJS.enc.Utf8)
};

const save_to_server = (text, callback) =>
{
    fetch(window.location.origin,
    {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
            'burn_after_reading': element('burn_after_reading').checked,
            'double_encrypted': element('double_encrypted').checked,
            'text': text,
            'ttl': element('ttl').value
        })
    })
    .then(resp => resp.json())
    .then(reply => callback(reply))
};

const url_template = (id, password) =>
{
    return `${window.location.origin}/?${id}#${password}`
};

const decrypt_key_down = (event) =>
{
    if (event.key == 'Enter')
        init()
};

const out_of_band_key_down = (callback, event) =>
{
    if (event.key == 'Enter')
        callback()
};

const reveal_password = () =>
{
    element('out_of_band_password_first_input').type = 'text'
};

const unreveal_password = () =>
{
    element('out_of_band_password_first_input').type = 'password'
};

const hide_url = ()=>
{
    element('url_container').classList.add('hidden')
    element('out_of_band_password_container').classList.add('hidden')
    element('send').classList.remove('hidden')
};

const show_url = (url)=>
{
    element('url').innerHTML = url
    element('url_container').classList.remove('hidden')
};

const copy_to_clipboard = () =>
{
    var temp = document.createElement('textarea')
    temp.value = element('url').innerText
    document.body.appendChild(temp)
    temp.select()
    document.execCommand('copy')
    document.body.removeChild(temp)
    element('green_tick').classList.remove('green_tick_hidden')
    setTimeout(() =>
    {
        element('green_tick').classList.add('green_tick_hidden')
    }, 2000)
};
