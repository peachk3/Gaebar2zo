package com.itwillbs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


   @RequestMapping(value ="/loginout/*")
   @Controller
   public class LoginController {

       @GetMapping("/loginout/login")
       public String loginPage() {
           return "/loginout/login";
       }
       

       @GetMapping("/loginout/main")
       public String mainPage() {
           return "/loginout/main";
       }
       
        @GetMapping("/loginout/accessErr")
           public String accessDenied() {
               return "/loginout/accessErr";
           }
       

   }
