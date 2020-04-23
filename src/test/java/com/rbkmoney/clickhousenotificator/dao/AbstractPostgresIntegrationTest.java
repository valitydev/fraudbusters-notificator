package com.rbkmoney.clickhousenotificator.dao;

import org.flywaydb.core.Flyway;
import org.junit.ClassRule;
import org.junit.runner.RunWith;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.test.util.TestPropertyValues;
import org.springframework.context.ApplicationContextInitializer;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.testcontainers.containers.PostgreSQLContainer;

import java.time.Duration;

@RunWith(SpringRunner.class)
@EnableConfigurationProperties({DataSourceProperties.class})
@ContextConfiguration(classes = {DataSourceAutoConfiguration.class},
        initializers = com.rbkmoney.clickhousenotificator.dao.AbstractPostgresIntegrationTest.Initializer.class)
@DirtiesContext(classMode = DirtiesContext.ClassMode.BEFORE_CLASS)
public abstract class AbstractPostgresIntegrationTest {

    @ClassRule
    public static PostgreSQLContainer postgres = (PostgreSQLContainer) new PostgreSQLContainer("postgres:9.6")
            .withStartupTimeout(Duration.ofMinutes(5));

    public static class Initializer implements ApplicationContextInitializer<ConfigurableApplicationContext> {
        @Override
        public void initialize(ConfigurableApplicationContext configurableApplicationContext) {
            TestPropertyValues.of(
                    "spring.datasource.hikari.jdbc-url=" + postgres.getJdbcUrl(),
                    "spring.datasource.hikari.username=" + postgres.getUsername(),
                    "spring.datasource.hikari.password=" + postgres.getPassword(),
                    "spring.flyway.url=" + postgres.getJdbcUrl(),
                    "spring.flyway.user=" + postgres.getUsername(),
                    "spring.flyway.password=" + postgres.getPassword()
            ).applyTo(configurableApplicationContext);
            Flyway flyway = Flyway.configure()
                    .dataSource(postgres.getJdbcUrl(), postgres.getUsername(), postgres.getPassword())
                    .schemas("ch_notification")
                    .load();
            flyway.migrate();
        }
    }

}