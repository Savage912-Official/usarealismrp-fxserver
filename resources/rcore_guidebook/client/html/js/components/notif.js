let notifBox;
let notifId = 0;

function addNotification(title, msg, style) {
    if (!notifBox || notifBox.length <= 0) notifBox = $('.js-notif');

    const notif =
        `<div class="notif-box__notif ` +
        `notif-box__notif--` +
        style +
        `" id="` + notifId + `">` +
        `<span class="notif-box__title">` +
        title +
        `</span>` +
        `<span class="notif-box__msg">` +
        msg +
        `</span>` +
        `</div>`;
    notifBox.prepend(notif);

    const thisNotifId = notifId++;

    setTimeout(() => {
        notifBox.find('#' + thisNotifId).remove();
    }, 7000);
}
