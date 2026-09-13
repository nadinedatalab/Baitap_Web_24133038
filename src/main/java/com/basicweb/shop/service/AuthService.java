package com.basicweb.shop.service;

import com.basicweb.shop.entity.User;
import com.basicweb.shop.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EmailService emailService;
    
    public void registerUser(String email, String fullName, String password) {
        Optional<User> existingUser = userRepository.findByEmail(email);
        User user;
        if (existingUser.isPresent()) {
            user = existingUser.get();
            if (user.isActive()) {
                throw new RuntimeException("Email đã được sử dụng");
            }
        } else {
            user = new User();
            user.setEmail(email);
        }
        
        user.setFullName(fullName);
        user.setPassword(password);
        user.setActive(false);
        
        String otp = generateOtp();
        user.setOtpCode(otp);
        user.setOtpExpiryTime(LocalDateTime.now().plusMinutes(5));
        
        userRepository.save(user);
        
        emailService.sendOtpEmail(email, otp);
    }
    
    public boolean verifyOtp(String email, String otp) {
        Optional<User> optionalUser = userRepository.findByEmail(email);
        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            if (user.getOtpCode() != null && user.getOtpCode().equals(otp)) {
                if (user.getOtpExpiryTime().isAfter(LocalDateTime.now())) {
                    user.setActive(true);
                    user.setOtpCode(null);
                    user.setOtpExpiryTime(null);
                    userRepository.save(user);
                    return true;
                }
            }
        }
        return false;
    }
    
    public User login(String email, String password) {
        Optional<User> optionalUser = userRepository.findByEmail(email);
        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            if (user.getPassword().equals(password) && user.isActive()) {
                return user;
            }
        }
        return null;
    }
    
    public void generatePasswordResetOtp(String email) {
        Optional<User> optionalUser = userRepository.findByEmail(email);
        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            if (user.isActive()) {
                String otp = generateOtp();
                user.setOtpCode(otp);
                user.setOtpExpiryTime(LocalDateTime.now().plusMinutes(5));
                userRepository.save(user);
                
                emailService.sendOtpEmail(email, otp);
                return;
            }
        }
        throw new RuntimeException("Email không tồn tại hoặc chưa kích hoạt");
    }
    
    public boolean resetPassword(String email, String otp, String newPassword) {
        Optional<User> optionalUser = userRepository.findByEmail(email);
        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            if (user.getOtpCode() != null && user.getOtpCode().equals(otp) && user.getOtpExpiryTime().isAfter(LocalDateTime.now())) {
                user.setPassword(newPassword);
                user.setOtpCode(null);
                user.setOtpExpiryTime(null);
                userRepository.save(user);
                return true;
            }
        }
        return false;
    }
    
    private String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
}
