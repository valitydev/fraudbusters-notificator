INSERT INTO fb_notificator.notification_template (name, type, skeleton, basic_params, query_text)
VALUES ('Data recording stop check', 'MAIL_FORM', '<>', 'cardToken',
        'SELECT count() AS сnt ' ||
        'FROM fraud.payment ' ||
        'WHERE toDateTime(:currentDate) - INTERVAL 30 minute <= eventTime and count() > 0 ' ||
        'AND shopId != ''TEST''');

---notification
INSERT INTO fb_notificator.notification (name, subject, period, frequency, channel, status, template_id)
VALUES ('notification_16', 'Data recording stop check', '1d', '30m', 'sb-channel', 'ACTIVE', 16);
