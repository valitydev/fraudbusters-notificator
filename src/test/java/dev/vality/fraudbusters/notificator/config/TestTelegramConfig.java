package dev.vality.fraudbusters.notificator.config;

import dev.vality.fraudbusters.notificator.service.iface.TelegramSenderService;
import org.mockito.Mockito;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Profile;

@TestConfiguration
@Profile("test")
public class TestTelegramConfig {

    @Bean
    @Primary
    public TelegramSenderService telegramSenderService() {
        return Mockito.mock(TelegramSenderService.class);
    }
}