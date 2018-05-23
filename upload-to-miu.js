#!/usr/bin/node
const request = require("request");
const fs = require("fs");
const os = require("os");
const child_process = require("child_process");

function MiuUploadFile(path) {

    fs.stat(path, (err, stats) => {
        if (err) {
            return;
        }

        var res = request.post({
            url: "https://i.onozuka.info/getfile/",
            formData: {
                meowfile_remote: fs.createReadStream(path),
                private_key: "dc9dfc92a3ed606e83092f4e43793496"
            }
        }, (error, res, body) => {
            var responseJson = JSON.parse(body);
            child_process.spawn("notify-send", ["Miniature Image Uploader", `URL: ${responseJson.file}`]);
        });
    });
}

if (process.env.NAUTILUS_SCRIPT_CURRENT_URI) {
    try {
        process.env.NAUTILUS_SCRIPT_SELECTED_FILE_PATHS.split("\n").forEach((path) => {
            if (path !== "") {
                child_process.spawn("notify-send", ["Miniature Image Uploader", `Uploading ${path}`]);
                MiuUploadFile(path);
            }
        });
    } catch (except) {
        child_process.spawn("notify-send", ["Miniature Image Uploader", `Err: ${except.message}`]);
    }
} else {
    MiuUploadFile(process.argv[2]);
}
