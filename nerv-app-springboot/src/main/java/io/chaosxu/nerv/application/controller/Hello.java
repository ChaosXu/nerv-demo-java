package io.chaosxu.nerv.application.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author chaos
 */
@RestController
public class Hello {

    @RequestMapping("/")
    String home() {
        return "I'm a java app!";
    }
}
