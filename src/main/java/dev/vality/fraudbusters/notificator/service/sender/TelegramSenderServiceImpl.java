package dev.vality.fraudbusters.notificator.service.sender;

import dev.vality.fraudbusters.notificator.domain.Message;
import dev.vality.fraudbusters.notificator.exception.TelegramSendException;
import dev.vality.fraudbusters.notificator.service.VaultSecretService;
import dev.vality.fraudbusters.notificator.service.iface.TelegramSenderService;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.telegram.telegrambots.bots.TelegramLongPollingBot;
import org.telegram.telegrambots.meta.api.methods.send.SendDocument;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;
import org.telegram.telegrambots.meta.api.objects.InputFile;
import org.telegram.telegrambots.meta.api.objects.Update;
import org.telegram.telegrambots.meta.exceptions.TelegramApiException;

import java.io.ByteArrayInputStream;

@Slf4j
@Component
public class TelegramSenderServiceImpl extends TelegramLongPollingBot implements TelegramSenderService {

    @Getter
    @Value("${telegram.bot.username}")
    private String botUsername;

    @Autowired
    public TelegramSenderServiceImpl(VaultSecretService vaultSecretService) {
        super(vaultSecretService.getBotToken());
    }

    @Override
    public void onUpdateReceived(Update update) {
        // Handle incoming updates if needed
    }

    @Override
    public boolean send(Message message) throws TelegramSendException {
        try {
            log.info("Sending Telegram message for party: {}, claim: {}, to: {}",
                    message.getPartyId(), message.getClaimId(), message.getTo());

            SendMessage sendMessage = new SendMessage();
            sendMessage.setChatId(message.getTo()[0]);
            sendMessage.setText("Subject: " + message.getSubject() + "\n\n" + message.getContent());

            execute(sendMessage);

            if (message.getAttachment() != null) {
                SendDocument sendDocument = new SendDocument();
                sendDocument.setChatId(message.getTo()[0]);
                sendDocument.setDocument(
                        new InputFile(new ByteArrayInputStream(message.getAttachment().getContent().getBytes()),
                                message.getAttachment().getFileName()));

                execute(sendDocument);
            }
            return true;
        } catch (TelegramApiException e) {
            log.error("Failed to send Telegram message for party: {}, claim: {}, to: {}",
                    message.getPartyId(), message.getClaimId(), message.getTo(), e);
            throw new TelegramSendException("Failed to send Telegram message", e);
        }
    }
}