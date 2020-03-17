package com.hua.spring_cloud_log.slf4j_logback_demo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class Controller {
    //    @Autowired
//    private RestTemplate restTemplate;
    private final static Logger logger = LoggerFactory.getLogger(Controller.class);

    @RequestMapping(value = "/echo-rest/{str}", method = RequestMethod.GET)
    public String rest(@PathVariable String str) {

        logger.info("java log test:slf4j+logback" + "  path variable:" + str);
        return "java log test:slf4j+logback" + "  path variable:" + str;

    }
}
