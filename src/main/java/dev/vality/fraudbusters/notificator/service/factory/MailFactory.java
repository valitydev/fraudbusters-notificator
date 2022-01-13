package dev.vality.fraudbusters.notificator.service.factory;

import dev.vality.fraudbusters.notificator.dao.ChannelDao;
import dev.vality.fraudbusters.notificator.dao.domain.tables.pojos.Channel;
import dev.vality.fraudbusters.notificator.domain.Attachment;
import dev.vality.fraudbusters.notificator.domain.Message;
import dev.vality.fraudbusters.notificator.domain.ReportModel;
import dev.vality.fraudbusters.notificator.exception.UnknownRecipientException;
import dev.vality.fraudbusters.notificator.serializer.QueryResultSerde;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class MailFactory {

    private final ChannelDao channelDao;
    private final AttachmentFactory attachmentFactory;
    private final QueryResultSerde queryResultSerde;
    @Value("${mail.smtp.from-address}")
    public String fromAddress;

    public Optional<Message> create(ReportModel reportModel) {
        String alertChannel = reportModel.getNotification().getChannel();
        Channel channel = channelDao.getByName(alertChannel);
        if (channel == null) {
            log.warn("Not found channel with name: {}", alertChannel);
            return Optional.empty();
        }
        String subject = reportModel.getNotification().getSubject();
        String content = reportModel.getNotificationTemplate().getSkeleton();
        return Optional.of(Message.builder()
                .content(content)
                .to(initRecipient(channel))
                .subject(subject)
                .from(fromAddress)
                .attachment(initAttachment(reportModel, subject))
                .build());
    }

    private String[] initRecipient(Channel channel) {
        String[] split = channel.getDestination().trim().split("\\s*,\\s*");
        if (split.length == 0) {
            throw new UnknownRecipientException("Unknown recipient or can't parse: " + channel.getDestination());
        }
        return split;
    }

    private Attachment initAttachment(ReportModel reportModel, String subject) {
        return queryResultSerde.deserialize(reportModel.getCurrentReport().getResult())
                .map(queryResult ->
                        Attachment.builder()
                                .content(attachmentFactory.create(queryResult.getResults()))
                                .fileName(attachmentFactory.createNameOfAttachment(subject))
                                .build())
                .orElse(null);
    }

}
