package com.hua.spring_cloud_log.slf4j_logback_demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.AsyncRestTemplate;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
public class Slf4jLogbackDemoApplication {


    public static void main(String[] args) {
        SpringApplication.run(Slf4jLogbackDemoApplication.class, args);
    }

}
