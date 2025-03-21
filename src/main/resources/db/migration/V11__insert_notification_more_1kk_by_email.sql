INSERT INTO fb_notificator.notification_template (name, type, skeleton, basic_params, query_text)
VALUES ('> 1kk RUB by email', 'MAIL_FORM', '<>', 'partyId, shopId, currency, email',
        'SELECT partyId, shopId, currency, email,
                    multiIf(
                    currency = ''BRL'', multiply(toFloat64(sum(amount)) , 15.3523),
                    currency = ''RUB'', multiply(toFloat64(sum(amount)) , 1),
                    currency = ''PHP'', multiply(toFloat64(sum(amount)) , 1.645),
                    currency = ''KZT'', multiply(toFloat64(sum(amount)) , 0.1797),
                    currency = ''UZS'', multiply(toFloat64(sum(amount)) , 0.00696),
                    currency = ''NGN'', multiply(toFloat64(sum(amount)) , 0.195),
                    currency = ''TRY'', multiply(toFloat64(sum(amount)) , 2.4644),
                    currency = ''AZN'', multiply(toFloat64(sum(amount)) , 52.8164),
                    currency = ''EUR'', multiply(toFloat64(sum(amount)) , 95.7035),
                    currency = ''ZAR'', multiply(toFloat64(sum(amount)) , 4.8751),
                    currency = ''GHS'', multiply(toFloat64(sum(amount)) , 7.5),
                    currency = ''USD'', multiply(toFloat64(sum(amount)) , 89.7878),
                    currency = ''JPY'', multiply(toFloat64(sum(amount)) , 0.5994),
                    currency = ''KRW'', multiply(toFloat64(sum(amount)) , 0.0615),
                    currency = ''PLN'', multiply(toFloat64(sum(amount)) , 23.1501),
                    currency = ''TJS'', multiply(toFloat64(sum(amount)) , 8.2091),
                    currency = ''VES'', multiply(toFloat64(sum(amount)) , 0.0045),
                    currency = ''CLP'', multiply(toFloat64(sum(amount)) , 0.11),
                    currency = ''CAD'', multiply(toFloat64(sum(amount)) , 61.9696),
                    currency = ''NOK'', multiply(toFloat64(sum(amount)) , 8.0275),
                    currency = ''KES'', multiply(toFloat64(sum(amount)) , 0.63),
                    currency = ''BDT'', multiply(toFloat64(sum(amount)) , 0.84),
                    currency = ''MXN'', multiply(toFloat64(sum(amount)) , 4.5),
                    currency = ''THB'', multiply(toFloat64(sum(amount)) , 2.464),
                    currency = ''AUD'', multiply(toFloat64(sum(amount)) , 56.1174),
                    currency = ''INR'', multiply(toFloat64(sum(amount)) , 1.031),
                    currency = ''NZD'', multiply(toFloat64(sum(amount)) , 50.7615),
                    currency = ''MYR'', multiply(toFloat64(sum(amount)) , 19.5),
                    currency = ''PEN'', multiply(toFloat64(sum(amount)) , 23),
                    currency = ''COP'', multiply(toFloat64(sum(amount)) , 0.0225),
                    currency = ''HKD'', multiply(toFloat64(sum(amount)) , 11.5736),
                    currency = ''QAR'', multiply(toFloat64(sum(amount)) , 24.667),
                    currency = ''SAR'', multiply(toFloat64(sum(amount)) , 23.95),
                    currency = ''IDR'', multiply(toFloat64(sum(amount)) , 0.00546),
                    currency = ''AED'', multiply(toFloat64(sum(amount)) , 24.4487),
                    currency = ''UAH'', multiply(toFloat64(sum(amount)) , 2.1595),
                    currency = ''VND'', multiply(toFloat64(sum(amount)) , 0.003502),
                    currency = ''PKR'', multiply(toFloat64(sum(amount)) , 0.56),
                    currency = ''KGS'', multiply(toFloat64(sum(amount)) , 1.0267),
                    currency = ''ARS'', multiply(toFloat64(sum(amount)) , 0.3),
                    currency = ''MMK'', multiply(toFloat64(sum(amount)) , 0.042),
                    currency = ''KHR'', multiply(toFloat64(sum(amount)) , 0.022),
                    currency = ''SGD'', multiply(toFloat64(sum(amount)) , 67.0008),
                    currency = ''TWD'', multiply(toFloat64(sum(amount)) , 2.95),
                    currency = ''SEK'', multiply(toFloat64(sum(amount)) , 8.5399),
                    currency = ''GTQ'', multiply(toFloat64(sum(amount)) , 11.5),
                    currency = ''BOB'', multiply(toFloat64(sum(amount)) , 13),
                    currency = ''CRC'', multiply(toFloat64(sum(amount)) , 0.145),
                    currency = ''HNL'', multiply(toFloat64(sum(amount)) , 3.65),
                    currency = ''CZK'', multiply(toFloat64(sum(amount)) , 3.7833),
                    currency = ''BYN'', multiply(toFloat64(sum(amount)) , 27.6918),
                    currency = ''OMR'', multiply(toFloat64(sum(amount)) , 233.5),
                    currency = ''CHF'', multiply(toFloat64(sum(amount)) , 101.3635),
                    toFloat64(sum(amount))) / 100 as sumRub
                    FROM fraud.payment
                    WHERE subtractDays(toDate(:currentDate), 30) <= timestamp AND shopId != ''TEST'' AND email != ''UNKNOWN''
                    GROUP BY partyId, shopId, currency, email
                    HAVING
                    multiIf(
                    currency = ''BRL'', multiply(toFloat64(sum(amount)) , 15.3523),
                    currency = ''RUB'', multiply(toFloat64(sum(amount)) , 1),
                    currency = ''PHP'', multiply(toFloat64(sum(amount)) , 1.645),
                    currency = ''KZT'', multiply(toFloat64(sum(amount)) , 0.1797),
                    currency = ''UZS'', multiply(toFloat64(sum(amount)) , 0.00696),
                    currency = ''NGN'', multiply(toFloat64(sum(amount)) , 0.195),
                    currency = ''TRY'', multiply(toFloat64(sum(amount)) , 2.4644),
                    currency = ''AZN'', multiply(toFloat64(sum(amount)) , 52.8164),
                    currency = ''EUR'', multiply(toFloat64(sum(amount)) , 95.7035),
                    currency = ''ZAR'', multiply(toFloat64(sum(amount)) , 4.8751),
                    currency = ''GHS'', multiply(toFloat64(sum(amount)) , 7.5),
                    currency = ''USD'', multiply(toFloat64(sum(amount)) , 89.7878),
                    currency = ''JPY'', multiply(toFloat64(sum(amount)) , 0.5994),
                    currency = ''KRW'', multiply(toFloat64(sum(amount)) , 0.0615),
                    currency = ''PLN'', multiply(toFloat64(sum(amount)) , 23.1501),
                    currency = ''TJS'', multiply(toFloat64(sum(amount)) , 8.2091),
                    currency = ''VES'', multiply(toFloat64(sum(amount)) , 0.0045),
                    currency = ''CLP'', multiply(toFloat64(sum(amount)) , 0.11),
                    currency = ''CAD'', multiply(toFloat64(sum(amount)) , 61.9696),
                    currency = ''NOK'', multiply(toFloat64(sum(amount)) , 8.0275),
                    currency = ''KES'', multiply(toFloat64(sum(amount)) , 0.63),
                    currency = ''BDT'', multiply(toFloat64(sum(amount)) , 0.84),
                    currency = ''MXN'', multiply(toFloat64(sum(amount)) , 4.5),
                    currency = ''THB'', multiply(toFloat64(sum(amount)) , 2.464),
                    currency = ''AUD'', multiply(toFloat64(sum(amount)) , 56.1174),
                    currency = ''INR'', multiply(toFloat64(sum(amount)) , 1.031),
                    currency = ''NZD'', multiply(toFloat64(sum(amount)) , 50.7615),
                    currency = ''MYR'', multiply(toFloat64(sum(amount)) , 19.5),
                    currency = ''PEN'', multiply(toFloat64(sum(amount)) , 23),
                    currency = ''COP'', multiply(toFloat64(sum(amount)) , 0.0225),
                    currency = ''HKD'', multiply(toFloat64(sum(amount)) , 11.5736),
                    currency = ''QAR'', multiply(toFloat64(sum(amount)) , 24.667),
                    currency = ''SAR'', multiply(toFloat64(sum(amount)) , 23.95),
                    currency = ''IDR'', multiply(toFloat64(sum(amount)) , 0.00546),
                    currency = ''AED'', multiply(toFloat64(sum(amount)) , 24.4487),
                    currency = ''UAH'', multiply(toFloat64(sum(amount)) , 2.1595),
                    currency = ''VND'', multiply(toFloat64(sum(amount)) , 0.003502),
                    currency = ''PKR'', multiply(toFloat64(sum(amount)) , 0.56),
                    currency = ''KGS'', multiply(toFloat64(sum(amount)) , 1.0267),
                    currency = ''ARS'', multiply(toFloat64(sum(amount)) , 0.3),
                    currency = ''MMK'', multiply(toFloat64(sum(amount)) , 0.042),
                    currency = ''KHR'', multiply(toFloat64(sum(amount)) , 0.022),
                    currency = ''SGD'', multiply(toFloat64(sum(amount)) , 67.0008),
                    currency = ''TWD'', multiply(toFloat64(sum(amount)) , 2.95),
                    currency = ''SEK'', multiply(toFloat64(sum(amount)) , 8.5399),
                    currency = ''GTQ'', multiply(toFloat64(sum(amount)) , 11.5),
                    currency = ''BOB'', multiply(toFloat64(sum(amount)) , 13),
                    currency = ''CRC'', multiply(toFloat64(sum(amount)) , 0.145),
                    currency = ''HNL'', multiply(toFloat64(sum(amount)) , 3.65),
                    currency = ''CZK'', multiply(toFloat64(sum(amount)) , 3.7833),
                    currency = ''BYN'', multiply(toFloat64(sum(amount)) , 27.6918),
                    currency = ''OMR'', multiply(toFloat64(sum(amount)) , 233.5),
                    currency = ''CHF'', multiply(toFloat64(sum(amount)) , 101.3635),
                    toFloat64(sum(amount))) > toFloat64(100000000)');
