package com.basicweb.shop.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
@SuppressWarnings("null")
public class EmailService {

    @Autowired
    private JavaMailSender javaMailSender;

    public void sendOtpEmail(String to, String otp) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            
            helper.setTo(to);
            helper.setSubject("Mã xác nhận OTP - Web Cơ Bản");
            
            String htmlContent = "<h3>Xin chào!</h3>"
                    + "<p>Mã OTP của bạn là: <strong style='font-size:24px; color:blue'>" + otp + "</strong></p>"
                    + "<p>Mã này sẽ hết hạn trong 5 phút.</p>";
            
            helper.setText(htmlContent, true);
            
            javaMailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
